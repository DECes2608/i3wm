-- dagzirvesi-mono.lua
-- Monochrome (gri tonlama) versiyon + sert köşeli float pencereler

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "dagzirvesi-mono"
vim.o.termguicolors = true

-- Float pencere kenarlıklarını köşeli yap (yuvarlak değil)
vim.o.winborder = "single"

local c = {
  -- Arka planlar (transparan için NONE)
  bg = "NONE",
  bg1 = "#161616", -- float, popup arka planı
  bg2 = "#1e1e1e", -- satır numarası, cursorline
  bg3 = "#262626", -- seçim, visual
  bg4 = "#404040", -- border, separator

  -- Ön planlar
  fg = "#e8e8e8", -- ana metin
  fg2 = "#a8a8a8", -- yorumlar, soluk metin
  fg3 = "#6e6e6e", -- satır numaraları
  fg4 = "#454545", -- çok soluk (yok sayılan)

  -- Vurgu 1 (eskiden turuncu)
  accent = "#cfcfcf", -- cursor, eşleşme, önemli
  accent2 = "#e4e4e4", -- keyword, bold vurgu
  accent3 = "#f4f4f4", -- string, en açık ton
  accent4 = "#7a7a7a", -- hata alt çizgisi

  -- Vurgu 2 (eskiden teal)
  muted = "#888888", -- fonksiyon adları
  muted2 = "#a2a2a2", -- tip, class
  muted3 = "#bcbcbc", -- özel değişkenler
  muted4 = "#d6d6d6", -- operator

  -- Beyaz tonları
  snow = "#e8e8e8", -- normal metin
  snow2 = "#fafafa", -- bold metin

  -- Semantik (grinin farklı tonları + stil ile ayrışır)
  red = "#f0f0f0", -- hata (bold ile vurgulu)
  yellow = "#c8c8c8", -- uyarı
  green = "#a0a0a0", -- bilgi / hint
  blue = "#909090", -- özel
}

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Temel editör ──────────────────────────────────────────
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg1 })
hi("NormalNC", { fg = c.fg2, bg = c.bg })
hi("FloatBorder", { fg = c.bg4, bg = c.bg1 })
hi("ColorColumn", { bg = c.bg2 })
hi("Cursor", { fg = c.bg1, bg = c.accent })
hi("CursorLine", { bg = c.bg2 })
hi("CursorLineNr", { fg = c.accent2, bold = true })
hi("LineNr", { fg = c.fg3 })
hi("SignColumn", { fg = c.fg3, bg = c.bg })
hi("VertSplit", { fg = c.bg4, bg = c.bg })
hi("WinSeparator", { fg = c.bg4, bg = c.bg })
hi("StatusLine", { fg = c.fg2, bg = c.bg1 })
hi("StatusLineNC", { fg = c.fg4, bg = c.bg1 })
hi("TabLine", { fg = c.fg3, bg = c.bg1 })
hi("TabLineFill", { bg = c.bg1 })
hi("TabLineSel", { fg = c.accent2, bg = c.bg2, bold = true })
hi("Pmenu", { fg = c.fg, bg = c.bg1 })
hi("PmenuSel", { fg = c.snow2, bg = c.bg3, bold = true })
hi("PmenuSbar", { bg = c.bg2 })
hi("PmenuThumb", { bg = c.accent })
hi("WildMenu", { fg = c.snow2, bg = c.bg3 })

-- ── Arama & seçim ─────────────────────────────────────────
hi("Visual", { bg = c.bg3 })
hi("VisualNOS", { bg = c.bg3 })
hi("Search", { fg = c.bg1, bg = c.accent2 })
hi("IncSearch", { fg = c.bg1, bg = c.accent, bold = true })
hi("CurSearch", { fg = c.bg1, bg = c.accent, bold = true })
hi("Substitute", { fg = c.bg1, bg = c.accent3 })
hi("MatchParen", { fg = c.accent, bold = true, underline = true })

-- ── Sözdizimi ─────────────────────────────────────────────
hi("Comment", { fg = c.fg2, italic = true })
hi("Constant", { fg = c.accent3 })
hi("String", { fg = c.accent3 })
hi("Character", { fg = c.accent3 })
hi("Number", { fg = c.muted3 })
hi("Boolean", { fg = c.accent2, bold = true })
hi("Float", { fg = c.muted3 })
hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.muted2, bold = true })
hi("Statement", { fg = c.accent2 })
hi("Keyword", { fg = c.accent2, bold = true })
hi("Conditional", { fg = c.accent2 })
hi("Repeat", { fg = c.accent2 })
hi("Label", { fg = c.muted2 })
hi("Operator", { fg = c.muted4 })
hi("Exception", { fg = c.red, bold = true })
hi("PreProc", { fg = c.muted3 })
hi("Include", { fg = c.muted2 })
hi("Define", { fg = c.muted2 })
hi("Macro", { fg = c.muted3 })
hi("Type", { fg = c.muted2 })
hi("StorageClass", { fg = c.accent2 })
hi("Structure", { fg = c.muted2 })
hi("Typedef", { fg = c.muted2 })
hi("Special", { fg = c.accent3 })
hi("Underlined", { underline = true })
hi("Bold", { bold = true })
hi("Italic", { italic = true })
hi("Error", { fg = c.red, bold = true })
hi("Todo", { fg = c.accent, bold = true, underline = true })

