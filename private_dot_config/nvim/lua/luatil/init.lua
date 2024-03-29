require("luatil.remap")
-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.undofile = true
--
-- vim.opt.background='light'
vim.opt.background='dark'

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
-- vim.opt.colorcolumn = "80"
vim.opt.makeprg = "./build.sh"
vim.opt.ignorecase = true

local function ends_width(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

-- Print current file name
-- print(vim.fn.expand("%:t"))



-- Define a function to set project specific key mappings
local function set_project_key_mappings()
    local current_dir = vim.fn.getcwd()
    local current_file = vim.fn.expand("%:t")

    -- Check if the current directory name ends with "sydle"
    if string.match(current_dir, "sydle$") then
        -- Set the key mapping for <leader>r in normal mode to run npm run tests
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', ':!npm run test<CR>', { noremap = true, silent = true })
        vim.opt.makeprg = "npm run update-upload"
    elseif string.match(current_dir, "tcc2023$") then
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', ':!make<CR>', { noremap = true, silent = true })
        vim.opt.makeprg = "make"

        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>t', ':vimgrep \"% TODO\" conteudo/* <CR>', { noremap = true, silent = true })
    elseif string.match(current_dir, "internal$") then
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>f', ':!ruff format %<CR>', { noremap = true, silent = true })
    elseif ends_width(current_file, ".py") then
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>f', ':!ruff format %<CR>', { noremap = true, silent = true })
        vim.opt.makeprg = "mypy %"
    else
        -- Remove the mapping when not in the sydle project directory
        -- This is assuming that <leader>r is not used for other mappings in normal mode globally
        -- vim.api.nvim_buf_del_keymap(0, 'n', '<leader>r')
    end
end

-- Set up an autocommand that runs the function on BufEnter
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*', -- Every file
    callback = set_project_key_mappings
})
