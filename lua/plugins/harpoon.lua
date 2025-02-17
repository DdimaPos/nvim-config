return {
	"ThePrimeagen/harpoon",
	config = function()
    vim.keymap.set('n', '<C-h>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
    vim.keymap.set('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>')
    vim.keymap.set('n', '<C-9>', ':lua require("harpoon.ui").nav_prev()<CR>')
    vim.keymap.set('n', '<C-0>', ':lua require("harpoon.ui").nav_next()<CR>')
	end,
}
