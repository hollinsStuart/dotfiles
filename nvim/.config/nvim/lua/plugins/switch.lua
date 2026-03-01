return {
	"AndrewRadev/switch.vim",
	event = "VeryLazy", -- load lazily (after UI is ready)
	config = function()
		-- Optional: keybind to trigger :Switch manually
		vim.keymap.set("n", "<leader>s", ":Switch<CR>", { noremap = true, silent = true, desc = "Switch word" })

		-- Example: define a custom switch pair
		vim.g.switch_custom_definitions = {
			{ "True", "False" },
			{ "TRUE", "FALSE" },
			{ "true", "false" },
			{ "yes", "no" },
			{ "on", "off" },
			{ "&&", "||" },
			{ "and", "or" },
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
