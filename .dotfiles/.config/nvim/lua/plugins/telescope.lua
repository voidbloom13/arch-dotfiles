return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependancies = {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        pickers = {
          find_files = {
            hidden = true
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end,
  },
  vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" }),
  vim.keymap.set("n", "<leader>fw", "<cmd>Telescope current_buffer_fuzzy_find<CR>",
    { desc = "Telescope fuzzy find current buffer" }),
  vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" }),
  vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope buffers" }),
}
