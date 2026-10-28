return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- use main branch (v1.0.0+)
	lazy = false,
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
				"doxygen",
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

		-- Start native highlighting only for ordinary buffers with a parser.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserTreesitterHighlight", { clear = true }),
			callback = function(ev)
				if vim.bo[ev.buf].buftype ~= "" then
					return
				end

				local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
				if not lang or not vim.treesitter.get_parser(ev.buf, lang) then
					return
				end

				local ok, err = pcall(vim.treesitter.start, ev.buf, lang)
				if not ok then
					vim.notify("Treesitter (" .. lang .. "): " .. tostring(err), vim.log.levels.WARN)
				end
			end,
		})
	end,
}
