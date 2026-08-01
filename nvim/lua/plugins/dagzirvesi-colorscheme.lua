-- Colorscheme yükleyici
-- Bu dosyayı ~/.config/nvim/lua/plugins/ altına koy

return {
  {
    -- Temayı lazy.nvim'e tanıt (dizinden yükler)
    name = "dagzirvesi",
    dir = vim.fn.stdpath("config"),  -- colors/ klasörü config altında olacak
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme dagzirvesi")
    end,
  },
}
