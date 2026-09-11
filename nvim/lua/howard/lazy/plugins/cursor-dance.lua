if vim.g.neovide then return {} end

return {
  "sphamba/smear-cursor.nvim",
  opts = {
        never_draw_over_target = true,

        smear_insert_mode = false,
        min_vertical_distance_smear = 2,
        min_horizontal_distance_smear = 2,

        cursor_color = "#d3cdc3",
        stiffness = 0.9,
        trailing_stiffness = 0.6,
        damping = 0.99,
        matrix_pixel_threshold = 0.5,
    },
}
