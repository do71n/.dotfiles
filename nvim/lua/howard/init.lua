require("howard.remap")
require("howard.set")
require("howard.lazy_init")

local autocmd = vim.api.nvim_create_autocmd
-- Seperating 2 Groups is not necessarily needed, but we do it this way.
local augroup = vim.api.nvim_create_augroup
local TheHowardGroup = augroup('Howard', {})
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

-- show yank after copies
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Strip trailing whitespace on save, read the command
autocmd({"BufWritePre"}, {
    group = TheHowardGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Set LSP Keymaps once an LSP server attaches to the buffer
autocmd('LspAttach', {
    group = TheHowardGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        -- Press shift + K to open documentation
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, {})
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count = 1}) end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count = -1}) end, opts)
    end
})
