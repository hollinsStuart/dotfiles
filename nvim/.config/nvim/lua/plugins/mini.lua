return {
	"nvim-mini/mini.nvim",
	version = "*",
	event = "VeryLazy",
	specs = {
		{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
	},
	init = function()
		package.preload["nvim-web-devicons"] = function()
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
	config = function()
		require("mini.ai").setup({
			mappings = {
				goto_left = "[",
				goto_right = "]",
			},
		})
		require("mini.bracketed").setup({})
		require("mini.comment").setup({})

		local mocha = {
			rosewater = "#f5e0dc",
			flamingo = "#f2cdcd",
			pink = "#f5c2e7",
			mauve = "#cba6f7",
			red = "#f38ba8",
			maroon = "#eba0ac",
			peach = "#fab387",
			yellow = "#f9e2af",
			green = "#a6e3a1",
			teal = "#94e2d5",
			sky = "#89dceb",
			sapphire = "#74c7ec",
			blue = "#89b4fa",
			lavender = "#b4befe",

			surface2 = "#585b70",
		}

		require("mini.icons").setup({
			style = "glyph",

			file = {
				README = { glyph = "󰋼", hl = "MiniIconsReadme" },
				["README.md"] = { glyph = "󰋼", hl = "MiniIconsReadme" },
			},

			filetype = {
				bash = { glyph = "", hl = "MiniIconsBash" },
				sh = { glyph = "", hl = "MiniIconsSh" },
				toml = { glyph = "󰅪", hl = "MiniIconsToml" },
			},
		})

		-- Now manually define the highlight groups
		vim.api.nvim_set_hl(0, "MiniIconsReadme", { fg = mocha.yellow })
		vim.api.nvim_set_hl(0, "MiniIconsBash", { fg = mocha.green })
		vim.api.nvim_set_hl(0, "MiniIconsSh", { fg = mocha.green })
		vim.api.nvim_set_hl(0, "MiniIconsToml", { fg = mocha.peach })
		require("mini.move").setup({})
		require("mini.pairs").setup({})

		----------------------------------------------------------------
		-- mini.sessions
		----------------------------------------------------------------
		require("mini.sessions").setup({
			-- what to save
			options = {
				"buffers",
				"curdir",
				"tabpages",
				"winsize",
				"help",
			},

			autoread = false,
			autowrite = false,

			-- use hooks for success notifications
			hooks = {
				post = {
					read = function(session)
						-- session is a table: { name, path, type, modify_time, ... }
						require("snacks").notify("Loaded session: " .. session.name, {
							level = vim.log.levels.INFO,
							title = "Sessions",
						})
					end,
					write = function(session)
						require("snacks").notify("Session saved as: " .. session.name, {
							level = vim.log.levels.INFO,
							title = "Sessions",
						})
					end,
					delete = function(session)
						require("snacks").notify("Deleted session: " .. session.name, {
							level = vim.log.levels.WARN,
							title = "Sessions",
						})
					end,
				},
			},
		})

		local MiniSessions = require("mini.sessions")

		-- default session name = folder name of current working directory
		local function default_session()
			return vim.fn.fnamemodify(vim.loop.cwd(), ":t")
		end

		-- [w]orkspace [S]elect session (picker)
		vim.keymap.set("n", "<leader>ws", function()
			MiniSessions.select("read")
		end, { desc = "[W]orkspace: [S]ession select" })

		-- [w]orkspace [S]ave session (manual name)
		vim.keymap.set("n", "<leader>wS", function()
			local name = vim.fn.input("Session name: ", default_session())
			if name == nil or name == "" then
				require("snacks").notify("Save cancelled", {
					level = vim.log.levels.WARN,
					title = "Sessions",
				})
				return
			end
			MiniSessions.write(name) -- success message handled by post.write hook
		end, { desc = "[W]orkspace: [S]ession save (manual)" })

		-- [w]orkspace [D]elete session (from list)
		vim.keymap.set("n", "<leader>wd", function()
			MiniSessions.select("delete", { force = true })
			-- success message handled by post.delete hook
		end, { desc = "[W]orkspace: [D]elete session" })

		-- [w]orkspace [L]oad last (cwd) session
		vim.keymap.set("n", "<leader>wl", function()
			local name = default_session()
			local file = MiniSessions.config.directory .. "/" .. name

			if vim.fn.filereadable(file) == 0 then
				require("snacks").notify("No session found for: " .. name, {
					level = vim.log.levels.WARN,
					title = "Sessions",
				})
				return
			end

			MiniSessions.read(name) -- success message handled by post.read hook
		end, { desc = "[W]orkspace: [L]oad cwd session" })

		----------------------------------------------------------------
		-- mini.surround
		----------------------------------------------------------------
		require("mini.surround").setup({
			mappings = {
				add = "<leader>sa", -- Add surrounding in Normal and Visual modes
				delete = "<leader>sd", -- Delete surrounding
				find = "<leader>sf", -- Find surrounding (to the right)
				find_left = "<leader>sF", -- Find surrounding (to the left)
				-- highlight = "<leader>sh", -- Highlight surrounding
				replace = "<leader>sr", -- Replace surrounding
				update_n_lines = "<leader>sn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		})
	end,
}
