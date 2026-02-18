return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      use_default_mappings = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        indent = { padding = 0, indent_size = 2 },
        icon = {
          folder_closed = "󰉋",
          folder_open = "󰝰",
          folder_empty = "󰉖",
          folder_empty_open = "󰷏",
          default = "󰡯",
        },
        modified = { symbol = "●" },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
        },
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "",
            renamed = "",
            ignored = "",
            untracked = "★",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
          },
        },
      },
      window = {
        position = "left",
        width = 30,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = { ".git", "__pycache__" },
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      buffers = {
        follow_current_file = { enabled = true },
      },
    })
    vim.keymap.set(
      "n",
      "<leader>e",
      ":Neotree toggle<CR>",
      { noremap = true, silent = true, desc = "Toggle Neo-tree" }
    )
    vim.keymap.set(
      "n",
      "<leader>o",
      ":Neotree focus<CR>",
      { noremap = true, silent = true, desc = "Focus Neo-tree" }
    )
  end,
}
