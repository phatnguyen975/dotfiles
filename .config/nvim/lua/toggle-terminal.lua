local state = {
  horizontal = { buf = -1, win = -1 },
  vertical = { buf = -1, win = -1 },
  floating = { buf = -1, win = -1 },
}

local create_terminal = function(mode, opts)
  opts = opts or {}

  local width, height, row, col = nil, nil, nil, nil
  if mode == "horizontal" then
    width = vim.o.columns
    height = math.floor(vim.o.lines * 0.3)
    row = vim.o.lines - height
    col = 0
  elseif mode == "vertical" then
    width = math.floor(vim.o.columns * 0.4)
    height = vim.o.lines
    row = 0
    col = vim.o.columns - width
  elseif mode == "floating" then
    width = math.floor(vim.o.columns * 0.8)
    height = math.floor(vim.o.lines * 0.8)
    row = math.floor((vim.o.lines - height) / 2)
    col = math.floor((vim.o.columns - width) / 2)
  else
    return nil
  end

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    border = "rounded",
    style = "minimal",
    width = width,
    height = height,
    row = row,
    col = col,
  })

  return { buf = buf, win = win }
end

local toggle_terminal = function(mode)
  if not vim.api.nvim_win_is_valid(state[mode].win) then
    state[mode] = create_terminal(mode, { buf = state[mode].buf })
    if vim.bo[state[mode].buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state[mode].win)
  end
end

local close_terminal = function(mode)
  if state[mode] and vim.api.nvim_win_is_valid(state[mode].win) then
    vim.api.nvim_win_close(state[mode].win, true)
  end
  if state[mode] and vim.api.nvim_buf_is_valid(state[mode].buf) then
    vim.api.nvim_buf_delete(state[mode].buf, { force = true })
  end
  state[mode] = { buf = -1, win = -1 }
end

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

vim.keymap.set({ "n", "t" }, "<leader>th", function() toggle_terminal("horizontal") end, { noremap = true, silent = true, desc = "Toggle horizontal terminal" })
vim.keymap.set({ "n", "t" }, "<leader>tv", function() toggle_terminal("vertical") end, { noremap = true, silent = true, desc = "Toggle vertical terminal" })
vim.keymap.set({ "n", "t" }, "<leader>tf", function() toggle_terminal("floating") end, { noremap = true, silent = true, desc = "Toggle floating terminal" })

vim.keymap.set({ "n", "t" }, "<leader>eh", function() close_terminal("horizontal") end, { noremap = true, silent = true, desc = "Close horizontal terminal" })
vim.keymap.set({ "n", "t" }, "<leader>ev", function() close_terminal("vertical") end, { noremap = true, silent = true, desc = "Close vertical terminal" })
vim.keymap.set({ "n", "t" }, "<leader>ef", function() close_terminal("floating") end, { noremap = true, silent = true, desc = "Close floating terminal" })
