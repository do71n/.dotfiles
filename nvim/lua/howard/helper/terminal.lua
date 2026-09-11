local M = {}

local augroup = vim.api.nvim_create_augroup("HowardTerminal", { clear = true })

-- Delete a terminal buffer when its process exits with status 0.
vim.api.nvim_create_autocmd("TermClose", {
    group = augroup,
    callback = function()
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0, {})
        end
    end,
})

-- Hide UI clutter in any terminal buffer.
vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})

local terminal_state = { buf = nil, win = nil, is_open = false }

-- Close the floating terminal window if it is currently visible.
function M.close()
    if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end

-- Open (or focus) the floating terminal, started in the current buffer's directory.
function M.open()
    local fwd = vim.fn.expand("%:p:h"):gsub("oil://", "")
    if fwd == "" or fwd == "." then fwd = vim.uv.cwd() or "" end

    -- Already open: just re-focus the floating window.
    if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_set_current_win(terminal_state.win)
        return
    end

    -- Reuse the terminal buffer if it still exists, otherwise create a fresh unlisted one.
    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
        vim.bo[terminal_state.buf].bufhidden = "hide"
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.wo[terminal_state.win].winblend = 0
    vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
    vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

    -- Spawn a shell in the current buffer's directory (oil:// prefix stripped for oil buffers).
    local shell = os.getenv("SHELL") or (vim.fn.has("win32") == 1 and "pwsh" or nil)
    if vim.bo[terminal_state.buf].buftype ~= "terminal" then
        vim.fn.jobstart({ shell }, { term = true, cwd = fwd })
    end

    terminal_state.is_open = true
    vim.cmd("startinsert")

    -- Auto-close the floating window when the user leaves it.
    local term_augroup = vim.api.nvim_create_augroup("FloatingTermLeave_" .. terminal_state.win, { clear = true })
    vim.api.nvim_create_autocmd("BufLeave", {
        group = term_augroup,
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, false)
                terminal_state.is_open = false
            end
        end,
        once = true,
    })

    -- Buffer-local terminal-mode keymaps (scoped to the floating term).
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = terminal_state.buf, silent = true, desc = "Terminal normal mode" })
    vim.keymap.set("t", "<C-q>", M.close, { buffer = terminal_state.buf, silent = true, desc = "Close floating terminal" })
end

return M
