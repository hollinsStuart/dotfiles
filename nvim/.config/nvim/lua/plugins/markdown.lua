return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		cmd = { "RenderMarkdown" },
		ft = { "markdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-mini/mini.nvim",
		},
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
		config = function()
			local group = vim.api.nvim_create_augroup("markdown_backtick_completion", { clear = true })

			local function set_cursor(row, col)
				vim.api.nvim_win_set_cursor(0, { row, col })
			end

			local function replace_range(bufnr, row, start_col, end_col, replacement)
				vim.api.nvim_buf_set_text(bufnr, row - 1, start_col, row - 1, end_col, replacement)
			end

			local function markdown_backtick_handler()
				local bufnr = vim.api.nvim_get_current_buf()
				local row, col = unpack(vim.api.nvim_win_get_cursor(0))
				local line = vim.api.nvim_get_current_line()
				local before = line:sub(1, col)
				local after = line:sub(col + 1)

				if before:sub(-2) == "``" and after:sub(1, 2) == "``" then
					replace_range(bufnr, row, col - 2, col + 2, { "```", "", "```" })
					set_cursor(row, 3)
					return
				end

				if before:sub(-1) == "`" then
					replace_range(bufnr, row, col - 1, col, { "````" })
					set_cursor(row, col + 1)
					return
				end

				local key = vim.api.nvim_replace_termcodes("`", true, false, true)
				vim.api.nvim_feedkeys(key, "in", false)
			end

			local function set_markdown_keymap(bufnr)
				vim.keymap.set("i", "`", markdown_backtick_handler, {
					buffer = bufnr,
					desc = "Markdown backtick completion",
				})
			end

			if vim.bo.filetype == "markdown" then
				set_markdown_keymap(0)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = "markdown",
				callback = function(args)
					set_markdown_keymap(args.buf)
				end,
			})
		end,
	},
}
