return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        numbers = "none",
        indicator = {
          style = "underline",
        },
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_update_on_event = true,
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        color_icons = true,
        get_element_icon = function(element)
          local icon, hl =
            require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
        },
        separator_style = { "│", "│" },
        enforce_regular_tabs = false,
        hover = {
          enabled = true,
          delay = 100,
          reveal = { "close" },
        },
        sort_by = "insert_after_current",
      },
    })
    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
    vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
    vim.keymap.set("n", "<leader><Left>", ":BufferLineMovePrev<CR>", { noremap = true, silent = true, desc = "Move buffer left" })
    vim.keymap.set("n", "<leader><Right>", ":BufferLineMoveNext<CR>", { noremap = true, silent = true, desc = "Move buffer right" })
    vim.keymap.set("n", "<leader>bp", ":BufferLinePick<CR>", { noremap = true, silent = true, desc = "Pick buffer" })
    vim.keymap.set("n", "<leader>bc", ":BufferLinePickClose<CR>", { noremap = true, silent = true, desc = "Close picked buffer" })
    vim.keymap.set("n", "<leader>bo", ":BufferLineCloseOthers<CR>", { noremap = true, silent = true, desc = "Close other buffers" })
    vim.keymap.set("n", "<leader>bd", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local listed_buffers = vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
      end, vim.api.nvim_list_bufs())
    
      if #listed_buffers <= 1 then
        vim.cmd("enew")
        vim.cmd("bdelete " .. bufnr)
      else
        vim.cmd("bp")
        vim.cmd("bdelete " .. bufnr)
      end
    end, { noremap = true, silent = true, desc = "Close current buffer" })
  end,
}
