return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		label = {
			rainbow = {
				enabled = true,
				shade = 1,
			},
		},

		-- Enable enhanced search automatically for / and ?
		modes = {
			search = {
				enabled = false, -- highlight matches during / search
				multi_window = true, -- search across multiple windows
				highlight = { backdrop = true },
			},

			-- smarts for "word jump" using s w
			char = {
				enabled = true,
				jump_labels = true,
			},

			-- Treesitter mode improvements
			treesitter = {
				highlight = {
					backdrop = true,
					matches = true,
				},
				jump = { pos = "range" },
			},
		},

		-- General jump improvements
		search = {
			multi_window = true, -- allow jumps across windows
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
}
