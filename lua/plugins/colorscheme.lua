return {
  -- "ellisonleao/gruvbox.nvim",
  -- config = function()
  --   -- Default options:
  --   require("gruvbox").setup({
  --     terminal_colors = true, -- add neovim terminal colors
  --     undercurl = true,
  --     underline = true,
  --     bold = true,
  --     italic = {
  --       strings = true,
  --       emphasis = true,
  --       comments = true,
  --       operators = false,
  --       folds = true,
  --     },
  --     strikethrough = true,
  --     invert_selection = false,
  --     invert_signs = false,
  --     invert_tabline = false,
  --     inverse = true, -- invert background for search, diffs, statuslines and errors
  --     contrast = "hard", -- can be "hard", "soft" or empty string
  --     palette_overrides = {},
  --     overrides = {},
  --     dim_inactive = false,
  --     transparent_mode = false,
  --   })
  --   vim.cmd("colorscheme gruvbox")
  -- end
  --
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    term_colors = true,
    transparent_background = true,
    dim_inactive = {
      enabled = false,   -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      harpoon = true,
      telescope = true,
      mason = true,
      noice = true,
      notify = true,
      which_key = true,
      neotree = true,
      fidget = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-macchiato")
  end,

  -- "folke/tokyonight.nvim",
  -- config = function()
  --   require("tokyonight").setup({
  --
  --     lazy = false,
  --     priority = 1000,
  --     opts = {},
  --     vim.cmd("colorscheme tokyonight-night"),
  --   })
  -- end,
}
