return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" }, -- Load when you open a file
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- Map your filetypes to the specific CLI linters
      c = { "cppcheck" },
      cpp = { "cppcheck" },
      -- python = { "pylint" },
    }

    -- Create an autocommand to trigger linting silently in the background
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
