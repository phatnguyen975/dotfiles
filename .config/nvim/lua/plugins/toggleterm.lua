return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<leader>tf", desc = "Terminal: toggle float" },
    { "<leader>th", desc = "Terminal: toggle horizontal" },
    { "<leader>tv", desc = "Terminal: toggle vertical" },
    { "<leader>tF", desc = "Terminal: kill float" },
    { "<leader>tH", desc = "Terminal: kill horizontal" },
    { "<leader>tV", desc = "Terminal: kill vertical" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.4)
      end
    end,
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
      border = "rounded",
      winblend = 0,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local Terminal = require("toggleterm.terminal").Terminal

    local float_term = Terminal:new({ direction = "float", count = 1 })
    local horizontal_term = Terminal:new({ direction = "horizontal", count = 2 })
    local vertical_term = Terminal:new({ direction = "vertical", count = 3 })

    local function kill_terminal(term)
      if term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) then
        vim.api.nvim_buf_delete(term.bufnr, { force = true })
      end
    end

    vim.keymap.set("n", "<leader>tf", function()
      float_term:toggle()
    end, { desc = "Terminal: toggle float" })

    vim.keymap.set("n", "<leader>th", function()
      horizontal_term:toggle()
    end, { desc = "Terminal: toggle horizontal" })

    vim.keymap.set("n", "<leader>tv", function()
      vertical_term:toggle()
    end, { desc = "Terminal: toggle vertical" })

    vim.keymap.set("n", "<leader>tF", function()
      kill_terminal(float_term)
    end, { desc = "Terminal: kill float" })

    vim.keymap.set("n", "<leader>tH", function()
      kill_terminal(horizontal_term)
    end, { desc = "Terminal: kill horizontal" })

    vim.keymap.set("n", "<leader>tV", function()
      kill_terminal(vertical_term)
    end, { desc = "Terminal: kill vertical" })

    local function set_terminal_keymaps()
      local o = { buffer = 0 }
      vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], o)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], o)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], o)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], o)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], o)
    end

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*toggleterm#*",
      callback = set_terminal_keymaps,
    })
  end,
}
