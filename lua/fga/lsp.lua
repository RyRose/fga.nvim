local M = {}

function M.setup(opts)
	opts = opts or {}

	if not pcall(require, "lspconfig") then
		vim.notify("lspconfig is required not installed", vim.log.levels.ERROR)
		return
	end

	local configs = require("lspconfig.configs")

	if not configs.openfga then
		configs.openfga = {
			default_config = {
				cmd = { opts.lsp_server, "--stdio" },
				filetypes = { "fga" },
				root_dir = function(fname)
					return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
				end,
				settings = {},
			},
		}
	end
	configs.openfga.setup({})
end

return M
