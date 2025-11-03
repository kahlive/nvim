-- lua/utils/mytheme.lua
-- 深海×苔×神々しい光の独自テーマ．
-- 半透明はターミナル側の不透明度設定と併用する．Neovim側は“塗らない”＝bg=NONEで対応．

local M = {}

-- 透明にしたいなら true，不透明に戻すなら false
local TRANSPARENT = true

-- パレット
local P = {
  bg         = "#061922",
  bg_alt     = "#0a2230",
  surface    = "#0e2a36",
  text       = "#9fb3bd",
  muted      = "#6c8690",
  moss       = "#43a66a",
  moss_dim   = "#2f7d4e",
  ocean      = "#1a9acb",
  ocean_dim  = "#117c9f",
  light      = "#eacb5e",
  light_cool = "#b6efff",
  magenta    = "#c04f8a",
  amber      = "#d78e2f",
  blue       = "#3992ff",
  -- diagnostics 用の明快色
  red        = "#ff6b6b",  -- Error
  yellow     = "#ffd166",  -- Warn
  cyan       = "#5fd7ff",  -- Info
  green      = "#7ce38b",  -- Hint
}

-- オプション：仮想テキストやインレイヒントに薄いソリッド背景を付けたい時は true
local SOFT_SOLID_VTEXT_BG = false
local SOFT_BG = "#10252f"  -- うっすら見える青系の面

local function none(bg) return (TRANSPARENT and "NONE" or bg) end
local function soft(bg) return (SOFT_SOLID_VTEXT_BG and bg or "NONE") end
local function H(grp, spec) vim.api.nvim_set_hl(0, grp, spec) end

