return {
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        timeout = 1500,               -- time in milliseconds (e.g., 2000ms = 2 seconds)
        stages = "fade_in_slide_out", -- optional: "fade", "slide", "fade_in_slide_out"
      })
      vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "dismiss noice message" })
      vim.notify = require("notify") -- set it as the default notifier
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },

    config = function()
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup"
        },
        routes = {
          {
            view = 'notify',
            filter = {
              event = 'msg_showmode',
              any = {
                { find = 'recording' },
              },
            },
          },
        },
        views = {
          cmdline_popup = {
            win_options = {
              -- This line makes the border match the background
              -- winhighlight = "Normal:Normal,FloatBorder:Normal",
            },
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        }
      })

      local macro_group = vim.api.nvim_create_augroup('MacroRecording', { clear = true })
      vim.api.nvim_create_autocmd('RecordingLeave', {
        group = macro_group,
        callback = function()
          -- Display a message when macro recording stops
          print('Macro recording stopped')
        end,
      })
    end,

    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { link = "Float" })
  }
}
