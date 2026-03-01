return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "Avante" },
		config = function()
			require("custom.config.render-markdown")
		end,
	},
	{
		"AndrewRadev/switch.vim",
		config = function()
			vim.keymap.set("n", "`", function()
				vim.cmd([[Switch]])
			end, { desc = "Switch strings" })
			vim.g.switch_custom_definitions = {
				{ "> [!TODO]", "> [!WIP]", "> [!DONE]", "> [!FAIL]" },
				{ "height", "width" },
			}
		end,
	},
	{
		"bullets-vim/bullets.vim",
		ft = { "markdown" },
	},
}
