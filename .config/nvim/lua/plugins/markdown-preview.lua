return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    require("lazy").load({ plugins = { "markdown-preview.nvim" } })
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_refresh_slow = 0
    vim.g.mkdp_open_to_the_world = 0
    vim.g.mkdp_echo_preview_url = 1

    vim.g.mkdp_browser = ""
    vim.g.mkdp_theme = "light"
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_page_title = "「${name}」"

    vim.g.mkdp_preview_options = {
      mkit = {},
      katex = {},
      uml = {},
      maid = {},
      disable_sync_scroll = 0,
      sync_scroll_type = "middle",
      hide_yaml_meta = 1,
      sequence_diagrams = {},
      flowchart_diagrams = {},
      content_editable = false,
      disable_filename = 0,
      toc = {},
    }
  end,
  config = function()
    vim.cmd([[do FileType]])
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown Preview Toggle", ft = "markdown" },
    { "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", desc = "Markdown Preview Stop", ft = "markdown" },
  },
}
