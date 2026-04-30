return {
	"norcalli/nvim-colorizer.lua",
	ft = {
		"css",
		"scss",
		"sass",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"lua",
	},
	config = function()
		require("colorizer").setup({
			"css",
			"scss",
			"sass",
			"html",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"lua",
		}, {
			css_fn = true,
		})
	end,
}
