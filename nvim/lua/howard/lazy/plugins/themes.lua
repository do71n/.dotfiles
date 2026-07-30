return {
    {
        "folke/tokyonight.nvim",
        {
            "rose-pine/neovim",
            name = "rose-pine",
            priority = 1000,
            config = function()
                require('rose-pine').setup({
                    variant = "moon",
                    styles = {
                        italics = false,
                        transparency = not vim.g.neovide,
                    },
                    highlight_groups = {
                        Comment = { fg = "subtle" },
                        StatusLineNC = { fg = "muted", bg = "surface" },
                        StatusLine = { fg = "subtle", bg = "surface" },
                        NormalFloat = { fg = "subtle", bg = "surface" },
                        ["@keyword.operator"] = { fg = "pine" },
                    },
                })

                local theme = require("howard.helper.theme")
                theme.setup()
                theme.apply("rose-pine")
            end
        },
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,
                terminal_colors = not vim.g.neovide,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
            })
        end
    },
    {
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato",
                transparent_background = not vim.g.neovide,
            })
        end
    },
}
