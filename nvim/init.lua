if vim.g.neovide then
    vim.g.neovide_opacity = 0.95
    vim.g.neovide_corner_preference = "round"

	if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        vim.g.neovide_title_background_color = "#191724" -- match Rosé Pine
    end
end

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    vim.o.shell = "pwsh"
    vim.g.undotree_DiffCommand = 'C:/Program Files/Git/usr/bin/diff.exe' -- hardcoded path, updated for actual diff.exe location

    -- Allow Ctrl+V to paste in Insert mode and Command-line mode, Normal mode and neovim terminal
    vim.keymap.set({ 'i', 'c' }, '<C-v>', '<C-r>+', { desc = 'Paste from system clipboard' })
    -- vim.keymap.set('n', '<C-v>', '"+p', { desc = 'Paste from system clipboard' }) conflict with visual mode
    vim.keymap.set('t', '<C-v>', '<C-\\><C-n>"+pi', { desc = 'Paste in terminal' })

    -- resolve C compiler issue on window system
    vim.env.CC = "gcc"
    vim.env.CXX = "g++"
else
    vim.g.undotree_DiffCommand = "diff"
    vim.o.shell = "zsh"
end

require("howard")
