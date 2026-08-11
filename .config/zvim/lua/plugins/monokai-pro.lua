return {
	"loctvl842/monokai-pro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("monokai-pro").setup()
		vim.cmd.colorscheme("monokai-pro")
		-- https://github.com/loctvl842/monokai-pro.nvim/issues/173
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#221F22" })
	end,
}
