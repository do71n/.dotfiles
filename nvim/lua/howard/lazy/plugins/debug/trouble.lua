return {
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {}, -- Your default or custom settings
        keys = {
            -- 1. The Toggle
            {
                "<leader>tt",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },

            -- 2. GLOBAL JUMP NEXT (Works from any window)
            {
                "<leader>tn",
                function()
                    -- This function works even if your cursor is in the editor
                    require("trouble").next({ skip_groups = true, jump = true })
                end,
                desc = "Next Trouble Item",
            },

            -- 3. GLOBAL JUMP PREV (Works from any window)
            {
                "<leader>tp",
                function()
                    -- This function works even if your cursor is in the editor
                    require("trouble").prev({ skip_groups = true, jump = true })
                end,
                desc = "Previous Trouble Item",
            },
        },
    }
}
