--- UI
vim.opt.shortmess:append("I") -- don't show intro message
vim.opt.guicursor = ""
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.opt.laststatus = 3
-- vim.opt.colorcolumn = "80"

--- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

--- indentatio or tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- vim.opt.smartindent = true (handle by treesitter indentexpr)

--- search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.o.smartcase = true

--- scroll / viewport
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

--- files / presistence
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

--- window split
vim.opt.splitright = true

--- Misc / Timing
vim.opt.isfname:append("@-@") -- read hyphens in between path name
vim.opt.updatetime = 50

--- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldcolumn = "1"

--- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
