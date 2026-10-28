return {
	"AndrewRadev/switch.vim",
	event = "VeryLazy", -- load lazily (after UI is ready)
	init = function()
		-- Markdown: cycle callout states with ` (buffer-local, so ` mark jumps still work elsewhere)
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserSwitchMarkdown", { clear = true }),
			pattern = "markdown",
			callback = function(ev)
				vim.b[ev.buf].switch_custom_definitions = {
					{ "> [!TODO]", "> [!WIP]", "> [!DONE]", "> [!FAIL]" },
				}
				vim.keymap.set("n", "`", "<cmd>Switch<CR>", { buffer = ev.buf, desc = "Switch strings" })
			end,
		})
	end,
	config = function()
		-- Optional: keybind to trigger :Switch manually
		vim.keymap.set("n", "gs", ":Switch<CR>", { noremap = true, silent = true, desc = "Switch word" })

		-- Example: define a custom switch pair
		vim.g.switch_custom_definitions = {
			{ "True", "False" },
			{ "TRUE", "FALSE" },
			{ "true", "false" },
			{ "yes", "no" },
			{ "on", "off" },
			{ "&&", "||" },
			{ "and", "or" },
			{ "height", "width" },
			-- Quotes (keep inner text, rotate styles)
			{
				['"\\([^"\\\\]*\\(\\\\.[^"\\\\]*\\)*\\)"'] = "'\\1'",
				["'\\([^'\\\\]*\\(\\\\.[^'\\\\]*\\)*\\)'"] = "`\\1`",
				["`\\([^`\\\\]*\\(\\\\.[^`\\\\]*\\)*\\)`"] = '"\\1"',
			},

			-- Brackets (keep inner text, rotate () -> [] -> {} -> <> -> ())
			{
				["(\\([^)]*\\))"] = "[\\1]",
				["\\[\\([^]]*\\)\\]"] = "{\\1}",
				["{\\([^}]*\\)}"] = "<\\1>",
				["<\\([^>]*\\)>"] = "(\\1)",
			},
		}
	end,
}
