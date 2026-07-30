return {
   'brenoprata10/nvim-highlight-colors',
    config = function()
        require('nvim-highlight-colors').setup({
            render = 'virtual',       -- Uses a symbol instead of painting the text background
            virtual_symbol = '●',
            virtual_symbol_position = 'eow',
            virtual_symbol_prefix = ' ',
            virtual_symbol_suffix = ' ',
            enable_short_hex = false,
            enable_tailwind = true,
            enable_named_colors = true,
            -- exclude_filetypes = {},
        })
    end,
}
