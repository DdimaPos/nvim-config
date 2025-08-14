return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    local root_dir = require("null-ls.utils").root_pattern(".git", "package.json")

    null_ls.setup({
      root_dir = root_dir,
      sources = {
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.prettier.with({
          prefer_local = "node_modules/.bin",
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        -- null_ls.builtins.diagnostics.eslint_d,
        require("none-ls.diagnostics.eslint_d")
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
