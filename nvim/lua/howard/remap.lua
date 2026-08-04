vim.g.mapleader = " "

-- Cool remap, move entire text down and up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "J", "mzJ`z")
-- better "next" after search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- clipboard: 1. base on selected text 2. quick copy of current line 3. retain copying
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without losing clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete without overwriting the register"})

-- disable Ex-mode
vim.keymap.set("n", "Q", "<nop>")

-- Format the current buffer using the active LSP server
-- disabled: replaced by conform.lua and lint.lua
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- quick fix list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- location list navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- edit all the current word at once
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- make program executable (unix system only)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- <C-c> is can actuate action in visual mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- sample for inject text to nvim
vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

-- nvim config file quick edit (QoL)
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/howard/init.lua<CR>");
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)

-- split horizotal or vertical windows
vim.keymap.set("n", "<C-w>v", function() vim.cmd("vsplit") end, { desc = "Vsplit and move to the right" })
vim.keymap.set("n", "<C-w>-", function() vim.cmd("split") end, { desc = "Hsplit and move to the top" })

vim.keymap.set("n", "<leader>n", "<cmd>cnext<CR>")
vim.keymap.set("n", "<leader>p", "<cmd>cprev<CR>")

vim.keymap.set('n', '<leader>ot', require("howard.helper.terminal").open, { desc = "Open floating terminal in buffer directory" })
vim.keymap.set('n', '<leader>ct', require("howard.helper.terminal").close, { desc = "Close floating terminal" })
