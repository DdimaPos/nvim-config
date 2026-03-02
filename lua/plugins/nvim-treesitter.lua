return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { "javascript", "python", "lua", "c", "html", "typescript", "go", "tsx", "css", "java", "arduino" },
      highlight = {
        enable = true,
        use_languagetree = true, -- required for injections
      },
      indent = { enable = true },
    })
  end
}
