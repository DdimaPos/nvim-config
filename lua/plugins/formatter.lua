return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "eslint_d", "prettier" },
        typescript = { "eslint_d", "prettier" },
        typescriptreact = { "eslint_d", "prettier" },
        javascriptreact = { "eslint_d", "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "goimports", "gofmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      format_on_save = function(bufnr)
        -- Opt-out per buffer, e.g. from a project's .nvim.lua
        if vim.b[bufnr].disable_autoformat then
          return
        end
        return { lsp_format = "fallback", async = false, timeout_ms = 2000 }
      end,
    })
    vim.keymap.set({ "n", "v" }, "<leader>gf", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 3000,
      })
    end, { desc = "Format file or range selected in visual mode" })
  end,
}
