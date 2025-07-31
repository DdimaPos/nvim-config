return {
  -- "rebelot/kanagawa.nvim",
  -- config = function()
  --   require("kanagawa").setup({
  --     compile = false,  -- enable compiling the colorscheme
  --     undercurl = true, -- enable undercurls
  --     commentStyle = { italic = true },
  --     functionStyle = {},
  --     keywordStyle = { italic = true },
  --     statementStyle = { bold = true },
  --     typeStyle = {},
  --     transparent = true,    -- do not set background color
  --     dimInactive = false,    -- dim inactive window `:h hl-NormalNC`
  --     terminalColors = false, -- define vim.g.terminal_color_{0,17}
  --     colors = {              -- add/modify theme and palette colors
  --       palette = {},
  --       theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  --     },
  --     overrides = function(colors) -- add/modify highlights
  --       return {}
  --     end,
  --     theme = "wave",    -- Load "wave" theme when 'background' option is not set
  --     background = {     -- map the value of 'background' option to a theme
  --       dark = "dragon", -- try "dragon" !
  --       light = "lotus",
  --     },
  --   })
  --
  --   -- setup must be called before loading
  --   vim.cmd("colorscheme kanagawa")
  -- end,

  -- "sainnhe/gruvbox-material",
  -- config = function ()
  --   -- https://github.com/sainnhe/gruvbox-material/blob/master/doc/gruvbox-material.txt
  --   vim.g.gruvbox_material_background = 'hard' -- "hard", "medium", "soft"
  --   -- vim.g.gruvbox_material_enable_bold = 1
  --   vim.cmd.colorscheme("gruvbox-material")
  -- end

  "ellisonleao/gruvbox.nvim",
  config = function()
    -- Default options:
    require("gruvbox").setup({
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    })
    vim.cmd("colorscheme gruvbox")
  end

  -- "folke/tokyonight.nvim",
  -- config = function()
  --   require("tokyonight").setup({
  --
  --     lazy = false,
  --     priority = 1000,
  --     opts = {},
  --     vim.cmd("colorscheme tokyonight-night")
  --   })
  -- end
  --
}
