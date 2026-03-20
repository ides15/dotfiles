local files = require("mini.files")

local show_hidden = true
local show_gitignore = false
local gitignored_paths = {}

vim.api.nvim_set_hl(0, "MiniFilesGitignored", { link = "Comment" })

local get_exclude_patterns = function()
    local git_dir = vim.fn.finddir(".git", ".;")
    if git_dir == "" then
        return {}
    end
    local exclude_file = git_dir .. "/info/exclude"
    if vim.fn.filereadable(exclude_file) == 0 then
        return {}
    end
    local patterns = {}
    for _, line in ipairs(vim.fn.readfile(exclude_file)) do
        if line ~= "" and not vim.startswith(line, "#") then
            table.insert(patterns, vim.trim(line))
        end
    end
    return patterns
end

local matches_exclude = function(entry, patterns)
    if entry.name:match("^%.env") then
        return true
    end
    for _, pattern in ipairs(patterns) do
        local p = pattern:gsub("/$", "")
        -- Check if entry path ends with the pattern
        if
            entry.path:match("/" .. vim.pesc(p) .. "$")
            or entry.path:match("/" .. vim.pesc(p) .. "/")
        then
            return true
        end
        if entry.name == p then
            return true
        end
    end
    return false
end

local filter = function(entry)
    local ignore = {
        [".DS_Store"] = true,
        -- [".git"] = true,
    }

    if ignore[entry.name] then
        return false
    end

    if not show_hidden and vim.startswith(entry.name, ".") then
        return false
    end

    return true
end

local sort = function(entries)
    local all_paths = table.concat(
        vim.iter(entries)
            :map(function(entry)
                return entry.path
            end)
            :totable(),
        "\n"
    )

    local output_lines = {}
    local job_id = vim.fn.jobstart(
        { "git", "check-ignore", "--stdin" },
        {
            stdout_buffered = true,
            on_stdout = function(_, data)
                output_lines = data
            end,
        }
    )

    if job_id < 1 then
        return files.default_sort(entries)
    end

    vim.fn.chansend(job_id, all_paths)
    vim.fn.chanclose(job_id, "stdin")
    vim.fn.jobwait({ job_id })

    for _, path in ipairs(output_lines) do
        gitignored_paths[path] = true
    end

    if show_gitignore then
        return files.default_sort(entries)
    end

    local exclude_patterns = get_exclude_patterns()

    return files.default_sort(vim.iter(entries)
        :filter(function(entry)
            if matches_exclude(entry, exclude_patterns) then
                return true
            end
            return not vim.tbl_contains(output_lines, entry.path)
        end)
        :totable())
end

local content = {
    filter = filter,
    sort = sort,
}

local toggle_hidden = function()
    show_hidden = not show_hidden

    files.refresh({ content = content })
end

local toggle_gitignore = function()
    show_gitignore = not show_gitignore
    gitignored_paths = {}

    files.refresh({ content = content })
end

files.setup({
    mappings = {
        close = "q",
        go_in = "L",
        go_in_plus = "l",
        go_out = "H",
        go_out_plus = "h",
        mark_goto = "'",
        mark_set = "m",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
    },
    windows = {
        width_focus = 40,
        width_nofocus = 40,
    },
    content = content,
})

-- Don't allow both picker and mini.files to be open at the same time
vim.api.nvim_create_autocmd("User", {
    pattern = { "PickerFiles", "PickerLiveGrep", "PickerResume" },
    callback = function()
        if files.get_explorer_state() then
            files.close()
        end
    end,
})

local open_file = function()
    local cur_target = files.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd("belowright vertical split")
        return vim.api.nvim_get_current_win()
    end)

    files.set_target_window(new_target)
    files.go_in({ close_on_file = true })
end

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id

        vim.keymap.set(
            "n",
            "<C-h>",
            toggle_hidden,
            { buffer = buf_id, desc = "Toggle hidden files" }
        )
        vim.keymap.set(
            "n",
            "<C-g>",
            toggle_gitignore,
            { buffer = buf_id, desc = "Toggle gitignored files" }
        )
        vim.keymap.set(
            "n",
            "<C-v>",
            open_file,
            { buffer = buf_id, desc = "Open file in vertical split" }
        )
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferUpdate",
    callback = function(args)
        local buf_id = args.data.buf_id
        local ns =
            vim.api.nvim_create_namespace("mini_files_gitignored")
        vim.api.nvim_buf_clear_namespace(buf_id, ns, 0, -1)

        ---@diagnostic disable-next-line: redundant-parameter
        local line_count = vim.api.nvim_buf_line_count(buf_id)
        for i = 1, line_count do
            local entry = files.get_fs_entry(buf_id, i)
            if entry and gitignored_paths[entry.path] then
                vim.api.nvim_buf_set_extmark(buf_id, ns, i - 1, 0, {
                    line_hl_group = "MiniFilesGitignored",
                })
            end
        end
    end,
})
