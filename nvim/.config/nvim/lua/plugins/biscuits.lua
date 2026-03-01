return {
	"code-biscuits/nvim-biscuits",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"catppuccin/nvim",
	},
	event = "VeryLazy",
	opts = {
		default_config = {
			max_length = 40,
			min_distance = 10,
			prefix_string = " 󰌵 ",
		},
		language_config = {
			python = {
				disabled = true,
			},
		},
		cursor_line_only = true,
		show_on_start = true,
	},
	config = function(_, opts)
		require("nvim-biscuits").setup(opts)

		-- Reapply highlights when colorscheme changes
		local function set_biscuit_highlights()
			local ok, catppuccin = pcall(require, "catppuccin.palettes")
			if not ok then
				-- fallback if catppuccin isn’t loaded
				vim.api.nvim_set_hl(0, "BiscuitColor", { fg = "#6c7086", italic = true })
				return
			end

			local p = catppuccin.get_palette("mocha")

			-- Global biscuit color: subtle, slightly dimmed text
			vim.api.nvim_set_hl(0, "BiscuitColor", {
				fg = p.teal, -- soft gray
				bg = "NONE",
				-- italic = true,
				bold = true,
			})

			-- Some optional language-specific examples:
			-- vim.api.nvim_set_hl(0, "BiscuitColorLua", {
			-- 	fg = p.lavender,
			-- 	bg = "NONE",
			-- 	italic = true,
			-- })
			--
			-- vim.api.nvim_set_hl(0, "BiscuitColorRust", {
			-- 	fg = p.peach,
			-- 	bg = "NONE",
			-- 	italic = true,
			-- })
			--
			-- vim.api.nvim_set_hl(0, "BiscuitColorCpp", {
			-- 	fg = p.sapphire,
			-- 	bg = "NONE",
			-- 	italic = true,
			-- })
		end

		set_biscuit_highlights()

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_biscuit_highlights,
		})
	end,
}
