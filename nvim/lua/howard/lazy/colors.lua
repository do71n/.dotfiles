function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

 	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
 	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end


return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
             })
        end
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                variant = "moon",
                styles = {
                    italics = false;
                    transparency = true;
                },
                highlight_groups = {
                    Comment = { fg = "subtle" },
                    StatusLineNC = { fg = "muted", bg = "surface" },
                    StatusLine = { fg = "subtle", bg = "surface" },
                    NormalFloat = { fg = "subtle", bg = "surface" },
                    -- Pmenu = { fg = "subtle", bg = "surface" },
                },
            })

            ColorMyPencils("rose-pine")

            -- ============ custom snippest for switching comments colors ============ --
            local read_comment_mode = false
            local antirez_highlight = "#B9CA4A"
            local default_comment_fg

            local function change_comment_color(on)
                if default_comment_fg == nil then
                    default_comment_fg = vim.api.nvim_get_hl(0, { name = "Comment", link = false }).fg
                end
                if on then
                    vim.api.nvim_set_hl(0, "Comment", { fg = antirez_highlight })
                else
                    vim.api.nvim_set_hl(0, "Comment", { fg = default_comment_fg })
                end
            end

            vim.api.nvim_create_user_command("Rdc", function()
                read_comment_mode = not read_comment_mode
                change_comment_color(read_comment_mode)
            end, { nargs = 0 })
        end
    },

    {
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato",
                transparent_background = true,
            })
        end
    },

}


