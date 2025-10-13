return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-tree/nvim-web-devicons",
      config = function()
        require "nvim-web-devicons".setup {
          color_icons = true,
          default = true,
          variant = "dark",
        }
      end
    },
    "MunifTanjim/nui.nvim",
  },
  opts = {
    enable_git_status = true,
    git_status_async = true,
    default_component_configs = {
      git_status = {
        symbols = {
          added = "",
          modified = "",
          deleted = "󰧧",
          renamed = "",
          untracked = "󱘺",
          ignored = "",
          unstaged = "󰮆",
          staged = "󰪩",
          conflict = ""
        }
      }
    },
    filesystem = {
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
      },
    },
    close_if_last_window = true,
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          vim.cmd("Neotree close")
        end,
      },
    },
  },
  vim.keymap.set("n", "<leader>/", "<cmd>Neotree toggle<CR>"),
}
