-- ================================================================================================
-- TITLE : mini.nvim
-- LINKS :
--   > github : https://github.com/echasnovski/mini.nvim
-- ABOUT : Library of 40+ independent Lua modules.
-- ================================================================================================

return {
	{
		"echasnovski/mini.comment",
		version = "*",
		opts = {
			-- Use Treesitter context to compute correct commentstring (e.g. JSX/TSX)
			options = {
				custom_commentstring = function()
					local ok, internal = pcall(require, "ts_context_commentstring.internal")
					if ok and internal then
						return internal.calculate_commentstring() or vim.bo.commentstring
					end
					return vim.bo.commentstring
				end,
			},
		},
	},
	{ "echasnovski/mini.pairs", version = "*", opts = {} },
	{ "echasnovski/mini.notify", version = "*", opts = {} },
	-- Context-aware commentstrings for JSX/TSX and friends
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		init = function()
			-- Stop loading deprecated nvim-treesitter module
			vim.g.skip_ts_context_commentstring_module = true
		end,
		opts = {},
		config = function(_, opts)
			require("ts_context_commentstring").setup(opts)
		end,
	},
}