-- ── Diagnostic ────────────────────────────────────────────
hi("DiagnosticError", { fg = c.red, bold = true })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.muted2 })
hi("DiagnosticHint", { fg = c.fg3 })
hi("DiagnosticUnderlineError", { sp = c.red, underline = true })
hi("DiagnosticUnderlineWarn", { sp = c.yellow, underline = true })
hi("DiagnosticUnderlineInfo", { sp = c.muted2, underline = true })
hi("DiagnosticUnderlineHint", { sp = c.fg3, underline = true })
hi("DiagnosticVirtualTextError", { fg = c.red, italic = true, bold = true })
hi("DiagnosticVirtualTextWarn", { fg = c.yellow, italic = true })
hi("DiagnosticVirtualTextInfo", { fg = c.muted2, italic = true })
hi("DiagnosticVirtualTextHint", { fg = c.fg3, italic = true })

-- ── Git işaretleri (gitsigns) ─────────────────────────────
hi("GitSignsAdd", { fg = c.green })
hi("GitSignsChange", { fg = c.accent2 })
hi("GitSignsDelete", { fg = c.red, bold = true })

-- ── Telescope ─────────────────────────────────────────────
hi("TelescopeNormal", { fg = c.fg, bg = c.bg1 })
hi("TelescopeBorder", { fg = c.bg4, bg = c.bg1 })
hi("TelescopePromptBorder", { fg = c.accent, bg = c.bg1 })
hi("TelescopePromptNormal", { fg = c.snow2, bg = c.bg1 })
hi("TelescopePromptPrefix", { fg = c.accent })
hi("TelescopeSelection", { fg = c.snow2, bg = c.bg3, bold = true })
hi("TelescopeMatching", { fg = c.accent2, bold = true })
hi("TelescopeResultsTitle", { fg = c.muted2 })
hi("TelescopePreviewTitle", { fg = c.muted3 })

-- ── Neo-tree / Nvim-tree ───────────────────────────────────
hi("NeoTreeNormal", { fg = c.fg, bg = c.bg1 })
hi("NeoTreeNormalNC", { fg = c.fg2, bg = c.bg1 })
hi("NeoTreeRootName", { fg = c.accent2, bold = true })
hi("NeoTreeDirectoryName", { fg = c.muted2 })
hi("NeoTreeDirectoryIcon", { fg = c.muted })
hi("NeoTreeFileIcon", { fg = c.fg3 })
hi("NeoTreeGitAdded", { fg = c.green })
hi("NeoTreeGitModified", { fg = c.accent2 })
hi("NeoTreeGitDeleted", { fg = c.red, bold = true })
hi("NeoTreeIndentMarker", { fg = c.bg4 })
hi("NeoTreeExpander", { fg = c.fg3 })
hi("NeoTreeCursorLine", { bg = c.bg2 })

-- ── Which-key ─────────────────────────────────────────────
hi("WhichKey", { fg = c.accent2 })
hi("WhichKeyGroup", { fg = c.muted2 })
hi("WhichKeyDesc", { fg = c.fg })
hi("WhichKeySeparator", { fg = c.fg4 })
hi("WhichKeyFloat", { bg = c.bg1 })
hi("WhichKeyBorder", { fg = c.bg4, bg = c.bg1 })

-- ── Indent blankline ──────────────────────────────────────
hi("IblIndent", { fg = c.bg4 })
hi("IblScope", { fg = c.bg4 })

-- ── Treesitter ────────────────────────────────────────────
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.muted3, italic = true })
hi("@variable.parameter", { fg = c.fg2 })
hi("@function", { fg = c.muted2, bold = true })
hi("@function.builtin", { fg = c.muted2 })
hi("@function.call", { fg = c.muted2 })
hi("@method", { fg = c.muted2 })
hi("@keyword", { fg = c.accent2, bold = true })
hi("@keyword.return", { fg = c.accent2, bold = true })
hi("@keyword.function", { fg = c.accent2 })
hi("@conditional", { fg = c.accent2 })
hi("@repeat", { fg = c.accent2 })
hi("@string", { fg = c.accent3 })
hi("@string.escape", { fg = c.accent, bold = true })
hi("@number", { fg = c.muted3 })
hi("@boolean", { fg = c.accent2, bold = true })
hi("@type", { fg = c.muted2 })
hi("@type.builtin", { fg = c.muted2, italic = true })
hi("@constructor", { fg = c.muted2 })
hi("@property", { fg = c.fg2 })
hi("@field", { fg = c.fg2 })
hi("@comment", { fg = c.fg2, italic = true })
hi("@punctuation.bracket", { fg = c.muted4 })
hi("@punctuation.delimiter", { fg = c.muted4 })
hi("@tag", { fg = c.accent2 })
hi("@tag.attribute", { fg = c.muted3 })
hi("@tag.delimiter", { fg = c.fg3 })

-- ── Lualine (tema tablosu) ────────────────────────────────
-- plugins/dagzirvesi-lualine.lua içinde ayrıca tanımlanıyor
