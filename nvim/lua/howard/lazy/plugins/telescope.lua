return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            "jvgrootveld/telescope-zoxide",
        },

        config = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')

            telescope.setup({
                extensions = {
                    fzf = {},
                    zoxide = {
                        prompt_title = "pick directory",
                        mappings = {
                            default = {
                                keepinsert = false,
                                action = function(selection)
                                    vim.cmd("tabnew")
                                    vim.cmd("tcd " .. vim.fn.fnameescape(selection.path))
                                    builtin.find_files({ cwd = selection.path })
                                end,
                            },
                        },
                    },
                }
            })

            telescope.load_extension('fzf')
            telescope.load_extension('ui-select')
            telescope.load_extension('zoxide')
            telescope.load_extension('scope')

            -- file or folder searching
            vim.keymap.set("n", "<leader>fz", telescope.extensions.zoxide.list)
            vim.keymap.set('n', '<leader>fp', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})

            -- String Greping
            vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>bg', builtin.current_buffer_fuzzy_find, {})
            vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope Git status' })
            vim.keymap.set('n', '<leader>sg', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)

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

            -- references
            vim.keymap.set('n', 'gr', builtin.lsp_references, {}) -- gr -> go reference

            -- Buffer management
            vim.keymap.set('n', '<leader>fb', function() builtin.buffers({ cwd = vim.fn.getcwd() }) end)
            vim.keymap.set("n", "<leader>fa", telescope.extensions.scope.buffers, { desc = "All-tab buffers" })
        end
    },
}
