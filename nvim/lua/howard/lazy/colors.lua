local antirez_comment = "#B9CA4A"

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
            }) end },
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
                    Comment = { fg = antirez_comment },
                    StatusLineNC = { fg = "muted", bg = "surface" },
                    StatusLine = { fg = "subtle", bg = "surface" },
                    NormalFloat = { fg = "subtle", bg = "surface" },
                    -- Pmenu = { fg = "subtle", bg = "surface" },
                },
            })

            ColorMyPencils("rose-pine")

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


