if vim.g.neovide then return {} end

return {
  "sphamba/smear-cursor.nvim",
  opts = {
        cursor_color = "#d3cdc3",
        stiffness = 0.5,
        trailing_stiffness = 0.5,
        matrix_pixel_threshold = 0.5,
    },
}
