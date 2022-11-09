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

-- Telescope
map("n", "ff", ":Telescope find_files<CR>", opt)
map("n", "fg", ":Telescope live_grep<CR>", opt)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    -- 历史记录
    ["<Down>"] = "cycle_history_next",
    ["<Up>"] = "cycle_history_prev",
    -- 关闭窗口
    -- ["<esc>"] = actions.close,
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
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
  map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
  map("n", "<leader>gu", gs.undo_stage_hunk)
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
