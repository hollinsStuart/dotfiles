-- Give useful LSP symbols a small boost without hiding better text matches.
local function semantic_score(item)
	local kind = vim.lsp.protocol.CompletionItemKind
	local preferred = {
		[kind.Variable] = true,
		[kind.Constant] = true,
		[kind.Field] = true,
		[kind.Property] = true,
		[kind.Function] = true,
		[kind.Method] = true,
	}
	local bonus = item.source_id == "lsp" and preferred[item.kind] and 4 or 0
	return item.score + bonus
end

return {
	"saghen/blink.cmp",
	event = { "BufReadPost", "BufNewFile" },
	version = "1.*",
	dependencies = { "xzbdmw/colorful-menu.nvim", "rafamadriz/friendly-snippets" },
	opts = {
		fuzzy = {
			sorts = {
				"exact",
				function(a, b)
					local a_score, b_score = semantic_score(a), semantic_score(b)
					if a_score ~= b_score then
						return a_score > b_score
					end
				end,
				"sort_text",
				"label",
			},
		},
		completion = {
			list = {
				selection = { preselect = true, auto_insert = false },
			},
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
			preset = "default",
			-- Arrow keys select candidates without changing the typed text.
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			-- Keep the existing navigation shortcuts as alternatives.
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			-- Documentation scrolling (preserving nvim-cmp style)
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			-- Snippet placeholders take priority over accepting a completion.
			["<Tab>"] = { "snippet_forward", "select_and_accept", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			-- Completion is accepted explicitly; Enter always starts a new line.
			["<C-Space>"] = { "show", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-y>"] = { "select_and_accept", "fallback" },
			["<CR>"] = {
				function(cmp)
					cmp.hide()
				end,
				"fallback",
			},
		},
		signature = {
			enabled = true,
		},
		cmdline = {
			keymap = {
				preset = "cmdline",
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<Left>"] = false,
				["<Right>"] = false,
				["<Tab>"] = { "select_and_accept", "show", "fallback" },
			},
			completion = {
				list = {
					selection = { preselect = true, auto_insert = false },
				},
				menu = {
					auto_show = true,
				},
			},
		},
		sources = {
			providers = {
				snippets = { score_offset = -10 },
				lsp = { score_offset = 0 },
				buffer = { score_offset = -10 },
			},
		},
	},
}
