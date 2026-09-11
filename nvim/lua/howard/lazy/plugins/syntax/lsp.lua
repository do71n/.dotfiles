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
            update_in_insert = false,
            underline = { severity = { min = vim.diagnostic.severity.ERROR } },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '',
                    [vim.diagnostic.severity.WARN] = '',
                    [vim.diagnostic.severity.INFO] = '',
                    [vim.diagnostic.severity.HINT] = '',
                },
                numhl = {
                    [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
                    [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
                    [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
                }
            },
            severity_sort = true,
            virtual_text = {
                prefix = "●",
                spacing = 2,
                severity = vim.diagnostic.severity.ERROR
            },
            virtual_lines = { current_line = true },
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "clangd",
                "cssls",
                "rust_analyzer",
                "ts_ls",
                "pyright",
                "texlab",
            },
        })

        --- ============================ language server ============================
        vim.lsp.config("*", { capabilities = capabilities, }) -- enable capabilities for all lsp

        --- ======
        --- C
        --- ======
        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--query-driver=C:/Users/dontin/scoop/apps/gcc/current/bin/gcc.exe",
            },
        })

        --- ======
        --- Lua
        --- ======
        vim.lsp.config("lua_ls", {
            on_init = function(client)
                client.server_capabilities.colorProvider = false -- pass the handle to highlight-color.nvim
            end,
        })

        --- ======
        --- CSS
        --- ======
        vim.lsp.config("cssls", {
            cmd = { "vscode-css-language-server", "--stdio" },
            filetypes = { "css", "scss", "less" },
            on_init = function(client)
                client.server_capabilities.colorProvider = false -- pass the handle to highlight-color.nvim
            end,
        })

        --- ======
        --- Rust
        --- ======
        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    inlayHints = {
                        typeHints = { enable = true },

                        parameterHints = { enable = false },
                        chainingHints = { enable = false },
                        bindingModeHints = { enable = false },
                        closureReturnTypeHints = { enable = "never" },
                        lifetimeElisionHints = { enable = "never" },
                        reborrowHints = { enable = false },
                        closingBraceHints = { enable = false },
                    },
                },
            },
        })

        --- ==========
        --- Typescript
        --- ==========
        vim.lsp.config("ts_ls", {
            filetypes = {
                "typescript",
                "typescriptreact",
                "javascript",
                "javascriptreact",
            },
            single_file_support = true,
        })

        --- ======
        --- Python
        --- ======
        vim.lsp.config("pyright", {
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic", -- "strict" | "basic" | "off"
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })

        --- ======
        --- LaTeX
        --- ======
        vim.lsp.config("texlab", {
            settings = {
                texlab = {
                    build = {
                        onSave = true,
                        forwardSearchAfter = true,
                    },
                    forwardSearch = {
                        executable = "zathura",
                        args = { "--synctex-forward", "%l:1:%f", "%p" },
                    },
                    chktex = { onOpenAndSave = true },
                },
            },
        })

        --- ======
        --- qml
        --- ======
        vim.lsp.config("qmlls", {
            cmd = { "qmlls6" },
            filetypes = { "qml", "qmljs" },
            root_markers = { ".git", "shell.qml", "qmldir" },
            on_init = function(client)
                if client.server_capabilities then
                    client.server_capabilities.semanticTokensProvider = nil
                end
            end
        })

        vim.lsp.enable({
            "clangd",
            "lua_ls",
            "cssls",
            "rust_analyzer",
            "ts_ls",
            "pyright",
            "texlab",
            "qmlls",
        })



    end
}
