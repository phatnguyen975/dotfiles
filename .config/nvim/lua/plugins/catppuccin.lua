return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato",
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,
      no_italic = false,
      no_bold = false,
      no_underline = false,
      default_integrations = true,
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
