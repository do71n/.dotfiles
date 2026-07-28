return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",          -- the rewrite (Neovim 0.12+)
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "windwp/nvim-ts-autotag",
        },
        config = function()
            -- main branch setup only manages parser install dir; no modules.
            -- install_dir must be passed explicitly: setup() prepends it to
            -- 'runtimepath' so nvim's parser lookup finds freshly installed
            -- parsers there. Without this, installed parsers are invisible.
            local install_dir = vim.fn.stdpath("data") .. "/site"
            local ts = require("nvim-treesitter")
            ts.setup({ install_dir = install_dir })

            -- nvim-treesitter (main) ships queries under <plugin>/runtime/queries
            -- but does NOT add <plugin>/runtime to 'runtimepath' itself. Without
            -- this, nvim's query system can't find e.g. indents.scm for lua,
            -- causing treesitter indentexpr to return 0 (overriding smartindent
            -- and breaking brace indentation). Append it here so nvim core
            -- queries still take precedence (they appeared earlier on rtp).
            local ts_src = debug.getinfo(ts.setup, "S").source
            local ts_runtime = vim.fn.fnamemodify(ts_src:sub(2), ":p:h:h:h") .. "/runtime"
            if vim.uv.fs_stat(ts_runtime) then
                vim.opt.rtp:append(ts_runtime)
            end

            -- Register Haskell aliases (literate Haskell .lhs files)
            vim.treesitter.language.register("haskell", { "lhaskell" })

            -- Install only the parsers we don't already have, so we don't
            -- re-download on every startup.
            local ensure_installed = {
                "json",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "html",
                "kdl",
                "toml",
                "css",
                "prisma",
                "markdown",
                "markdown_inline",
                "graphql",
                "bash",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "query",
                "vimdoc",
                "c",
                "cpp",
                "haskell",
                "rust",
                "jsdoc",
            }

            local installed = require("nvim-treesitter.config").get_installed()
            local missing = vim.iter(ensure_installed):filter(function(lang)
                return not vim.tbl_contains(installed, lang)
            end):totable()

            if #missing > 0 then
                ts.install(missing)
            end

            -- Enable highlighting + indentation per filetype (Neovim core APIs)
            -- main branch removed the module framework; we do it via autocmd now
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("TreesitterEnable", { clear = true }),
                callback = function()
                    -- pcall swallows errors for filetypes without an installed parser
                    pcall(vim.treesitter.start)
                    -- Only hand indenting to treesitter if there's an indents
                    -- query for this filetype; otherwise leave smartindent /
                    -- cindent in charge so e.g. `{` Enter still indents.
                    local ft = vim.bo.filetype
                    if ft ~= "" and vim.treesitter.query.get(ft, "indents") then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })

            -- treesitter-context is a separate plugin; keep its setup as-is
            require("treesitter-context").setup({ enable = true })

            -- Initialize autotag (required on main branch)
            require("nvim-ts-autotag").setup()
        end,
    },
}
