return {
  {
    "NvChad/ui",
    config = function()
      require "nvchad"
    end
  },
  {
    "NvChad/base46",
    config = function()
      require("base46").load_all_highlights()
    end
  },
  "nvchad/volt"
}
