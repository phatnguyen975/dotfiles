return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local highlight = { "CustomColor" }
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "CustomColor", { fg = "#44475A" })
    end)
    require("ibl").setup({
      indent = {
        char = "▏",
        tab_char = "▏",
        highlight = highlight,
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        injected_languages = true,
      },
      exclude = {
        filetypes = { "dashboard", "lspinfo", "checkhealth", "help", "lazy", "mason" },
        buftypes = { "terminal", "nofile", "quickfix", "prompt" },
      },
    })
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    hooks.register(hooks.type.SKIP_LINE, hooks.builtin.skip_preproc_lines, { bufnr = 0 })
    vim.keymap.set("n", "<leader>ui", ":IBLToggle<CR>", { desc = "Toggle indent lines" })
  end,
}
