return {
    "glepnir/galaxyline.nvim",
    config = function()
        local gl = require("galaxyline")
        local gls = gl.section
        local colors =
            require("catppuccin.palettes").get_palette("mocha")

        local modes = {
            n = "NORMAL",
            i = "INSERT",
            v = "VISUAL",
            V = "V-LINE",
            ["\22"] = "V-BLOCK",
            c = "COMMAND",
            R = "REPLACE",
            t = "TERMINAL",
        }

        local mode_colors = {
            n = colors.blue,
            i = colors.green,
            v = colors.mauve,
            V = colors.mauve,
            ["\22"] = colors.mauve,
            c = colors.peach,
            R = colors.red,
            t = colors.teal,
        }

        gl.colors = { bg = colors.base }

        vim.api.nvim_set_hl(
            0,
            "StatusLine",
            { bg = colors.base, fg = colors.text }
        )
        vim.api.nvim_set_hl(
            0,
            "StatusLineNC",
            { bg = colors.base, fg = colors.text }
        )
        vim.cmd("hi GalaxyLineFillSection guibg=" .. colors.base)
        vim.api.nvim_set_hl(
            0,
            "GalaxyLsp",
            { fg = colors.overlay0, bg = colors.base, italic = true }
        )
        vim.api.nvim_set_hl(
            0,
            "GalaxyFileType",
            { fg = colors.yellow, bg = colors.base }
        )
        vim.api.nvim_set_hl(
            0,
            "GalaxySearch",
            { fg = colors.green, bg = colors.base }
        )
        vim.api.nvim_set_hl(
            0,
            "GalaxyPosition",
            { fg = colors.blue, bg = colors.base }
        )
        vim.api.nvim_set_hl(
            0,
            "GalaxyFileSize",
            { fg = colors.lavender, bg = colors.base }
        )

        gls.left[1] = {
            Mode = {
                provider = function()
                    local mode = vim.fn.mode()
                    local color = mode_colors[mode] or colors.blue

                    vim.api.nvim_set_hl(
                        0,
                        "GalaxyMode",
                        { fg = color, bg = colors.base, bold = true }
                    )

                    return "  " .. (modes[mode] or mode) .. " "
                end,
                highlight = "GalaxyMode",
            },
        }

        gls.left[2] = {
            Git = {
                provider = function()
                    local branch = vim.b.gitsigns_head
                    if not branch then
                        return ""
                    end

                    local ok, icons = pcall(require, "mini.icons")
                    local icon = ok and icons.get("filetype", "git")
                        or ""

                    -- Match lazygit branch color patterns
                    local is_main = branch:match("^main$")
                        or branch:match("^master$")
                        or branch:match("^mainline$")
                        or branch:match("^release")
                        or branch:match("^dev$")
                        or branch:match("^staging$")
                    if is_main then
                        vim.api.nvim_set_hl(0, "GalaxyGit", {
                            fg = "#7e9cd8",
                            bg = colors.base,
                            bold = true,
                        })
                    else
                        vim.api.nvim_set_hl(
                            0,
                            "GalaxyGit",
                            { fg = colors.overlay2, bg = colors.base }
                        )
                    end

                    return "  " .. icon .. " " .. branch .. "  "
                end,
                highlight = "GalaxyGit",
            },
        }

        vim.api.nvim_set_hl(
            0,
            "GalaxyDiagOk",
            { fg = colors.green, bg = colors.base }
        )
        vim.api.nvim_set_hl(
            0,
            "GalaxyDiagError",
            { fg = colors.red, bg = colors.base }
        )
        vim.api.nvim_set_hl(
            0,
            "GalaxyDiagWarn",
            { fg = colors.yellow, bg = colors.base }
        )
        vim.api.nvim_set_hl(
            0,
            "GalaxyDiagInfo",
            { fg = colors.blue, bg = colors.base }
        )
        vim.api.nvim_set_hl(
            0,
            "GalaxyDiagHint",
            { fg = colors.teal, bg = colors.base }
        )

        gls.left[3] = {
            DiagOk = {
                provider = function()
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    if #clients == 0 then
                        return ""
                    end

                    local total = #vim.diagnostic.get(0)
                    if total == 0 then
                        return " "
                    end

                    return ""
                end,
                highlight = "GalaxyDiagOk",
            },
        }

        gls.left[4] = {
            DiagError = {
                provider = function()
                    local count = #vim.diagnostic.get(
                        0,
                        { severity = vim.diagnostic.severity.ERROR }
                    )
                    if count > 0 then
                        return " " .. count .. " "
                    end

                    return ""
                end,
                highlight = "GalaxyDiagError",
            },
        }

        gls.left[5] = {
            DiagWarn = {
                provider = function()
                    local count = #vim.diagnostic.get(
                        0,
                        { severity = vim.diagnostic.severity.WARN }
                    )
                    if count > 0 then
                        return " " .. count .. " "
                    end

                    return ""
                end,
                highlight = "GalaxyDiagWarn",
            },
        }

        gls.left[6] = {
            DiagInfo = {
                provider = function()
                    local count = #vim.diagnostic.get(
                        0,
                        { severity = vim.diagnostic.severity.INFO }
                    )
                    if count > 0 then
                        return " " .. count .. " "
                    end

                    return ""
                end,
                highlight = "GalaxyDiagInfo",
            },
        }

        gls.left[7] = {
            DiagHint = {
                provider = function()
                    local count = #vim.diagnostic.get(
                        0,
                        { severity = vim.diagnostic.severity.HINT }
                    )
                    if count > 0 then
                        return "󱠡 " .. count .. " "
                    end

                    return ""
                end,
                highlight = "GalaxyDiagHint",
            },
        }

        gls.right[1] = {
            Lsp = {
                provider = function()
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    if #clients == 0 then
                        return ""
                    end

                    local names = {}
                    for _, c in ipairs(clients) do
                        table.insert(names, c.name)
                    end

                    return " "
                        .. table.concat(names, ", ")
                        .. "   "
                end,
                highlight = "GalaxyLsp",
            },
        }

        gls.right[2] = {
            Macro = {
                provider = function()
                    local reg = vim.fn.reg_recording()
                    if reg ~= "" then
                        return " @" .. reg .. " "
                    end

                    return ""
                end,
            },
        }

        gls.right[3] = {
            FileType = {
                provider = function()
                    local ft = vim.bo.filetype
                    if ft == "" or ft:match("picker") then
                        return ""
                    end

                    local ok, icons = pcall(require, "mini.icons")
                    if ok then
                        local icon = icons.get("filetype", ft)
                        if icon then
                            return " " .. ft .. " " .. icon .. " "
                        end
                    end

                    return " " .. ft .. " "
                end,
                highlight = "GalaxyFileType",
            },
        }

        gls.right[4] = {
            Search = {
                provider = function()
                    if vim.v.hlsearch == 0 then
                        return ""
                    end

                    local ok, result =
                        pcall(vim.fn.searchcount, { maxcount = 999 })
                    if not ok or result.total == 0 then
                        return ""
                    end

                    return " "
                        .. result.current
                        .. "/"
                        .. result.total
                        .. "  "
                end,
                highlight = "GalaxySearch",
            },
        }

        gls.right[5] = {
            Position = {
                provider = function()
                    local line = vim.fn.line(".")
                    local col = vim.fn.col(".")

                    return " " .. line .. ":" .. col .. "  "
                end,
                highlight = "GalaxyPosition",
            },
        }

        gls.right[6] = {
            FileSize = {
                provider = function()
                    local size = vim.fn.getfsize(vim.fn.expand("%"))
                    if size < 0 then
                        return ""
                    end

                    if size < 1024 then
                        return " " .. size .. "B  "
                    end

                    if size < 1048576 then
                        return " "
                            .. string.format("%.1fK", size / 1024)
                            .. "  "
                    end

                    return " "
                        .. string.format("%.1fM", size / 1048576)
                        .. "  "
                end,
                highlight = "GalaxyFileSize",
            },
        }
    end,
}
