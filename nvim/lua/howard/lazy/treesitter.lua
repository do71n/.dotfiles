return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",          -- the rewrite (Neovim 0.12+)
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            -- main branch setup only manages parser install dir; no modules
            require("nvim-treesitter").setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            -- Install parsers asynchronously (no-op if already installed)
            require("nvim-treesitter").install({
                "vimdoc", "javascript", "typescript", "c", "lua",
                "rust", "jsdoc", "bash", "cpp",
            })

            -- Enable highlighting + indentation per filetype (Neovim core APIs)
            -- main branch removed the module framework; we do it via autocmd now
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("TreesitterEnable", {}),
                callback = function()
                    -- pcall swallows errors for filetypes without an installed parser
                    pcall(vim.treesitter.start)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            -- Custom templ parser registration (main branch API: User TSUpdate autocmd)
            vim.api.nvim_create_autocmd("User", {
                pattern = "TSUpdate",
                group = vim.api.nvim_create_augroup("TemplParser", {}),
                callback = function()
                    require("nvim-treesitter.parsers").templ = {
                        install_info = {
                            url = "https://github.com/vrischmann/tree-sitter-templ.git",
                            files = { "src/parser.c", "src/scanner.c" },
                            branch = "master",
                        },
                    }
                end,
            })
            vim.treesitter.language.register("templ", { "templ" })

            -- treesitter-context is a separate plugin; keep its setup as-is
            require("treesitter-context").setup({ enable = true })
        end,
    },
}
