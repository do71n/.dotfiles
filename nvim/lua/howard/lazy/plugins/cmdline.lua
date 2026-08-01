return {
    'nvim-mini/mini.cmdline',
    version = false,
    config = function()
        vim.opt.pumheight = 10

        require('mini.cmdline').setup({
            autocomplete = {
                enable = true,
                delay = 50,
            },

            autopeek = {
                enable = true,
                n_context = 3, -- Shows 1 line of extra context above and below your target range
            },

            autocorrect = {
                enable = false,
            },
        })
    end,
}
