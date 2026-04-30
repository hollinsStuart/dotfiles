return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd", "prettier", stop_after_first = true },

			python = { "isort", "black" },
			rust = { "rustfmt" },

			go = { "goimports", "gofmt" },
			cpp = { "clang-format" },
			markdown = { "prettierd", "prettier", stop_after_first = true },

			json = { "prettierd", "prettier", "jq", stop_after_first = true },
			toml = { "taplo" },
			yaml = { "prettierd", "prettier", "yamlfmt", stop_after_first = true },
		},

		format_on_save = function(bufnr)
			-- Optional: disable for big files
			local max_size = 200 * 1024 -- 200kb
			local name = vim.api.nvim_buf_get_name(bufnr)
			local ok, stats = pcall(vim.loop.fs_stat, name)
			if ok and stats and stats.size > max_size then
				vim.notify(
					"Skipping format (file > 200KB): " .. vim.fs.basename(name),
					vim.log.levels.WARN,
					{ title = "Conform" }
				)
				return
			end
			vim.notify("Formatted!", vim.log.levels.INFO, { title = "Conform" })

			return {
				timeout_ms = 3000,
				lsp_format = "fallback", -- run LSP if no external formatter
			}
		end,
	},
}
