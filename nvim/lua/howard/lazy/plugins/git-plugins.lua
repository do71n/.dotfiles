return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gp", "<CMD>Git<CR>")
        end
    }
}
