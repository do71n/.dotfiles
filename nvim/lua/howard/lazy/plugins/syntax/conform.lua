return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Load when you are about to save a file
    keys = {
        {
            "<leader>f",
            function()
                -- lsp_fallback = true is the magic that replaces your old vim.lsp.buf.format map
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = { "n", "v" },
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            -- Map your filetypes to the specific CLI formatters you want to use
            c = { "clang-format" },
            cpp = { "clang-format" },
            lua = { "stylua" },
            -- Example: If you write web or script stuff
            -- python = { "isort", "black" },
            -- javascript = { "prettierd", "prettier", stop_after_first = true },

            -- NOTE: Rust is intentionally missing here because rust-analyzer handles natively (lsp_fallback = true
        },
        formaters = {
            clang_format = {
                prepend_args = { '--style={BasedOnStyle: LLVM, IndentWidth: 4, BreakBeforeBraces: Custom, BraceWrapping: {AfterFunction: true}}' },
            }
        }
        -- Optional: Uncomment this if you want it to format every time you save
        -- format_on_save = {
        --   timeout_ms = 500,
        --   lsp_fallback = true,
        -- },
    },
}
