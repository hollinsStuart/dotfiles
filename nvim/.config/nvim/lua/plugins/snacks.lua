return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- smooth scrolling
		animate = {
			enabled = true,
			fps = 60, -- smoother at higher FPS
			easing = "in_out_cubic", -- easing style: linear, out_quad, in_out_cubic, etc.
			resize = {
				enable = true,
				duration = 200,
			},
			scroll = {
				enable = true,
				duration = 200,
			},
		},
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = " ",
						key = "s",
						desc = "Select Session",
						action = ':lua MiniSessions.select("read")',
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		explorer = {
			enabled = true,
			include = { ".*" }, -- show .gitignore
		},
		indent = { enabled = true },
		image = { enabled = false },
		input = { enabled = true },
		lazygit = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		picker = {
			enabled = true,
			sources = {
				explorer = {
					status = { opened = false },
					include = { ".gitignore", ".config" },
					exclude = { "*.lock", ".git", ".idea", ".venv", ".env" },
				},
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			lazygit = {
				position = "float",
				border = "single",
				width = 0, -- 0 => full width; set 0.9 for 90%
				height = 0, -- 0 => full height
			},
			notification = {
				border = "rounded",
				zindex = 100,
				ft = "markdown",
				wo = {
					winblend = 5,
					wrap = false,
					conceallevel = 2,
					colorcolumn = "",
				},
				bo = { filetype = "snacks_notif" },
			},
			notification_history = {
				border = "rounded",
				zindex = 100,
				width = 0.9,
				height = 0.9,
				minimal = false,
				title = " Notification History ",
				title_pos = "center",
				ft = "markdown",
				bo = { filetype = "snacks_notif_history", modifiable = false },
				wo = { winhighlight = "Normal:SnacksNotifierHistory" },
				keys = { q = "close" },
			},
		},
	},
	keys = {
		-- Top Pickers & Explorer
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		-- {
		-- 	"<leader>/",
		-- 	function()
		-- 		Snacks.picker.grep()
		-- 	end,
		-- 	desc = "Grep",
		-- },
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		-- find
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.grep()
			end,
			desc = "Find string in cwd",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Find string under cursor in cwd",
			mode = { "n", "x" }, -- allow use in visual mode too
		},
		-- Grep
		-- {
		-- 	"<leader>sb",
		-- 	function()
		-- 		Snacks.picker.lines()
		-- 	end,
		-- 	desc = "Buffer Lines",
		-- },
		-- {
		-- 	"<leader>sB",
		-- 	function()
		-- 		Snacks.picker.grep_buffers()
		-- 	end,
		-- 	desc = "Grep Open Buffers",
		-- },
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- search
		-- {
		-- 	'<leader>s"',
		-- 	function()
		-- 		Snacks.picker.registers()
		-- 	end,
		-- 	desc = "Registers",
		-- },
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		-- {
		-- 	"<leader>sb",
		-- 	function()
		-- 		Snacks.picker.lines()
		-- 	end,
		-- 	desc = "Buffer Lines",
		-- },
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		-- TODO: change to <leader>xd
		-- {
		--   "<leader>sd",
		--   function()
		--     Snacks.picker.diagnostics()
		--   end,
		--   desc = "Diagnostics",
		-- },
		-- {
		--   "<leader>sD",
		--   function()
		--     Snacks.picker.diagnostics_buffer()
		--   end,
		--   desc = "Buffer Diagnostics",
		-- },
		-- {
		--   "<leader>sH",
		--   function()
		--     Snacks.picker.highlights()
		--   end,
		--   desc = "Highlights",
		-- },
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		-- {
		-- 	"<leader>sM",
		-- 	function()
		-- 		Snacks.picker.man()
		-- 	end,
		-- 	desc = "Man Pages",
		-- },
		-- {
		-- 	"<leader>sp",
		-- 	function()
		-- 		Snacks.picker.lazy()
		-- 	end,
		-- 	desc = "Search for Plugin Spec",
		-- },
		-- {
		-- 	"<leader>sq",
		-- 	function()
		-- 		Snacks.picker.qflist()
		-- 	end,
		-- 	desc = "Quickfix List",
		-- },
		-- {
		-- 	"<leader>sR",
		-- 	function()
		-- 		Snacks.picker.resume()
		-- 	end,
		-- 	desc = "Resume",
		-- },
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		-- Other
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<c-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
			end,
		})
	end,
}
