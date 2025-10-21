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
          -- "ts_ls",
          "html",
          "emmet_ls",
          "eslint",
          "cssls",
          "css_variables",
          "somesass_ls",
          "pylsp",
          "markdown_oxide",
          "bashls",
          "texlab",
          "tailwindcss",
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
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("typescript-tools").setup {
        settings = {
          separate_diagnostic_server = false,
          tsserver_plugins = {
            -- for TypeScript v4.9+
            "@styled/typescript-styled-plugin",
            -- or for older TypeScript versions
            -- "typescript-styled-plugin",
          },
          jsx_close_tag = {
            enable = false,
            filetypes = { "javascriptreact", "typescriptreact" },
          }
        },
      }
    end
  }
}
