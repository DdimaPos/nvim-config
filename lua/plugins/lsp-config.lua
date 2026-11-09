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

      -- jdtls >= 1.63 must run on Java 25, while projects keep compiling against JDK 21
      local function java_home(version)
        local path = vim.fn.system({ "/usr/libexec/java_home", "-F", "-v", version }):gsub("%s+$", "")
        return vim.v.shell_error == 0 and path or nil
      end
      local jdk21, jdk25 = java_home("21"), java_home("25")

      -- java-debug + vscode-java-test bundles (installed via :MasonInstall java-debug-adapter java-test)
      -- enable debugging and test running through nvim-jdtls
      local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
      local bundles = vim.fn.glob(mason_packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true)
      for _, jar in ipairs(vim.fn.glob(mason_packages .. "/java-test/extension/server/*.jar", true, true)) do
        local name = vim.fn.fnamemodify(jar, ":t")
        if name ~= "com.microsoft.java.test.runner-jar-with-dependencies.jar" and name ~= "jacocoagent.jar" then
          table.insert(bundles, jar)
        end
      end

      vim.lsp.config("jdtls", {
        -- nvim-lspconfig and nvim-jdtls both ship lsp/jdtls.lua; which cmd and root_markers win depends on
        -- load order, so set them explicitly (same values as nvim-lspconfig)
        cmd = function(dispatchers, config)
          local data_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/"
            .. vim.fn.fnamemodify(config.root_dir or vim.fn.getcwd(), ":p:h:t")
          return vim.lsp.rpc.start({ "jdtls", "-data", data_dir }, dispatchers, {
            cwd = config.cmd_cwd,
            env = config.cmd_env,
            detached = config.detached,
          })
        end,
        root_markers = {
          { "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts", ".git" },
          { "build.xml", "pom.xml", "build.gradle", "build.gradle.kts" },
        },
        cmd_env = jdk25 and { JAVA_HOME = jdk25 } or nil,
        init_options = {
          bundles = bundles,
          settings = {
            java = {
              configuration = {
                runtimes = jdk21 and { { name = "JavaSE-21", path = jdk21, default = true } } or nil,
              },
            },
          },
        },
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
    -- nvim-jdtls registers the java debug adapter only if nvim-dap is loaded
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function(args)
          local jdtls = require("jdtls")
          vim.keymap.set("n", "<leader>tc", jdtls.test_class, { buffer = args.buf, desc = "Java: test class" })
          vim.keymap.set("n", "<leader>tm", jdtls.test_nearest_method, { buffer = args.buf, desc = "Java: test nearest method" })
        end,
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
  },
}
