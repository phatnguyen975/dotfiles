return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "gunasekar/markview-smart-tables.nvim",
    },
    config = function()
      local presets = require("markview.presets")
      require("markview").setup({
        preview = {
          icon_provider = "devicons",
          hybrid_modes = { "n" },
        },
        markdown = {
          headings = presets.headings.glow,
          tables = presets.tables.rounded,
        },
        renderers = {
          markdown_table = function(buffer, item)
            require("markview-smart-tables").render(buffer, item)
          end,
        },
      })
    end,
  },
  {
    "gunasekar/markview-smart-tables.nvim",
    lazy = true,
    opts = {
      wrap_width = 0.9,
      wrap_minwidth = 5,
    },
  },
}
