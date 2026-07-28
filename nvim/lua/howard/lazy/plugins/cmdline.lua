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

            autocorrect = {
                enable = false,
            },

            autopeek = {
                enable = true,
                n_context = 1, -- Shows 1 line of extra context above and below your target range
            },
        })
    end,
}
