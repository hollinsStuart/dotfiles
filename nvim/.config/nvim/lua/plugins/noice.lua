return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- keep the fancy cmdline
		cmdline = { enabled = true },

		-- ❌ let Snacks/not the default handle messages
		messages = { enabled = false }, -- don't hijack :messages / msg_show

		-- ❌ do NOT use Noice as vim.notify
		notify = { enabled = false },

		popupmenu = { enabled = true },

		lsp = {
			-- ❌ let Snacks (or nothing) handle progress notifications
			progress = { enabled = false },

			-- optional: if you want LSP "messages" (like server notices) to go
			-- through Snacks.notify instead of Noice, disable this too:
			message = { enabled = false },

			-- ✅ keep these if you like Noice's LSP UI
			hover = { enabled = true },
			signature = {
				enabled = true,
				auto_open = {
					enabled = true,
					trigger = true,
					luasnip = true,
					throttle = 50,
				},
			},
		},
	},
}
