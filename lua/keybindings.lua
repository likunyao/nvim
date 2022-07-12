-- leader键
vim.g.mapleader = ","

local opt = {
  noremap = true,
  silent = true,
}

-- 本地变量
local map = vim.api.nvim_set_keymap

map("i", "jk", "<esc>", opt)
map("n", "<leader><leader>i", ":PackerInstall<cr>", opt)
map("n", "<leader><leader>s", ":PackerSync<cr>", opt)
map("n", "<f2>", ":NvimTreeToggle<cr>", opt)
map("n", "<f12>", ":nohlsearch<cr>", opt)
