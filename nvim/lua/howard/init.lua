require("howard.remap")
require("howard.set")
require("howard.lazy.lazy_init")

-- Seperating 2 Groups is not necessarily needed, but we do it this way.
local autocmd = vim.api.nvim_create_autocmd
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

-- Strip trailing whitespace on save by reading the command (good workaround)
autocmd({"BufWritePre"}, {
    group = TheHowardGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
