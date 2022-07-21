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
map("n", "<f12>", ":nohlsearch<cr>", opt)

-- 插件快捷键
local pluginKeys = {}

-- nvim-tree
map("n", "<f2>", ":NvimTreeToggle<cr>", opt)
-- 列表快捷键
pluginKeys.nvimTreeList = {
    { key = "R", action = "refresh" },
}

-- neogen
map("n", "<leader><leader>d", ":Neogen<cr>", opt)
map("n", "<leader><leader>f", ":Neogen file<cr>", opt)

-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "<leader>gn", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  map("n", "<leader>gN", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
  map("n", "<leader>gu", gs.undo_stage_hunk)
  map("n", "<leader>gr", gs.reset_buffer)
  map("n", "<leader>gp", gs.preview_hunk)
  map("n", "<leader>gb", function()
    gs.blame_line({ full = true })
  end)
  map("n", "<leader>gd", gs.diffthis)
  map("n", "<leader>gD", function()
    gs.diffthis("~")
  end)
  -- toggle
  map("n", "<leader>gtd", gs.toggle_deleted)
  map("n", "<leader>gtb", gs.toggle_current_line_blame)
  -- Text object
  map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
end

return pluginKeys
