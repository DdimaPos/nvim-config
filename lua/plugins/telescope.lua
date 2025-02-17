return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8", -- or, branch = '0.1.x',
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
			require("telescope").setup({
				defaults = {
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
				},
				pickers = {
					find_files = {
						find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			--require("telescope").load_extension("ui-select")
		end,
	},
}
