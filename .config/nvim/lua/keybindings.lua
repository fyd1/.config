-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

-- C-k when putting up parens to pick where they are going
map("n", "<C-f>", ":FZF<CR>", options)
map("n", "<C-p>", ":NvimTreeRefresh<CR>:NvimTreeToggle<CR>", options)
map("n", "<leader>+", ":NvimTreeResize +5<CR>", options)
map("n", "<leader>-", ":NvimTreeResize -5<CR>", options)
map("n", "<leader>c",  ":lua vim.diagnostic.open_float() <CR>", options)
map("n", "<esc>", ":noh<CR>", options)







