return {
  "lewis6991/gitsigns.nvim",
  "dinhhuy258/git.nvim",
  config = function()
    git = require("git").setup()
  end
}
