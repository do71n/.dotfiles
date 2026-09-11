return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                experimental_watch_for_changes = true,
                view_options = {
                    show_hidden = true,
                    sort = {
                        { "type", "asc" },
                        { "name", "asc" },
                    },
                },
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
            })
            -- use g. to open hidden file
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "MunifTanjim/nui.nvim", -- Keep this: powers Neo-tree's UI prompts
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = true,
                    },
                    hijack_netrw_behavior = "open_default",
                    window = {
                        mappings = {
                            ["l"]    = "open",
                            ["h"]    = "close_node",
                        }
                    }
                }
            })
            -- Toggle the file explorer with <leader>e
            vim.keymap.set('n', '<leader>E', '<Cmd>Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })
        end,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
            -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(3) end)
            -- vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
        end
    }
}
