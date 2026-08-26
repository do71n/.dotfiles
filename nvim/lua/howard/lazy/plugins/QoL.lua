return {
    {
        "tiagovla/scope.nvim",
        config = function()
            require("scope").setup({})
        end,
    },
    {
        "nvim-mini/mini.nvim",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.ai").setup()
            require("mini.surround").setup()
            require("mini.cursorword").setup({ delay = 50 })
            require("mini.tabline").setup({})
            require("mini.indentscope").setup({})
            require("mini.icons").setup()

            vim.keymap.set("n", "<leader>bd", function() require("mini.bufremove").delete(0, false) end)
        end,
    },
}
