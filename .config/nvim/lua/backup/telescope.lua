return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true, desc = "Find files" })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { noremap = true, silent = true, desc = "Find recent files" })
      vim.keymap.set("n", "<leader>fg", builtin.git_files, { noremap = true, silent = true, desc = "Find git files" })
      vim.keymap.set("n", "<leader>fs", builtin.live_grep, { noremap = true, silent = true, desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true, desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true, silent = true, desc = "Find help tags" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          layout_config = {
            horizontal = {
              preview_width = 0.6,
              width = 0.85,
            },
            vertical = {
              preview_height = 0.6,
              height = 0.85,
            },
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["q"] = actions.close,
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })
      telescope.load_extension("ui-select")
    end,
  },
}
