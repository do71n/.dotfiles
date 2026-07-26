return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",

        tag = "v0.2.2",

        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },

        config = function()
            require('telescope').setup({
                extensions = {
                    fzf = {},
                }
            })
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('ui-select')
            local builtin = require('telescope.builtin')

            -- frequently used
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fp', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope Git status' })
            vim.keymap.set('n', '<leader>sg', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)

            vim.keymap.set('n', 'gr', builtin.lsp_references, {})

            -- find the **current** word
            vim.keymap.set('n', '<leader>fcw', function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end)

            vim.keymap.set('n', '<leader>fcW', function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end)

            -- nvim specific documentation
            vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>man', builtin.man_pages, {})
        end
    },
}
