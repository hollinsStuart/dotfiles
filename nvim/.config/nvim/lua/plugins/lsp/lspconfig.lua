return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",

		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")

		-- prefer blink's helper for capabilities, but fall back safely
		local capabilities
		local ok_blink, blink = pcall(require, "blink.cmp")
		if ok_blink and type(blink.get_lsp_capabilities) == "function" then
			capabilities = blink.get_lsp_capabilities()
		else
			local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if ok_cmp and type(cmp_nvim_lsp.default_capabilities) == "function" then
				capabilities = cmp_nvim_lsp.default_capabilities()
			else
				capabilities = vim.lsp.protocol.make_client_capabilities()
			end
		end

		-- on_attach hook left intentionally minimal: buffer-local keymaps
		-- are provided by `plugin/lsp/lsp.lua` (LspAttach autocmd).
		local on_attach = function(client, bufnr)
			-- placeholder for server-specific on_attach logic
		end

		-- helper for each server
		local function setup_server(server)
			local opts = {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			-- per-server tweaks
			if server == "lua_ls" then
				opts.settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
						},
					},
				}
			end

			if server == "pyright" then
				opts.before_init = function(_, config)
					-- Walk up from cwd to find a venv (handles .venv, venv, .env, env)
					local venv_names = { ".venv", "venv", ".env", "env" }
					local cwd = vim.fn.getcwd()
					for _, name in ipairs(venv_names) do
						local found = vim.fn.finddir(name, cwd .. ";")
						if found ~= "" then
							local python = vim.fn.fnamemodify(found, ":p") .. "bin/python"
							if vim.fn.executable(python) == 1 then
								config.settings = config.settings or {}
								config.settings.python = config.settings.python or {}
								config.settings.python.pythonPath = python
								break
							end
						end
					end
				end
			end

			-- add more if you want, e.g.
			-- if server == "ts_ls" then ... end
			-- if server == "emmet_ls" then ... end

			-- Use the new Neovim 0.11+ API: `vim.lsp.config` and `vim.lsp.enable`.
			-- Wrap in pcall so missing configs (e.g. non-LSP tools like stylua)
			-- don't crash plugin startup.
			local ok, err = pcall(function()
				vim.lsp.config(server, opts or {})
				-- enable will activate the config for its filetypes
				vim.lsp.enable(server)
			end)
			if not ok then
				vim.notify("lspconfig: failed to configure '" .. server .. "': " .. tostring(err), vim.log.levels.WARN)
			end
		end
		-- IMPORTANT PART: no setup_handlers here.
		-- mason-lspconfig is already configured in mason.lua,
		-- so we just ask which servers are installed and set them up.
		for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
			setup_server(server)
		end
	end,
}
