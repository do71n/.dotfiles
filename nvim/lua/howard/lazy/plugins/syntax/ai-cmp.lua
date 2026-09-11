return {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter", -- Lazy-load only when entering Insert mode
    config = function()
        require("supermaven-nvim").setup({
            -- 1. Keymaps for accepting and rejecting AI suggestions
            keymaps = {
                accept_suggestion = "<C-l>", -- Accept the full grey-text completion
                clear_suggestion = "<C-e>",  -- Dismiss the suggestion
                accept_word = "<C-j>",       -- Accept only the NEXT WORD of the suggestion
            },

            -- 2. Prevent Supermaven from fighting with nvim-cmp
            -- By default, suggestions render as inline grey "ghost text"
            disable_inline_completion = false,

            -- 3. Optionally disable Supermaven in certain filetypes
            disable_keymaps = false,
            condition = function()
                -- Return true to stop Supermaven in sensitive buffers (e.g., Markdown or text files)
                -- return vim.bo.filetype == "markdown"
                return false
            end,

            -- 4. Color styling for the grey preview text
            color = {
                suggestion = "#7f8c8d", -- Muted grey color for ghost text
                cterm = 244,
            },

            -- 5. Logging level (set to "off" or "warn" for a cleaner UI)
            log_level = "info",
        })
    end,
}
