return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "lua",
        "vim",
        "query",
        "html",
        "css",
        "yaml",
        "json",
        "markdown",
        "markdown_inline",
        "sql",
        "c",
        "cpp",
        "python",
        "java",
        "javascript",
        "typescript",
        "go",
        "gomod",
        "gowork",
        "gosum",
      },
      sync_install = false,
      auto_install = true,
      indent = { enable = true },
      autopairs = { enable = true },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })
  end,
}
