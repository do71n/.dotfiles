return{
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 30,
                    relativenumber = true, -- Great for jumping between files
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
            })

            vim.keymap.set('n', '<leader>nt', '<CMD>NvimTreeToggle<CR>', { silent = true, desc = "Toggle NvimTree" })
        end,
    },

    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                experimental_watch_for_changes = true,
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
    }
}
