vim.g.mapleader = " "
-- I have used Oil instead
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Cool remap, move entire text down and up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : copying
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

-- /Users/dontin/.config/nvim
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/howard/init.lua<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)


-- experimental with AI
--vim.keymap.set('n', '<leader>rr', function()
--    -- 1. Save the current buffer
--    vim.cmd("w")
--    vim.fn.system('tmux select-window -t 2 && tmux send-keys -t :2 "./build.sh" Enter')
--end)

vim.keymap.set("n", "<C-w>v", function()
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
end, { desc = "Vsplit and move to the right" })

vim.keymap.set("n", "<leader>n", "<cmd>cnext<CR>")
vim.keymap.set("n", "<leader>p", "<cmd>cprev<CR>")

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set('n', '<leader>ot', function()
    -- If it's an Oil buffer, it handles the conversion to a real path automatically
    local dir = vim.fn.expand("%:p:h"):gsub("oil://", "")
    vim.cmd("belowright split")
    vim.cmd("resize 13")
    -- 'lcd' changes the directory ONLY for this new window
    vim.cmd("lcd " .. dir)
    vim.cmd("term")
    vim.cmd("startinsert")
end, { desc = "Open Terminal in current buffer directory" })
