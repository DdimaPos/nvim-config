return {
  "ThePrimeagen/harpoon",
  config = function()
    vim.keymap.set("n", "<leader>hr", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
    vim.keymap.set("n", "<leader>hh", ":Telescope harpoon marks<CR>")
    vim.keymap.set("n", "<leader>ha", ':lua require("harpoon.mark").add_file()<CR>')
    vim.keymap.set("n", "<C-->", ':lua require("harpoon.ui").nav_prev()<CR>')
    vim.keymap.set("n", "<C-=>", ':lua require("harpoon.ui").nav_next()<CR>')
  end,
}
