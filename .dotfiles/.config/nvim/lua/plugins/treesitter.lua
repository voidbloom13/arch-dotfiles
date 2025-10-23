return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c_sharp",
				"css",
				"html",
				"java",
				"javascript",
				"lua",
				"python",
				"typescript",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			-- autotag = { enable = true },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
