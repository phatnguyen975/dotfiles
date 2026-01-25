return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local highlight = { "CustomColor" }
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "CustomColor", { fg = "#44475A" })
    end)
    require("ibl").setup({
      indent = {
        char = "▏",
        highlight = highlight,
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        injected_languages = true,
      },
      exclude = {
        filetypes = { "dashboard", "lspinfo", "checkhealth", "help", "lazy" },
        buftypes = { "terminal", "nofile", "quickfix", "prompt" },
      },
    })
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    hooks.register(hooks.type.SKIP_LINE, hooks.builtin.skip_preproc_lines, { bufnr = 0 })
  end,
}
