-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable showing mode (like --INSERT--)
vim.opt.showmode = false
-- disable status bar
vim.opt.laststatus = 0 -- 0 for now

-- number line
vim.opt.relativenumber = true
-- number line space for accomodating lsp and various
vim.opt.signcolumn = 'yes'
vim.opt.numberwidth = 3

-- mouse support
vim.opt.mouse:append{a}

-- identation
vim.opt.tabstop = tab 
vim.opt.softtabstop = tab
vim.opt.shiftwidth = tab
vim.opt.expandtab = true
vim.opt.autoindent = true

-- disable continuing commands by autoinserting in the next line
vim.api.nvim_exec('autocmd FileType * setlocal formatoptions-=cro', {})

-- disable line wrapping
vim.opt.wrap = false

-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- disable swap file
vim.opt.swapfile = false
-- unlimited undos
vim.opt.undofile = true

-- set the clipboard to be acessible outside of neovim
vim.opt.clipboard = "unnamedplus"

-- change directory to the file in the current window (for :!ls)
vim.opt.autochdir = true
