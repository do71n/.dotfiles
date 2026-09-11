return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Optional, for file icons
    config = function()
        local function buffer_number()
            return string.format('[b%d]', vim.api.nvim_get_current_buf())
        end

        local function mode_or_buffer()
            local mode = vim.api.nvim_get_mode().mode
            -- NORMAL: persist the buffer number;
            if mode == 'n' or mode == 'nt' then
                return buffer_number()
            end
            -- MODES: use the mode label
            local modes = {
                i = 'I', ic = 'I',
                v = 'V', V = 'V-LINE', ['\22'] = 'V-BLOCK',
                c = 'CMD', R = 'R', t = 'T',
            }
            return modes[mode] or mode:upper()
        end

        local function line_total()
            return string.format('%d/%d', vim.fn.line('.'), vim.fn.line('$'))
        end

        local function column_number()
            return string.format('[col %d]', vim.fn.col('.'))
        end

        local function hex_under_cursor()
            local char = vim.fn.matchstr(vim.fn.getline('.'), '\\%' .. vim.fn.col('.') .. 'c.')
            if char == '' then
                return 'Hex:0x00'
            end
            return string.format('Hex:0x%02X', vim.fn.char2nr(char))
        end

        -- local left_sep_semi = ''
        local left_sep_faded = vim.g.neovide and '░▒▓' or '▓▒░'
        require('lualine').setup({
            options = {
                theme = 'auto',
                icons_enabled = true,
                component_separators = { left = '', right = '' },
                section_separators = { left = left_sep_faded, right = '' },
                disabled_filetypes = {
                    statusline = { 'lazygit', },
                },
            },
            sections = {
                lualine_a = {
                    { mode_or_buffer, color = { gui = 'bold' } },
                },
                lualine_b = {
                    { 'branch', icon = '', color = { gui = 'bold' } },
                    { 'diff', symbols = { added = '+', modified = '~', removed = '-' }, colored = true },
                    'fileformat',
                    { 'filetype', icon_only = true, separator = { right = ''}, draw_empty = true },
                },
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                        symbols = { modified = ' [+]', readonly = ' [r]', unnamed = '[No Name]' },
                    },
                },
                lualine_x = {
                    'encoding',
                },
                lualine_y = {
                    line_total,
                    column_number,
                },
                lualine_z = {
                    hex_under_cursor,
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { line_total },
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}
