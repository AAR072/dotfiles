-- <leader>pv -> Open built in file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- <leader>lt -> Run :Leet test
vim.keymap.set("n", "<leader>lt", function() vim.cmd("Leet test") end, opts)

-- <leader>ls -> Run :Leet submit
vim.keymap.set("n", "<leader>ls", function() vim.cmd("Leet submit") end, opts)

