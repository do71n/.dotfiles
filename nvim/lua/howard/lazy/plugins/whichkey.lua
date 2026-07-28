return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern", -- floating windows
        delay = 200,
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
