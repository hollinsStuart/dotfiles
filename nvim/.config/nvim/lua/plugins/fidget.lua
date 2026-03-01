return {
	"j-hui/fidget.nvim",
	opts = {
		-- options
		progress = {
			window = {
				border = "rounded", -- none | single | double | rounded | shadow
				relative = "editor", -- editor | win | cursor
				row = 1,
				col = 0,
				zindex = 200,
				winblend = 0, -- 0 = opaque, 100 = fully transparent
			},
			display = {
				max_message_width = 40, -- ⬅️ limit progress lines to 40 chars
				max_title_width = 30, -- ⬅️ limit title width
				max_name_width = 20, -- ⬅️ limit client/source name width
			},
		},
		notification = {
			window = {
				-- basically makes notifications disappear
				winblend = 0, -- fully transparent
				border = "rounded",
			},
			override_vim_notify = false, -- important: don't hook vim.notify
			view = {
				stack_upwards = false,
			},
		},
		integrate = {
			notify = false, -- 🔥 completely disable fidget notifications
		},
	},
	config = function(_, opts)
		require("fidget").setup(opts)

		-- load FidgetTest command
		require("tests.fidget").setup()
	end,
}
