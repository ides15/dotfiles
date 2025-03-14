local files = require("mini.files")

local show_hidden = true
local show_gitignore = false

local filter = function(entry)
    local ignore = {
        [".DS_Store"] = true,
        [".git"] = true,
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
    if show_gitignore then
        return files.default_sort(entries)
    end

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

    -- Command failed to run
    if job_id < 1 then
        return entries
    end

    vim.fn.chansend(job_id, all_paths)
    vim.fn.chanclose(job_id, "stdin")
    vim.fn.jobwait({ job_id })

    return files.default_sort(vim.iter(entries)
        :filter(function(entry)
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

-- Give folders different colors
vim.api.nvim_set_hl(
    0,
    "MiniFilesDirectory",
    { fg = "#908caa", bold = true }
)
vim.api.nvim_set_hl(
    0,
    "MiniFilesFile",
    { fg = "#e0def4", bold = false }
)
vim.api.nvim_set_hl(0, "MiniFilesNormal", { bg = "#1A1825" })

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
