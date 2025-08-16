return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "ts_ls",
          "html",
          "emmet_ls",
          "eslint",
          "asm_lsp",
          "cssls",
          "css_variables",
          "somesass_ls",
          "pylsp",
          -- "golangci_lint_ls",
          "markdown_oxide",
          "bashls",
          "texlab",
          "tailwindcss"
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  {
    "RRethy/vim-illuminate",
  }
}
