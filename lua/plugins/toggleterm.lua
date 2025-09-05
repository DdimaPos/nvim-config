return {
  "akinsho/toggleterm.nvim",
  config = function()
    local status_ok, toggleterm = pcall(require, "toggleterm")
    if not status_ok then
      return
    end
    toggleterm.setup({
      size = 70,
      open_mapping = [[<C-_>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mapping = true,
      persist_size = true,
      direction = "vertical",
      close_on_exit = true,
      shell = vim.o.shell,
    })
    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
    end
    --
    -- Add an extra mapping for when Neovim calls it <C-/>
    vim.keymap.set({ "n", "t" }, "<C-/>", function()
      vim.cmd("ToggleTerm")
    end, { noremap = true, silent = true })

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
