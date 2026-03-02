return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require("lualine").setup({
      options = {
        theme = "material"
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { '' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      }
    })
  end
}
