-- Test for fidget.nvim
local M = {}

-- Send a progress event to the active LSP client
local function send(kind, extra)
	local client = vim.lsp.get_active_clients({ bufnr = 0 })[1]
	if not client then
		print("FidgetTest: no active LSP client for this buffer")
		return
	end

	vim.lsp.handlers["$/progress"](nil, {
		token = "fidget-test",
		value = vim.tbl_extend("force", { kind = kind }, extra or {}),
	}, { client_id = client.id })
end

-- Register the :FidgetTest command
function M.setup()
	vim.api.nvim_create_user_command("FidgetTest", function(opts)
		-- optional argument: seconds (default = 10)
		local duration = tonumber(opts.args) or 10
		local total_ms = math.floor(duration * 1000)

		-- begin
		send("begin", {
			title = "Fidget Test Task",
			message = string.format("Duration %.1fs", duration),
			percentage = 0,
		})

		-- halfway
		vim.defer_fn(function()
			send("report", { message = "Halfway", percentage = 50 })
		end, math.floor(total_ms / 2))

		-- end
		vim.defer_fn(function()
			send("end", { message = "Done" })
		end, total_ms)
	end, { nargs = "?" })
end

return M
