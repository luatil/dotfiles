local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-g>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-f>', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<C-F>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
-- vim.keymap.set('n', '/', builtin.current_buffer_fuzzy_find, { noremap = false })
