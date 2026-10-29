-- ================================================================================================
-- TITLE : efm-langserver
-- ABOUT : a general purpose language server protocol implemented here for linters/formatters
-- LINKS :
--   > github : https://github.com/mattn/efm-langserver
--   > configs: https://github.com/creativenull/efmls-configs-nvim/tree/main
-- ================================================================================================

--- @return table server configuration overrides
return function()
	local fs = require("efmls-configs.fs")
	local luacheck = require("efmls-configs.linters.luacheck") -- lua linter
	local stylua = require("efmls-configs.formatters.stylua") -- lua formatter
	local ruff_lint = {
		lintCommand = "ruff check --ignore=E701,C901 --line-length=100 --quiet --output-format github --stdin-filename ${INPUT}",
		lintStdin = true,
		-- lint on open too; efm otherwise only lints on change/save (LintAfterOpen defaults to false)
		lintAfterOpen = true,
		lintFormats = {
			"::%trror title=%.%#,file=%.%#,line=%.%#,col=%.%#,endLine=%.%#,endColumn=%.%#::%f:%l:%c: %m",
			"::%tarning title=%.%#,file=%.%#,line=%.%#,col=%.%#,endLine=%.%#,endColumn=%.%#::%f:%l:%c: %m",
		},
	}
	local ruff_sort = require("efmls-configs.formatters.ruff_sort") -- python import sorter
	local ruff_fmt = require("efmls-configs.formatters.ruff") -- python formatter
	-- python type checker (dmypy daemon, used alongside pyright).
	-- Runs dmypy without explicit target so pyproject.toml files=/exclude are
	-- honoured. --follow-imports=normal overrides "silent" which dmypy rejects.
	-- Requires both a project marker and a project-local .venv/venv dmypy; giving up
	-- on either is mandatory, since dmypy keys its daemon by cwd and would otherwise
	-- spawn one immortal daemon per directory under an unrelated interpreter.
	-- --status-file is kept outside the repo so that removing untracked files cannot
	-- orphan a live daemon, and --timeout lets an orphan reap itself.
	local mypy = {
		prefix = "mypy",
		lintCommand = [[sh -c '
f="$1"; d=$(dirname "$f"); root=""
while [ "$d" != "/" ]; do
  for m in pyproject.toml mypy.ini setup.cfg; do
    [ -f "$d/$m" ] && root="$d" && break
  done
  [ -n "$root" ] && break; d=$(dirname "$d")
done
[ -z "$root" ] && exit 0
DMYPY=""
d2=$(dirname "$f")
while [ "$d2" != "/" ]; do
  for v in .venv venv; do
    [ -x "$d2/$v/bin/dmypy" ] && DMYPY="$d2/$v/bin/dmypy" && break
  done
  [ -n "$DMYPY" ] && break; d2=$(dirname "$d2")
done
[ -z "$DMYPY" ] && exit 0
STATUS_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/dmypy"
mkdir -p "$STATUS_DIR" || exit 0
STATUS="$STATUS_DIR/$(basename "$root")-$(printf %s "$root" | md5sum | cut -c1-8).json"
cd "$root" || exit 0
rel=${f#"$root"/}
"$DMYPY" --status-file "$STATUS" run --timeout 3600 -- --show-column-numbers --no-error-summary --follow-imports=normal 2>/dev/null | sed -n "s#^${rel}:#${f}:#p"
' _ ${INPUT}]],
		lintStdin = false,
		-- mypy reads the file from disk (lintStdin=false), so it can never see unsaved
		-- edits. Run it only on open + save (not on every change) to avoid wasted dmypy
		-- invocations against stale content.
		lintAfterOpen = true,
		lintOnSave = true,
		-- The wrapper always exits 0 (piped through sed); without this efm treats
		-- a zero exit as "no problems" and discards the parsed diagnostics.
		lintIgnoreExitCode = true,
		lintFormats = {
			"%f:%l:%c: %trror: %m",
			"%f:%l:%c: %tarning: %m",
			"%f:%l:%c: %tote: %m",
		},
		rootMarkers = {
			"mypy.ini",
			"pyproject.toml",
			"setup.cfg",
		},
	}
	local go_revive = require("efmls-configs.linters.go_revive") -- go linter
	local gofumpt = require("efmls-configs.formatters.gofumpt") -- go formatter
	local prettier_d = require("efmls-configs.formatters.prettier_d") -- ts/js/solidity/json/docker/html/css/react/svelte/vue formatter
	local oxlint = {
		prefix = "oxlint",
		lintCommand = string.format("%s --format=unix ${INPUT}", fs.executable("oxlint", fs.Scope.NODE)),
		lintStdin = false,
		lintFormats = {
			"%f:%l:%c: %m [%trror/%.%#]",
			"%f:%l:%c: %m [%tarning/%.%#]",
		},
		rootMarkers = {
			".oxlintrc.json",
			"oxlint.config.json",
			"package.json",
		},
	}
	local fixjson = require("efmls-configs.formatters.fixjson") -- json formatter
	local shellcheck = require("efmls-configs.linters.shellcheck") -- bash linter
	local shfmt = require("efmls-configs.formatters.shfmt") -- bash formatter
	local hadolint = require("efmls-configs.linters.hadolint") -- docker linter
	local cpplint = require("efmls-configs.linters.cpplint") -- c/cpp linter
	local clangformat = require("efmls-configs.formatters.clang_format") -- c/cpp formatter

	return {
		filetypes = {
			"c",
			"cpp",
			"css",
			"docker",
			"go",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"mdx",
			"python",
			"sh",
			"svelte",
			"typescript",
			"typescriptreact",
			"vue",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			-- Do not advertise document symbols to avoid conflicting with nvim-navic
			documentSymbol = false,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				c = { clangformat, cpplint },
				cpp = { clangformat, cpplint },
				css = { prettier_d },
				docker = { hadolint, prettier_d },
				go = { gofumpt, go_revive },
				html = { prettier_d },
				javascript = { oxlint, prettier_d },
				javascriptreact = { oxlint, prettier_d },
				json = { fixjson },
				jsonc = { fixjson },
				lua = { luacheck, stylua },
				markdown = { prettier_d },
				mdx = { prettier_d },
				python = { ruff_lint, ruff_sort, ruff_fmt, mypy },
				sh = { shellcheck, shfmt },
				svelte = { prettier_d },
				typescript = { oxlint, prettier_d },
				typescriptreact = { oxlint, prettier_d },
				vue = { prettier_d },
			},
		},
	}
end
