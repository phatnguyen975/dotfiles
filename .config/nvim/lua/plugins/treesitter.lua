return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"yaml",
				"gitignore",
				"markdown",
				"markdown_inline",
				"c",
				"cpp",
				"python",
				"java",
				"sql",
				"html",
				"css",
				"json",
				"javascript",
				"typescript",
			},
			sync_install = false,
			auto_install = true,
			indent = { enable = true },
			autopairs = { enable = true },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
		})
	end,
}
