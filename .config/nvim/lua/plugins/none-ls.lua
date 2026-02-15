return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		null_ls.setup({
			sources = {
				formatting.stylua,
				formatting.black,
				formatting.prettier,
        formatting.google_java_format.with({
          extra_args = { "--aosp" }
        }),
			},
		})
		vim.keymap.set(
			"n",
			"<leader>fm",
			vim.lsp.buf.format,
			{ noremap = true, silent = true, desc = "Format document" }
		)
	end,
}
