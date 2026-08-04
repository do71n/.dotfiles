return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                experimental_watch_for_changes = true,
                view_options = {
                    show_hidden = true
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
        'nvim-mini/mini.files',
        version = false, -- Use the main branch for the latest features and bug fixes
        config = function()
            -- Only load the file explorer module
            require('mini.files').setup({
                mappings = {
                    close       = 'q',
                    go_in       = 'l',
                    go_in_plus  = '<CR>',
                    go_out      = 'h',
                    go_out_plus = '<BS>',
                },
                -- Set to true if you want it to use your Nerd Font devicons
                use_as_default_explorer = true,
            })

            -- Toggle the file explorer with <leader>e
            vim.keymap.set('n', '<leader>e', '<Cmd>lua MiniFiles.open()<CR>', { desc = 'Open Mini Files' })
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

            vim.keymap.set("n", "<C-f>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-s>", function() harpoon:list():select(2) end)
            -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(3) end)
            -- vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
        end
    }
}
