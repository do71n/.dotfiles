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

        -- Set LSP Keymaps once an LSP server attaches to the buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup("LspConfig", {}),
            callback = function(e)
                local opts = { buffer = e.buf }
                -- Press shift + K to open documentation
                vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count = 1}) end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count = -1}) end, opts)
            end
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
