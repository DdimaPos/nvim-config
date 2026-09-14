return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup()

    ts.install({
      "javascript",
      "python",
      "lua",
      "c",
      "html",
      "typescript",
      "go",
      "tsx",
      "css",
      "java",
      "arduino",
      "astro",
      "svelte",
      "graphql"
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
