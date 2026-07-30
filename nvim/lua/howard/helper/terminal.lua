local M = {}

function M.open_in_buffer_dir()
    local dir = vim.fn.expand("%:p:h"):gsub("oil://", "")
    vim.cmd("belowright split")
    vim.cmd("resize 15")
    vim.cmd("lcd " .. dir)
    vim.cmd("term")
    vim.cmd("startinsert")
end

return M
