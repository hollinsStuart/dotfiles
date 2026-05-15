return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- use main branch (v1.0.0+)
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- Configure treesitter
		require("nvim-treesitter").setup({
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = { enable = true },
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"json",
				"jsonc",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
				"cpp",
				"python",
				"go",
				"rust",
				"markdown",
				"markdown_inline",
			},
			fold = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
