return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup()

      local ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "html",
        "css",
        "yaml",
        "json",
        "markdown",
        "markdown_inline",
        "latex",
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
      }

      local installed = require("nvim-treesitter.config").get_installed()
      local to_install = vim.iter(ensure_installed)
        :filter(function(lang)
          return not vim.tbl_contains(installed, lang)
        end)
        :totable()

      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = ensure_installed,
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>v",
          node_incremental = "<A-o>",
          node_decremental = "<A-i>",
          scope_incremental = "<A-O>",
        },
      },
    },
  },
}
