return {
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.2.1", -- or, branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local themes = require("telescope.themes")

      local dropdown = themes.get_dropdown({
        layout_config = { width = 0.95, height = 0.95 },
      })

      -- Dropdown look, but "vertical" so height/width size the whole window and
      -- the preview gets a real pane. In "center" (what dropdown uses) height only
      -- sizes the results block and the preview is squeezed into what is left.
      local dropdown_with_preview = themes.get_dropdown({
        layout_strategy = "vertical",
        layout_config = {
          width = 0.95,
          height = 0.95,
          prompt_position = "top",
          -- preview_height is vertical-only; nesting it keeps it out of the shared
          -- defaults, which "center" pickers (ui-select) validate against.
          vertical = { preview_height = 0.6 },
        },
      })

      require("telescope").setup({
        -- dropdown_with_preview is the baseline for every picker; the table below
        -- layers the non-layout defaults on top of it.
        defaults = vim.tbl_deep_extend("force", dropdown_with_preview, {
          file_ignore_patterns = { "node_modules", ".git/" }, -- Exclude large directories
          vimgrep_arguments = {
            "rg",
            "--hidden",
            "--glob=!**/.git/*",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        }),
        pickers = {},
        extensions = {
          ["ui-select"] = {
            dropdown,
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
