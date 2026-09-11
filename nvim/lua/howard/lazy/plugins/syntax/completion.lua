return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline", -- complement with mini.cmdline
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "dmitmel/cmp-cmdline-history",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind.nvim",
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        -- vim.o.winborder = "rounded"

        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')

        -- autocompletion with lausnip
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,noinsert", -- allow auto-select
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                documentation = cmp.config.window.bordered({ border = "rounded" }),
                completion = cmp.config.window.bordered({ border = "rounded", max_height = 20 }), -- Keeps the popup box from growing taller than 10 lines
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ["<C-f>"] = cmp.mapping.scroll_docs(5),
                ["<C-b>"] = cmp.mapping.scroll_docs(-5),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'buffer' },  -- word suggestion from current buffer
                { name = 'path' }
            }),
            formatting = {
                format = function(entry, item)
                    local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })

                    item = lspkind.cmp_format({
                        maxwidth = 50,         -- 1. Truncates long completion items
                        ellipsis_char = "...", -- 2. Appends '...' when truncated
                    })(entry, item)

                    if color_item.abbr_hl_group then
                        item.kind_hl_group = color_item.abbr_hl_group
                        item.kind = color_item.abbr
                    end

                    return item
                end,
            },
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
                { name = "cmdline_history" },
            },
        })
    end
}
