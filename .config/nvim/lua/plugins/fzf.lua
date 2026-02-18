return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      winopts = {
        height = 0.85,
        width = 0.90,
        preview = {
          layout = "horizontal",
        },
      },
      fzf_colors = {
        true,
        bg = "-1",
        gutter = "-1",
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
    })
    vim.keymap.set("n", "<leader>ff", fzf.files, { noremap = true, silent = true, desc = "Find files" })
    vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { noremap = true, silent = true, desc = "Find recent files" })
    vim.keymap.set("n", "<leader>gf", fzf.git_files, { noremap = true, silent = true, desc = "Find git files" })
    vim.keymap.set("n", "<leader>fb", fzf.buffers, { noremap = true, silent = true, desc = "Find buffers" })
    vim.keymap.set("n", "<leader>fh", fzf.help_tags, { noremap = true, silent = true, desc = "Find help tags" })
    vim.keymap.set("n", "<leader>fg", fzf.live_grep, { noremap = true, silent = true, desc = "Live grep" })
    vim.keymap.set("n", "<leader>fs", function()
      fzf.grep({ search = vim.fn.input("Grep for > ") })
    end, { desc = "Grep for an input string" })
  end,
}
