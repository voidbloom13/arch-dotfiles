return { -- Autoformat
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = {} -- format: lang = bool { c = true, cpp = true, ... }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
				bash = { "beautysh" },
				css = { "prettier" },
				c_sharp = { "csharpier" },
				html = { "prettier", "tailwindcss" },
				java = { "google-java-format" },
				javascript = { "prettier", "tailwindcss" },
				lua_ls = { "stylua" },
				python = { "isort", "black" },
				sh = { "beautysh" },
				typescript = { "prettier", "tailwindcss" },
				tailwindcss = { "tailwindcss" },
			},
			formatters = {
				beautysh = {
					prepend_args = { "-i", "4" },
				},
				["google-java-format"] = {
					prepend_args = { "--aosp" },
				},
			},
		},
	},
	{
		"laytan/tailwind-sorter.nvim",
		dependancies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm ci && npm run build",
		config = true,
		opts = {

			on_save_pattern = { "*.html", "*.js", "*.jsx", "*.ts", "*.tsx", "*.vue" },
			node_path = "node",
			trim_spaces = true,
		},
	},
}