function M.setup(opts)
  if opts then
    if opts.transparent ~= nil then TRANSPARENT = opts.transparent end
    if opts.soft_solid_vtext_bg ~= nil then SOFT_SOLID_VTEXT_BG = opts.soft_solid_vtext_bg end
  end
  vim.opt.termguicolors = true

  ---------------------------------------------------------------------------
  -- 基本UI（透明時は“塗らない”）
  ---------------------------------------------------------------------------
  H("Normal",        { fg = P.text,   bg = none(P.bg) })
  H("NormalNC",      { fg = P.muted,  bg = none(P.bg) })
  H("WinSeparator",  { fg = P.surface, bg = none(P.bg) })
  H("CursorLine",    { bg = none(P.bg_alt) })
  H("LineNr",        { fg = "#0C8B86", bg = "NONE" })
  H("CursorLineNr",  { fg = "#58DCCE", bold = true, bg = "NONE" })

  -- 浮動ウィンドウ／メニュー
  H("NormalFloat",   { fg = P.text,   bg = none(P.bg) })
  H("FloatBorder",   { fg = P.surface, bg = none(P.bg) })
  H("Pmenu",         { fg = P.text,   bg = none(P.surface) })
  H("PmenuSbar",     { bg = none(P.surface) })
  H("PmenuThumb",    { bg = none(P.moss) })

  -- ステータス／タブ／ウィンバー
  H("StatusLine",    { fg = P.text,  bg = "NONE" })
  H("StatusLineNC",  { fg = P.muted, bg = "NONE" })
  H("WinBar",        { fg = P.text,  bg = "NONE" })
  H("WinBarNC",      { fg = P.muted, bg = "NONE" })
  H("TabLine",       { fg = P.muted, bg = "NONE" })
  H("TabLineSel",    { fg = P.bg,    bg = "NONE", bold = true })
  H("TabLineFill",   { bg = "NONE" })

  ---------------------------------------------------------------------------
  -- 選択系（TRANSPARENTでも背景を“塗る”）
  ---------------------------------------------------------------------------
  H("Visual",        { bg = P.ocean_dim })
  H("VisualNOS",     { bg = P.ocean_dim })
  H("PmenuSel",      { fg = P.bg, bg = P.ocean })
  H("TelescopeNormal",          { bg = "NONE" })
  H("TelescopeBorder",          { bg = "NONE", fg = P.surface })
  H("TelescopePromptNormal",    { bg = "NONE" })
  H("TelescopePromptBorder",    { bg = "NONE", fg = P.surface })
  H("TelescopeSelection",       { bg = P.ocean_dim, bold = true })
  H("TelescopeSelectionCaret",  { fg = P.light_cool, bg = P.ocean_dim, bold = true })
  H("QuickFixLine",  { bg = P.ocean_dim, bold = true })

  ---------------------------------------------------------------------------
  -- Diagnostics（一式）
  ---------------------------------------------------------------------------
  H("DiagnosticError", { fg = P.red,    bg = "NONE" })
  H("DiagnosticWarn",  { fg = P.yellow, bg = "NONE" })
  H("DiagnosticInfo",  { fg = P.cyan,   bg = "NONE" })
  H("DiagnosticHint",  { fg = P.green,  bg = "NONE" })

  H("DiagnosticSignError", { fg = P.red,    bg = "NONE" })
  H("DiagnosticSignWarn",  { fg = P.yellow, bg = "NONE" })
  H("DiagnosticSignInfo",  { fg = P.cyan,   bg = "NONE" })
  H("DiagnosticSignHint",  { fg = P.green,  bg = "NONE" })

  H("DiagnosticVirtualTextError", { fg = P.red,    bg = soft(SOFT_BG) })
  H("DiagnosticVirtualTextWarn",  { fg = P.yellow, bg = soft(SOFT_BG) })
  H("DiagnosticVirtualTextInfo",  { fg = P.cyan,   bg = soft(SOFT_BG) })
  H("DiagnosticVirtualTextHint",  { fg = P.green,  bg = soft(SOFT_BG) })

  H("DiagnosticUnderlineError", { sp = P.red,    undercurl = true })
  H("DiagnosticUnderlineWarn",  { sp = P.yellow, undercurl = true })
  H("DiagnosticUnderlineInfo",  { sp = P.cyan,   undercurl = true })
  H("DiagnosticUnderlineHint",  { sp = P.green,  undercurl = true })

  H("DiagnosticFloatingError", { fg = P.red,    bg = "NONE" })
  H("DiagnosticFloatingWarn",  { fg = P.yellow, bg = "NONE" })
  H("DiagnosticFloatingInfo",  { fg = P.cyan,   bg = "NONE" })
  H("DiagnosticFloatingHint",  { fg = P.green,  bg = "NONE" })

  H("ErrorMsg",   { fg = P.red,    bg = "NONE", bold = true })
  H("WarningMsg", { fg = P.yellow, bg = "NONE", bold = true })

  ---------------------------------------------------------------------------
  -- LSP 一式
  ---------------------------------------------------------------------------
  H("LspReferenceText",  { bg = P.surface })
  H("LspReferenceRead",  { bg = P.surface })
  H("LspReferenceWrite", { bg = P.surface })

  H("LspCodeLens",          { fg = P.muted, bg = "NONE", italic = true })
  H("LspCodeLensSeparator", { fg = P.muted, bg = "NONE" })

  H("LspInlayHint", { fg = P.muted, bg = soft(SOFT_BG), italic = true })

  H("LspSignatureActiveParameter", { fg = P.text, bg = P.ocean_dim, bold = true })

  H("LspInfoBorder", { fg = P.surface, bg = "NONE" })
  H("LspInfoTitle",  { fg = P.light_cool, bg = "NONE", bold = true })

  ---------------------------------------------------------------------------
  -- シンタックス（苔＋海＋光）
  ---------------------------------------------------------------------------
  H("Comment", { fg = "#00BB00" })
  H("DiagnosticUnnecessary", { fg = "#3B4B53" })

  H("@keyword", { fg = P.moss_dim })
  H("@operator", { fg = P.moss })
  H("@keyword.operator", { fg = P.moss })
  H("@keyword.conditional", { fg = P.moss })
  H("@keyword.exception", { fg = P.moss })
  H("@keyword.repeat", { fg = P.moss })
  H("@keyword.import", { fg = P.amber })
  H("@keyword.directive", { fg = P.amber })
  H("@keyword.directive.define", { fg = P.amber })

  H("Type", { fg = P.amber })
  H("@type", { fg = P.amber })
  H("@type.builtin", { fg = P.amber })
  H("@type.definition", { fg = P.amber })
  H("@type.qualifier", { fg = P.moss })

  H("@string", { fg = "#0D9488" })
  H("@string.escape", { fg = P.amber })
  H("@number", { fg = P.magenta })
  H("@float",  { fg = P.magenta })
  H("@boolean",{ fg = P.amber })

  H("@text.definition", { fg = P.light_cool })
  H("@text.literal",    { fg = P.light_cool })
  H("@text.reference",  { fg = P.light_cool })
  H("@text.title",      { fg = P.light_cool })
  H("@text.uri",        { fg = P.light_cool, underline = true })
  H("@text.underline",  { fg = P.light_cool, underline = true })
  H("@text.todo",       { fg = P.light_cool })

  H("@punctuation", { fg = P.text })
  H("Function",     { fg = P.text })
  H("@function",    { fg = P.text })
  H("@function.builtin", { fg = P.text })
  H("@function.macro",   { fg = P.text }) -- 後のデコレータ用で上書き
  H("@function.call",    { fg = P.text })
  H("@function.method",  { fg = P.text })
  H("@function.method.call", { fg = P.text })
  H("@method",       { fg = P.text })
  H("@field",        { fg = P.text })
  H("@property",     { fg = P.text })
  H("@variable",     { fg = P.text })
  H("@variable.member",   { fg = P.text })
  H("@variable.property", { fg = P.text })
  H("@variable.parameter",{ fg = P.text })
  H("@variable.builtin",  { fg = P.blue })
  H("@namespace",    { fg = P.text })
  H("@structure",    { fg = P.text })
  H("@constant",     { fg = P.text })
  H("@constant.builtin", { fg = P.amber })
  H("@constant.macro",   { fg = P.amber })
  H("@module",           { fg = P.amber })
  H("@constructor",      { fg = P.blue })
  H("@tag",              { fg = P.blue })

  -- ★ FastAPI 等のデコレータを明るく（@ と decorator 名）
  H("@punctuation.special", { fg = P.ocean })            -- 「@」
  H("@attribute",           { fg = P.ocean, italic = true })  -- decorator 名
  H("@function.macro",      { fg = P.ocean, italic = true })  -- 実装により decorator がここに来る
  pcall(function() H("@decorator", { fg = P.ocean, italic = true }) end) -- 互換用

  -- 任意：通常のメソッド呼び出しも少し明るくしたいなら
  H("@method",       { fg = P.light_cool })
  H("@method.call",  { fg = P.light_cool })

  ---------------------------------------------------------------------------
  -- 検索の視認性
  ---------------------------------------------------------------------------
  H("Search",     { fg = P.bg, bg = P.ocean })
  H("IncSearch",  { fg = P.bg, bg = P.moss })
  H("CurSearch",  { fg = P.bg, bg = P.light })
  H("MatchParen", { fg = P.light_cool, bg = P.surface, bold = true })
end

-- lualine：明るい配色で統一（背景はデフォルト透明，必要ならソリッドへ）
function M.lualine_theme()
  local SOLID_BRIGHT_BG = false  -- 明るい帯を塗りたい時は true
  local FG_MAIN   = P.light_cool
  local FG_STRONG = P.light
  local BG        = SOLID_BRIGHT_BG and "#143745" or "NONE"

  local function sec () return { fg = FG_MAIN,  bg = BG } end
  local function secA() return { fg = FG_STRONG, bg = BG, gui = "bold" } end
  local function ina () return { fg = P.muted,  bg = BG } end

  return {
    normal   = { a = secA(), b = sec(), c = sec() },
    insert   = { a = secA(), b = sec(), c = sec() },
    visual   = { a = secA(), b = sec(), c = sec() },
    replace  = { a = secA(), b = sec(), c = sec() },
    command  = { a = secA(), b = sec(), c = sec() },
    inactive = { a = ina(),  b = ina(), c = ina() },
  }
end

return M
