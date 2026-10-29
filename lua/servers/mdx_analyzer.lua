-- ================================================================================================
-- TITLE : mdx_analyzer (MDX Language Server) LSP Setup
-- ABOUT : TypeScript-based IntelliSense for .mdx (Astro content collections, MDX components)
-- LINKS :
--   > github: https://github.com/mdx-js/mdx-analyzer
-- NOTE  : nvim-lspconfig's bundled defaults pass only `typescript.tsdk` (filled in by its
--         before_init). Without `typescript.enabled = true` the server registers a
--         *syntactic-only* TypeScript plugin -- no hover, completion or type diagnostics.
--         See @mdx-js/language-server lib/index.js (the `tsEnabled` branch).
--         Type checking of the MDX body additionally needs `"mdx": { "checkMdx": true }`
--         in the project's tsconfig.json.
-- ================================================================================================

--- Resolve the TypeScript library directory handed to the server as `typescript.tsdk`.
--- lspconfig's helper returns "" when the project has no node_modules/typescript, and the
--- server asserts on an empty tsdk ("Can't find typescript.js or tsserverlibrary.js"), so
--- fall back to the copy mason ships with typescript-language-server.
--- @param root_dir string|nil
--- @return string|nil
local function resolve_tsdk(root_dir)
	local tsdk = require("lspconfig.util").get_typescript_server_path(root_dir)
	if tsdk ~= "" then
		return tsdk
	end

	local fallback =
		vim.fs.joinpath(vim.fn.stdpath("data"), "mason/packages/typescript-language-server/node_modules/typescript/lib")
	if vim.uv.fs_stat(vim.fs.joinpath(fallback, "typescript.js")) then
		return fallback
	end

	return nil
end

--- @return table server configuration overrides
return function()
	return {
		filetypes = { "mdx" },
		init_options = {
			typescript = {
				enabled = true,
			},
		},
		before_init = function(_, config)
			local tsdk = resolve_tsdk(config.root_dir)
			if not tsdk then
				vim.notify(
					"[lsp] mdx_analyzer: no TypeScript found; install it in the project (npm i -D typescript)",
					vim.log.levels.WARN,
					{ title = "LSP Setup" }
				)
			end
			config.init_options.typescript.tsdk = tsdk
		end,
	}
end
