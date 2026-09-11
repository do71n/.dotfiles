return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "MeanderingProgrammer/render-markdown.nvim",
            opts = { file_types = { "markdown", "Avante" } },
            ft = { "markdown", "Avante" },
        },
    },
    opts = {
        -- Default model on startup. Change to "kimi-k3" or "minimax-m3" if you prefer.
        provider = "glm-5.2",
        mode = "agentic",
        behaviour = {
            auto_approve_tool_permissions = false,
            auto_apply_diff_after_generation = false,
            auto_set_highlight_group = true,
            minimize_diff = true,
            auto_suggestions = false,
            confirmation_ui_style = "inline_buttons",
        },
        providers = {
            -- GLM-5.2 (OpenAI-compatible endpoint)
            ["glm-5.2"] = {
                __inherited_from = "openai",
                endpoint = "https://opencode.ai/zen/go/v1",
                model = "glm-5.2",
                api_key_name = "OPENCODE_GO_API_KEY",
                timeout = 30000,
                extra_request_body = {
                    temperature = 0.75,
                    max_tokens = 8192,
                },
            },
            -- Kimi K3 (OpenAI-compatible endpoint)
            ["kimi-k3"] = {
                __inherited_from = "openai",
                endpoint = "https://opencode.ai/zen/go/v1",
                model = "kimi-k3",
                api_key_name = "OPENCODE_GO_API_KEY",
                timeout = 30000,
                extra_request_body = {
                    temperature = 0.75,
                    max_tokens = 8192,
                },
            },
            -- MiniMax M3 (Anthropic-style endpoint - uses /v1/messages)
            ["minimax-m3"] = {
                __inherited_from = "claude",
                endpoint = "https://opencode.ai/zen/go",
                model = "minimax-m3",
                api_key_name = "OPENCODE_GO_API_KEY",
                timeout = 30000,
                extra_request_body = {
                    temperature = 0.75,
                    max_tokens = 8192,
                },
            },
        },
    },
}
