return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
				-- hide_dotfiles = false,
				-- hide_gitignored = false,
				never_show = { ".git" },
			},
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
		},
	},
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
			end,
			desc = "File Explorer",
		},
	},
}
