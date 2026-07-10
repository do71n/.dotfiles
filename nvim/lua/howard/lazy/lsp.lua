return { "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        -- "hrsh7th/cmp-buffer",
        -- "hrsh7th/cmp-path",
        -- "hrsh7th/cmp-cmdline",
        -- "hrsh7th/nvim-cmp",
        -- "L3MON4D3/LuaSnip",
        -- "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                    { path = "/usr/share/awesome/lib/", words = { "awesome" } },
                    { "${3rd}/love2d/library" },
                    { vim.fn.getcwd() },
                    { "/Users/dontin/Documents/Personal/Game/myGame/libs" },

                },
            },
        },
    },


    config = function()
        -- local cmp = require('cmp')
        -- local lspconfig = require("lspconfig")
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require("lspconfig")

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
            },
            -- handlers = {
            --     function(server_name) -- default handler (optional)
            --         require("lspconfig")[server_name].setup {
            --             capabilities = capabilities
            --         }
            --     end,
            --     ["lua_ls"] = function()
            --         lspconfig.lua_ls.setup({
            --             lua_ls = {
            --                 workspace = {
            --                     checkThirdParty = false,
            --                     library = {
            --                         "${3rd}/love2d/library"
            --                     },
            --                 }
            --             }
            --         })
            --     end,
            -- },

            -- fix for This tells mason-lspconfig to auto-enable only lua_ls — clangd won't be auto-attached
            automatic_enable = { "lua_ls" },
        })

        lspconfig.clangd.setup({
            capabilities = capabilities,
            cmd = {
                "clangd",
                -- target the gcc binary installed via Scoop.
                "--query-driver=C:/Users/Kwa30417/scoop/apps/gcc/current/bin/gcc.exe",
            },
        })
        -- lspconfig.lua_ls.setup({
        --     capabilities = capabilities,
        --     settings = {
        --         Lua = {
        --             workspace = {
        --                 library = {
        --                     "${3rd}/love2d/library"
        --                 },
        --             }
        --         }
        --     },
        -- })

        -- autocompletion with lausnip
        --local cmp_select = { behavior = cmp.SelectBehavior.Select }

        --cmp.setup({
        --    snippet = {
        --        expand = function(args)
        --            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        --        end,
        --    },
        --    window = {
        --        completion = cmp.config.window.bordered(),
        --        documentation = cmp.config.window.bordered(),
        --    },
        --    mapping = cmp.mapping.preset.insert({
        --        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        --        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        --        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        --        ["<C-space>"] = cmp.mapping.complete(),
        --    }),

        --    sources = cmp.config.sources({
        --        { name = 'nvim_lsp' },
        --        { name = 'luasnip' }, -- For luasnip users.

        --    }, {
        --            { name = 'buffer' },
        --        })
        --})

        -- diagnostic text
        vim.diagnostic.config({
            update_in_insert = true,
            virtual_text = {
                virtual_text = false,
                virtual_lines = true,
                -- current_lines = true
            },
            underline = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

    end
}
