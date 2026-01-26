local jdtls = require("jdtls")

-- Java 21 for running jdtls language server
local java_21_home = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"

-- Java 17 for your project compilation and runtime
local java_17_home = vim.fn.trim(vim.fn.system("/usr/libexec/java_home -v 17"))

-- Workspace directory (where project-specific data is stored)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Get jdtls installation path from Mason
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Platform-specific config
local config_dir = mason_path .. "/config_mac"
if vim.fn.has("mac") == 0 then
  if vim.fn.has("unix") == 1 then
    config_dir = mason_path .. "/config_linux"
  elseif vim.fn.has("win32") == 1 then
    config_dir = mason_path .. "/config_win"
  end
end

local config = {
  cmd = {
    java_21_home .. "/bin/java", -- Use Java 21 ONLY for jdtls server
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher_jar,
    "-configuration", config_dir,
    "-data", workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = java_17_home,
            default = true, -- Java 17 is default for your projects
          },
        },
      },
    },
  },
}

jdtls.start_or_attach(config)
