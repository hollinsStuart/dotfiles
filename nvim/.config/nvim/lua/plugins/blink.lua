return {
	"saghen/blink.cmp",
	event = { "BufReadPost", "BufNewFile" },
	version = "1.*",
	dependencies = { "xzbdmw/colorful-menu.nvim", "rafamadriz/friendly-snippets" },
	opts = {
		completion = {
			documentation = {
				auto_show = true,
			},
			menu = {
				draw = {
					-- We don't need label_description now because label and label_description are already
					-- combined together in label by colorful-menu.nvim.
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
			},
		},
		keymap = {
			-- Navigation keybindings (preserving nvim-cmp style)
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			-- Documentation scrolling (preserving nvim-cmp style)
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			-- Completion control (preserving nvim-cmp style)
			["<C-Space>"] = { "show", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		signature = {
			enabled = true,
		},
		cmdline = {
			completion = {
				menu = {
					auto_show = true,
				},
			},
		},
		sources = {
			providers = {
				snippets = { score_offset = 1000 },
			},
		},
	},
}
