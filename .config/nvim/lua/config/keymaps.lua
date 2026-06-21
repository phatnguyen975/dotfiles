vim.keymap.set("n", "<leader>wv", function()
  vim.ui.input({
    prompt = "Vertical split file: ",
    completion = "file",
  }, function(file)
    if file and file ~= "" then
      vim.cmd("vsplit " .. vim.fn.fnameescape(file))
    end
  end)
end, { noremap = true, silent = true, desc = "Split window vertically" })

vim.keymap.set("n", "<leader>wh", function()
  vim.ui.input({
    prompt = "Horizontal split file: ",
    completion = "file",
  }, function(file)
    if file and file ~= "" then
      vim.cmd("split " .. vim.fn.fnameescape(file))
    end
  end)
end, { noremap = true, silent = true, desc = "Split window horizontally" })

vim.keymap.set("n", "<C-Left>", "<C-w><", { noremap = true, silent = true, desc = "Decrease the window width" })
vim.keymap.set("n", "<C-Right>", "<C-w>>", { noremap = true, silent = true, desc = "Increase the window width" })
vim.keymap.set("n", "<C-Up>", "<C-w>+", { noremap = true, silent = true, desc = "Increase the window height" })
vim.keymap.set("n", "<C-Down>", "<C-w>-", { noremap = true, silent = true, desc = "Decrease the window height" })

vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move the current line down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move the current line up" })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move the selected block down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move the selected block up" })

vim.keymap.set({ "n", "o", "x" }, "<M-h>", "^", { noremap = true, silent = true, desc = "Go to the beginning of line" })
vim.keymap.set({ "n", "o", "x" }, "<M-l>", "$", { noremap = true, silent = true, desc = "Go to the end of line" })

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })
vim.keymap.set("n", "<C-a>", "gg<S-v>G<CR>", { noremap = true, silent = true, desc = "Select all" })
vim.keymap.set({ "n", "i" }, "<C-s>", "<Cmd>w<CR>", { noremap = true, silent = true, desc = "Save file" })

vim.diagnostic.config({
  virtual_text = {
    prefix = "■",
    source = true,
  },
  float = {
    border = "rounded",
    source = true,
  },
  update_in_insert = true,
  severity_sort = true,
})

local diagnostic_float_win = nil
vim.keymap.set("n", "<leader>d", function()
  if diagnostic_float_win and vim.api.nvim_win_is_valid(diagnostic_float_win) then
    vim.api.nvim_win_close(diagnostic_float_win, true)
    diagnostic_float_win = nil
    return
  end

  local _, winid = vim.diagnostic.open_float(nil, {
    scope = "line",
    focusable = false,
  })

  diagnostic_float_win = winid

  vim.api.nvim_create_autocmd("WinClosed", {
    once = true,
    callback = function(args)
      if tonumber(args.match) == winid then
        diagnostic_float_win = nil
      end
    end,
  })
end, { desc = "Toggle line diagnostics" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })
