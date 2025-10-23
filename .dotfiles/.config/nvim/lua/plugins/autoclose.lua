return {
	{
		"m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup({
				keys = {
					["("] = { escape = false, close = true, pair = "()" },
					["["] = { escape = false, close = true, pair = "[]" },
					["{"] = { escape = false, close = true, pair = "{}" },

					[">"] = { escape = true, close = false, pair = "<>" },
					[")"] = { escape = true, close = false, pair = "()" },
					["]"] = { escape = true, close = false, pair = "[]" },
					["}"] = { escape = true, close = false, pair = "{}" },

					['"'] = { escape = true, close = true, pair = '""' },
					["'"] = { escape = true, close = true, pair = "''" },
					["`"] = { escape = true, close = true, pair = "``" },
				},
				options = {
					pair_spaces = true,
					auto_indent = true,
				},
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"jsx",
			"javascriptreact",
			"typescript",
			"tsx",
			"typescriptreact",
			"xml",
			"vue",
		},
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = true,
				},
			})
		end,
	},
}
