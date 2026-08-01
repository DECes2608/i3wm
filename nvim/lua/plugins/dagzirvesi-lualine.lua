-- Lualine teması: dagzirvesi
-- Bu dosyayı ~/.config/nvim/lua/plugins/ altına koy

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local c = {
      bg      = "#1a2a2e",
      bg2     = "#243a3f",
      fg      = "#dce8e8",
      fg2     = "#8fb8b8",
      orange  = "#c4622a",
      orange2 = "#e07840",
      teal    = "#2e7f7f",
      teal2   = "#48a8a8",
    }

    local dagzirvesi = {
      normal = {
        a = { fg = c.bg,  bg = c.orange,  gui = "bold" },
        b = { fg = c.fg,  bg = c.bg2 },
        c = { fg = c.fg2, bg = "NONE" },
      },
      insert = {
        a = { fg = c.bg,  bg = c.teal2,   gui = "bold" },
        b = { fg = c.fg,  bg = c.bg2 },
        c = { fg = c.fg2, bg = "NONE" },
      },
      visual = {
        a = { fg = c.bg,  bg = c.orange2, gui = "bold" },
        b = { fg = c.fg,  bg = c.bg2 },
        c = { fg = c.fg2, bg = "NONE" },
      },
      replace = {
        a = { fg = c.bg,  bg = "#c04848",  gui = "bold" },
        b = { fg = c.fg,  bg = c.bg2 },
        c = { fg = c.fg2, bg = "NONE" },
      },
      command = {
        a = { fg = c.bg,  bg = c.teal,    gui = "bold" },
        b = { fg = c.fg,  bg = c.bg2 },
        c = { fg = c.fg2, bg = "NONE" },
      },
      inactive = {
        a = { fg = c.fg2, bg = c.bg2 },
        b = { fg = c.fg2, bg = c.bg2 },
        c = { fg = c.fg2, bg = "NONE" },
      },
    }

    opts.options = {
      theme = dagzirvesi,
      component_separators = { left = "│", right = "│" },
      section_separators   = { left = "", right = "" },
      globalstatus = true,
    }

    opts.sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    }

    return opts
  end,
}
