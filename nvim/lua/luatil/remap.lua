vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<M-m>", vim.cmd.make)
vim.keymap.set("n", "<M-n>", vim.cmd.cn)
vim.keymap.set("n", "<M-S-n>", vim.cmd.cp)
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set('n', "<Tab>", vim.cmd.tabn)
vim.keymap.set('n', "<C-n>", vim.cmd.tabnew)

-- Create a command to paste from windows and remove unused text
vim.keymap.set('n', "<leader>pst", ('"+p<CR>:%s/\r//g<CR>'))
