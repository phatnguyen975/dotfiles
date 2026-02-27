vim.keymap.set("n", "<leader>wh", ":split<CR>", { noremap = true, silent = true, desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split window vertically" })

vim.keymap.set("n", "<C-h>", "<C-w>h<CR>", { noremap = true, silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j<CR>", { noremap = true, silent = true, desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k<CR>", { noremap = true, silent = true, desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l<CR>", { noremap = true, silent = true, desc = "Move to right window" })

vim.keymap.set("n", "<C-Left>", "<C-w><", { noremap = true, silent = true, desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<C-w>>", { noremap = true, silent = true, desc = "Increase window width" })
vim.keymap.set("n", "<C-Up>", "<C-w>+", { noremap = true, silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<C-w>-", { noremap = true, silent = true, desc = "Decrease window height" })

vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move current line down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move current line up" })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected block down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected block up" })

vim.keymap.set({ "n", "o", "x" }, "<M-h>", "^", { noremap = true, silent = true, desc = "Go to beginning of line" })
vim.keymap.set({ "n", "o", "x" }, "<M-l>", "$", { noremap = true, silent = true, desc = "Go to end of line" })

vim.keymap.set("n", "==", "gg<S-v>G", { noremap = true, silent = true, desc = "Select all content of current buffer" })
vim.keymap.set("x", "<leader>p", '"_dP', { noremap = true, silent = true, desc = "Paste without replacing register" })

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = true,
  },
  float = {
    border = "rounded",
    source = true,
  },
  update_in_insert = true,
  severity_sort = true,
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })
