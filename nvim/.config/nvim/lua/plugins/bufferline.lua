return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	cmd = "BufferlineToggle",
	dependencies = { "nvim-tree/nvim-web-devicons", { "catppuccin/nvim", name = "catppuccin" } },
	init = function()
		vim.o.showtabline = 0
	end,
	keys = {
		{ "<leader>ub", "<cmd>BufferlineToggle<CR>", desc = "Toggle buffer bar" },
		{
			"<leader>bc",
			function()
				vim.o.showtabline = 2
				vim.cmd("BufferLinePickClose")
			end,
			desc = "Pick buffer to close",
		},
	},
	config = function()
		local function close_buffer(buf)
			Snacks.bufdelete(buf)
		end
		local function highlights()
			local colors = require("catppuccin.palettes").get_palette()
			local theme = require("catppuccin.special.bufferline").get_theme({
				styles = {},
				custom = {
					all = {
						fill = { bg = "NONE" },
						background = { fg = colors.subtext0, bg = "NONE" },
						buffer_visible = { fg = colors.text, bg = "NONE" },
						buffer_selected = { fg = colors.mauve, bg = colors.surface0, style = { "bold" } },
						duplicate_selected = { fg = colors.mauve, bg = colors.surface0 },
						indicator_selected = { fg = colors.mauve, bg = colors.surface0 },
						separator_selected = { fg = colors.surface1, bg = colors.surface0 },
					},
				},
			})()
			-- Keep diagnostics and modified markers on the same selected background.
			for name, highlight in pairs(theme) do
				if name:match("_selected$") then
					highlight.bg = colors.surface0
				end
			end
			return theme
		end

		require("bufferline").setup({
			options = {
				mode = "buffers",
				-- Visibility is controlled only by the user's toggle.
				auto_toggle_bufferline = false,
				always_show_bufferline = true,
				close_command = close_buffer,
				right_mouse_command = close_buffer,
				diagnostics = "nvim_lsp",
				indicator = { icon = "▎", style = "icon" },
				separator_style = "thin",
				show_buffer_close_icons = false,
				show_close_icon = false,
				modified_icon = "●",
				max_name_length = 24,
				max_prefix_length = 16,
				tab_size = 22,
			},
			highlights = highlights,
		})

		vim.api.nvim_create_user_command("BufferlineToggle", function()
			vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
		end, { desc = "Toggle the file buffer bar" })
	end,
}
