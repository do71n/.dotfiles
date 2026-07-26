return{
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
                skip_confirm_for_simple_edits = true;
            })
            -- use g. to open hidden file
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },
    {
        'nvim-mini/mini.nvim',
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
    }
}
