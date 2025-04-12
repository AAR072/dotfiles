-- <leader>pv -> Open built in file explorer
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", opts)
-- <leader>lt -> Run :Leet test
vim.keymap.set("n", "<leader>lt", function() vim.cmd("Leet test") end, opts)

-- <leader>ls -> Run :Leet submit
vim.keymap.set("n", "<leader>ls", function() vim.cmd("Leet submit") end, opts)

vim.keymap.set('n', '<C-s>', '<CMD>w<CR>', { noremap = true, silent = true, desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc><CMD>w<CR>a', { noremap = true, silent = true, desc = 'Save file (insert mode)' })

-- Make line breaks respect word wrap
vim.keymap.set('n', 'j', 'gj', { noremap = true, silent = true, desc = 'Down (respect line wrap)' })
vim.keymap.set('n', 'k', 'gk', { noremap = true, silent = true, desc = 'Up (respect line wrap)' })
vim.keymap.set('v', 'j', 'gj', { noremap = true, silent = true, desc = 'Down (visual, respect wrap)' })
vim.keymap.set('v', 'k', 'gk', { noremap = true, silent = true, desc = 'Up (visual, respect wrap)' })

-- Oil navigation keybind
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to below split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to above split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })
