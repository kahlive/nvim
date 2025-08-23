## Neovim 設定概要

本リポジトリは、`lazy.nvim` を用いた Neovim 設定です。快適な編集体験のために LSP、補完、Treesitter、ファイルツリー、Git 連携、検索 UI、ターミナル連携などを構成しています。配色は Nightfly をベースにしつつ、ハイライトと背景透過を細かく調整しています。

- プラグイン管理: [folke/lazy.nvim]
- メインテーマ: [bluz71/vim-nightfly-guicolors]（独自ハイライト・透過設定あり）
- 主要機能: LSP/フォーマット、補完、Treesitter、Telescope、NvimTree、GitSigns、ステータスライン、ターミナル、スクロールバー、WhichKey など


## セットアップ

1. この設定を `~/.config/nvim` に配置
2. 初回起動で `lazy.nvim` が自動ブートストラップされます
3. `:Lazy` でプラグイン状態を確認・同期
4. `:Mason` で必要な LSP サーバやフォーマッタ等をインストール
5. `:TSUpdate` で Treesitter パーサのインストール/更新

推奨ツール（いずれも必要に応じて）
- ripgrep（Telescope のライブ grep に使用）
- C/C++ ビルド環境（`telescope-fzf-native`・Treesitter ビルド等）
- 各言語ごとの LSP/formatter/linter バイナリ（下記参照）


## ベース設定（`lua/config/*.lua`）

- `globals.lua`
  - `mapleader` / `maplocalleader`: スペース

- `options.lua`（主要項目）
  - 行番号: `number = true`、相対行番号は無効
  - カーソル行: `cursorline = true`
  - 折り返し: `wrap = true`
  - インデント: 2 スペース（`tabstop/shiftwidth/softtabstop = 2`, `expandtab = true`）
  - 検索: 大文字含む場合のみ厳密（`ignorecase/smartcase`）
  - UI: `termguicolors`, `signcolumn = yes`, `colorcolumn = 100`
  - クリップボード: `unnamedplus` 使用
  - フォールド: Treesitter 連携（`foldmethod=expr`, `foldexpr=vim.treesitter.foldexpr()`）
  - `guicursor` を詳細設定、スプリットは右/下に開く
  - Undo 永続化: `undofile = true`（`~/.local/share/nvim/undodir` を自動作成）
  - netrw 系は無効化（`lazy.nvim` の `rtp.disabled_plugins`）

- `keymaps.lua`（抜粋）
  - 検索/移動時に画面中央寄せ: `n/N/<C-d>/<C-u>` を `zz` 付きに再定義
  - すべて選択: `<leader>aa`
  - バッファ移動: `<leader>bn` / `<leader>bp`
  - Visual 時のインデント保持: `<` / `>`
  - 行連結をカーソル保持で: `J`

- `autocmds.lua`
  - 前回カーソル位置を復元（`BufReadPost`）
  - ヤンクした範囲を 200ms ハイライト
  - フォーマット on save（EFM）用の自動コマンドはコメントアウト済み


## テーマと UI

- `nightfly` を適用し、ハイライトグループを多数上書き
- 背景透過（`Normal/NormalNC/EndOfBuffer/SignColumn/VertSplit/LineNr/CursorLine` などの `guibg=NONE`）
- ステータスライン: `nvim-lualine/lualine.nvim`
  - セパレータやファイル名表示を調整、`copilot-lualine` セクション対応
- ファイルツリー: `nvim-tree/nvim-tree.lua`
  - トグル: `<leader>e`
  - `.git` 表示、相対行番号、アイコン類は `lua/utils/icons.lua` に集約
- スクロールバー: `petertriho/nvim-scrollbar`（診断・検索・GitSigns と連携）
- 検索強化: `nvim-hlslens`（`n`/`N` に連携してヒット数表示、`zz` センターリング）
- インデントガイド: `indent-blankline.nvim`（`ibl`）
- カラー表示: `nvim-colorizer.lua`
- アイコン: `nvim-web-devicons`
- ダッシュボード: `alpha-nvim`
- ミニユーティリティ: `mini.comment`, `mini.indentscope`, `mini.pairs`, `mini.notify`


## 検索（Telescope）

- `nvim-telescope/telescope.nvim` + `telescope-fzf-native`
- 主なキーマップ（WhichKey にも表示）
  - `<leader>ff`: ファイル検索
  - `<leader>ft`: テキスト検索（live grep、`.git` 除外、隠しファイル含む）
  - `<leader>fd`: 診断一覧
  - `<leader>fr`: 最近使ったファイル
  - `<leader>bb`: バッファ一覧（`dd` で削除）
  - `<leader>fb`/`fc`/`fs`: Git ブランチ/コミット/ステータス


## ターミナル（toggleterm）

- Alt+1: 横分割、Alt+2: 縦分割、Alt+3: 浮動ウィンドウ
- ターミナル内ナビゲーション: `<M-h/j/k/l>` でウィンドウ移動
- `TermEnter` で自動的に Insert モード


