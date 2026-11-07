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
          "bashls",
          "clangd",
          -- "css_variables",
          "cssls",
          "emmet_ls",
          "eslint",
          "html",
          "gopls",
          "jdtls",
          "lua_ls",
          "markdown_oxide",
          "pylsp",
          "somesass_ls",
          -- "tailwindcss",
          "texlab",
          "ts_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Resolve at call time so noice's override of vim.lsp.buf.hover is used
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      vim.lsp.config("jdtls", {
        root_dir = function(bufnr, on_dir)
          -- SAP Commerce: root at hybris/bin so jdtls imports the per-extension Eclipse projects
          -- instead of the repo-level Gradle wrapper
          local hybris_bin = vim.fs.root(bufnr, function(name, path)
            return name == "platform" and vim.uv.fs_stat(path .. "/platform/bootstrap") ~= nil
          end)
          on_dir(hybris_bin or vim.fs.root(bufnr, {
            { "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts", ".git" },
            { "build.xml", "pom.xml", "build.gradle", "build.gradle.kts" },
          }))
        end,
        before_init = function(params, config)
          local root = config.root_dir
          if root and vim.uv.fs_stat(root .. "/platform/bootstrap") then
            -- jdtls' Eclipse importer excludes "**/bin", which matches hybris/bin itself:
            -- pass its children as separate workspace roots instead
            local folders = {}
            for name, type in vim.fs.dir(root) do
              if type == "directory" then
                table.insert(folders, vim.uri_from_fname(root .. "/" .. name))
              end
            end
            params.initializationOptions = params.initializationOptions or {}
            params.initializationOptions.workspaceFolders = folders
          end
        end,
      })
    end,
    opts = {
      servers = {
        "graphql"
      }
    }
  },
  {
    "mfussenegger/nvim-jdtls",
  },
  {
    "RRethy/vim-illuminate",
  },
}
