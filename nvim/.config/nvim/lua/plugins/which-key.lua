return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 400
	end,
	opts = {
		preset = "helix",
		command = true,
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Optional: show which-key popup while you type `:`
		vim.api.nvim_set_keymap("c", "<C-r>", "<C-r>", { noremap = false })
		-- (other commandline mappings if needed)
	end,
}