## LSP（`nvim-lspconfig` + `mason.nvim`）

- 付随ユーティリティ
  - 診断アイコン: `lua/utils/diagnostics.lua` + `lua/utils/icons.lua`
  - バッファローカル LSP キーマップ（`utils/lsp.lua`）
    - 例: `gd` 定義, `K` ホバー, `gr` 参照, `gl` 浮動診断
    - `\<leader>z`: `vim.lsp.buf.format()` で同期フォーマット
    - `\<leader>oi`: organize imports（対応サーバのみ）→フォーマット自動実行

- 有効化サーバ（`lua/servers/*.lua`）
  - `lua_ls`: `vim` をグローバルとして許可、設定ディレクトリを workspace library に追加
  - `pyright`: ワークスペース解析、ライブラリ型参照有効
  - `gopls`: Go 用（`filetypes = {"go"}`）
  - `jsonls`: JSON/JSONC
  - `ts_ls`: TypeScript/JavaScript/React 系、インデント 2 スペース
  - `bashls`: sh/bash/zsh
  - `clangd`: `--offset-encoding=utf-16` を指定
  - `dockerls`: Dockerfile
  - `yamlls`: SchemaStore のスキーマ例（docker-compose 等）/ 検証と整形有効
  - `tailwindcss`: JS/TS/Vue/Svelte でのクラス補完
  - `rust_analyzer`: clippy, allFeatures、有用な inlay hints を選択的に有効/無効


## Lint/Format（`efm-langserver`）

`efm-langserver` 経由で各言語の linter/formatter を一元管理します（`lua/servers/efm-langserver.lua`）。インストール例:

- Lua: `luacheck`, `stylua`
- Python: `flake8`, `black`
- Go: `go_revive`, `gofumpt`
- Web: `eslint_d`, `prettier_d`（TS/JS/JSON/HTML/CSS/React/Svelte/Vue など）
- JSON: `fixjson`
- Shell: `shellcheck`, `shfmt`
- Docker: `hadolint`
- C/C++: `cpplint`, `clang-format`

保存時フォーマットはサンプルの自動コマンドをコメントアウト済み（`autocmds.lua`）。必要ならコメントを外してください。


## 補完（`nvim-cmp`）

- 依存: `LuaSnip`, `lspkind`, `friendly-snippets`, `cmp-*` 系
- Tailwind 連携: `tailwind-tools.nvim` の `cmp` フォーマッタを統合
- 主な操作
  - `<C-j>/<C-k>` or `<Down>/<Up>`: 候補移動
  - `<CR>`: 候補確定（未選択時は先頭を選択）
  - `<Tab>/<S-Tab>`: 候補選択 or スニペット展開/ジャンプ
  - ドキュメント枠: 角丸、スクロール `<C-b>/<C-f>`


## Treesitter

- 主な対象: `lua`, `c/cpp`, `rust`, `javascript/typescript/tsx`, `css`, `python`, `bash`, `markdown(_inline)`, `dockerfile`, `json`, `go`, `yaml`, `toml`, `html`, `vim` など
- インクリメンタル選択: `Enter` で拡張、`Shift-Tab` 縮小、`Tab` でスコープ
- インデント/ハイライト有効、`auto_install = true`


## Markdown / CSV

- Markdown レンダリング: `MeanderingProgrammer/markdown.nvim`
  - 備考: 設定キーが `confing` になっており、`config` に修正しないと読み込まれません
- CSV の色分け: `cameron-wags/rainbow_csv.nvim`


## WhichKey グループ（抜粋）

- `<leader>f`: Find（Telescope）
- `<leader>g`: Git（GitSigns）
- `<leader>b`: Buffers
- `<leader>a`: Tab 操作
- `<leader>l`: LSP
- `<leader>t`: Test（予約）
- `<leader>p`: Plugins（予約）
- `<leader>h`: 検索ハイライト消去
- `<leader>q`: 終了


## 既知の注意点 / メモ

- `README.md` は設定のドキュメントのみを目的としています
- `markdown.nvim` の `config` タイポにより、現状自動設定が走りません（必要なら修正）
- `lazy.lua` で `netrw` を無効化しています（`nvim-tree` を使用）
- `init.lua` は `config.lazy` のみを読み込み、そこから各設定を初期化


## 参考

- lazy.nvim: https://github.com/folke/lazy.nvim
- nvim-lspconfig: https://github.com/neovim/nvim-lspconfig
- telescope.nvim: https://github.com/nvim-telescope/telescope.nvim
- nvim-cmp: https://github.com/hrsh7th/nvim-cmp
- nvim-tree: https://github.com/nvim-tree/nvim-tree.lua
- gitsigns.nvim: https://github.com/lewis6991/gitsigns.nvim
- nvim-treesitter: https://github.com/nvim-treesitter/nvim-treesitter
