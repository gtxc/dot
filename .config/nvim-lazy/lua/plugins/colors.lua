return {
  {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      require("rose-pine").setup({
        -- variant = "auto", -- auto, main, moon, dawn
        styles = {
          transparency = true,
        },
        highlight_groups = {
          CursorLineNr = { fg = "#f6c177", bold = true },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
