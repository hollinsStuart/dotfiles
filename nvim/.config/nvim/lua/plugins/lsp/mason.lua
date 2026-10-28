return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				-- use names expected by mason-lspconfig / lspconfig
				"ts_ls",
				"html",
				"cssls",
				"lua_ls",
				"pyright",
				"eslint",
				-- additional servers requested by user
				"clangd", -- C / C++
				"gopls", -- Go
				"rust_analyzer", -- Rust
				"marksman", -- Markdown
				"jsonls", -- JSON
				"taplo", -- TOML
				"yamlls", -- YAML
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"prettierd", -- prettier daemon (conform's first choice)
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				-- python formatting uses ruff (~/.local/bin), not mason
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
