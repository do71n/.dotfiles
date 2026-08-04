return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.ai").setup()
            require("mini.surround").setup()
            require("mini.cursorword").setup({ delay = 50 })
            require("mini.tabline").setup({})
            require("mini.indentscope").setup({ })
        end,
    },
}
