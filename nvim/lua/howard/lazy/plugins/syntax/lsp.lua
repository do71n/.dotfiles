return { "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "j-hui/fidget.nvim",
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                    { vim.fn.getcwd() },
                },
            },
        },
    },

    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_lsp.default_capabilities();

        require("fidget").setup({})
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "clangd",
            },
        })

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

        --- ============================ language server ============================
        vim.lsp.config("*", { capabilities = capabilities, })
        --- ======
        --- C
        --- ======
        vim.lsp.config("clangd", {
            capabilities = capabilities,
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--query-driver=C:/Users/dontin/scoop/apps/gcc/current/bin/gcc.exe",
            },
        })
        vim.lsp.enable("clangd")

    end
}
