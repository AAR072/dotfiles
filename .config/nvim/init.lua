require("config.lazy")
require("config.remap")

-- Hide the banner in the explorer
vim.g.netrw_banner = 0

-- Make Ctrl + S save --
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

-- Make line breaks respect word wrap
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'k', 'gk', { noremap = true, silent = true })

-- Make all yanks and pastes go into global clipboard
vim.opt.clipboard = "unnamedplus"
-- Enable relative line numbers
vim.opt.relativenumber = true
-- Enable filetype detection, plugin and indent support
vim.cmd('filetype plugin indent on')

-- Set expandtab to use spaces instead of tabs
vim.opt.expandtab = true

-- Show existing tab with 2 spaces width
vim.opt.tabstop = 2

-- Set softtabstop to 2 spaces
vim.opt.softtabstop = 2

-- When indenting with '>', use 2 spaces width
vim.opt.shiftwidth = 2

-- Automatically strip whitespace when saving --
vim.g.better_whitespace_ctermcolor = '9' -- Light red, good balance of visibility
vim.g.strip_whitespace_confirm = 0
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1
