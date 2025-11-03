local on_attach = require("utils.lsp").on_attach
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local server_builders = {
	lua_ls = require("servers.lua_ls"),
	pyright = require("servers.pyright"),
	gopls = require("servers.gopls"),
	jsonls = require("servers.jsonls"),
	ts_ls = require("servers.ts_ls"),
	bashls = require("servers.bashls"),
	clangd = require("servers.clangd"),
	dockerls = require("servers.dockerls"),
	yamlls = require("servers.yamlls"),
	tailwindcss = require("servers.tailwindcss"),
	rust_analyzer = require("servers.rust_analyzer"),
	efm = require("servers.efm-langserver"),
}

for name, build in pairs(server_builders) do
	local ok, overrides = pcall(build, capabilities, on_attach)
	if not ok then
		vim.notify(
			string.format("[lsp] Failed to configure %s: %s", name, overrides),
			vim.log.levels.ERROR,
			{ title = "LSP Setup" }
		)
	else
		local config = vim.tbl_deep_extend("force", {
			capabilities = capabilities,
			on_attach = on_attach,
		}, overrides or {})
		vim.lsp.config(name, config)
		vim.lsp.enable(name)
	end
end
