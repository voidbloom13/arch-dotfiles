local M = {
	base46 = {
		theme = "horizon",
		hl_override = {
			LineNrAbove = { fg = "#008fff" },
			LineNr = { italic = true, fg = "#8f49ff" },
			LineNrBelow = { fg = "#008fff" },
			Comment = { italic = true, fg = "#90cfcf" },
			String = { italic = true, bold = true },
			Visual = { bg = "#008fff", fg = "#ffffff" },
		},
		transparency = true,
	},
	ui = {
		tabufline = {
			enabled = true,
			lazyload = true,
			order = { "treeOffset", "buffers", "tabs", "btns" },
			modules = nil,
			bufwidth = 21,
		},
		statusline = {
			enabled = true,
			theme = "default",
			separator_style = "arrow",
			order = nil,
			modules = nil,
		},
	},
	nvdash = {
		load_on_startup = true,

		header = {
			"                            ",
			"     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
			"   ▄▀███▄     ▄██ █████▀    ",
			"   ██▄▀███▄   ███           ",
			"   ███  ▀███▄ ███           ",
			"   ███    ▀██ ███           ",
			"   ███      ▀ ███           ",
			"   ▀██ █████▄▀█▀▄██████▄    ",
			"     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
			"                            ",
			"     Powered By  eovim    ",
			"                            ",
		},

		buttons = {
			{ txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
			-- more... check nvconfig.lua file for full list of buttons
		},
	},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", M, status and chadrc or {})
