return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      -- https://github.com/nvim-lualine/lualine.nvim/tree/master?tab=readme-ov-file#available-components
      sections = {
        lualine_a = { "mode" },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', "lsp_status" },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      }
    })
  end
}
