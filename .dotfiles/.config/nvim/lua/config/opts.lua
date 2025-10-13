vim.wo.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.wrap = true
vim.o.linebreak = true
vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.scrolloff = 4
vim.o.cursorline = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.termguicolors = true
vim.o.numberwidth = 2
vim.o.swapfile = false
vim.o.smartindent = true
vim.o.showtabline = 2
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.g.have_nerd_font = true


-- Keybinds
local map = vim.keymap.set

map('n', '<Tab>', function() require("nvchad.tabufline").next() end, { noremap = true, desc = 'Moves to next tab' })
map('n', '<S-Tab>', function() require("nvchad.tabufline").prev() end, { noremap = true, desc = "Moves to previous tab" })
map('n', '<leader>x', function() require("nvchad.tabufline").close_buffer() end,
  { noremap = true, desc = "Closes current buffer." })
map('n', '<leader>th', function() require("nvchad.themes").open() end, { desc = "Brings up Theme Selector" })
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map('n', '<C-w><v>', '<C-w><s>', { desc = 'Split pane vertically' })
map('n', '<C-w><n>', '<C-w><v>', { desc = 'Split pane horizontally' })
