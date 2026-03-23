vim.o.background = "dark"
vim.g.gruvbox_material_background = "soft"
vim.g.gruvbox_material_enable_bold = 0
vim.g.gruvbox_material_transparent_background = 1

local colorscheme = "gruvbox-material"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
  return
end

local groups = {
  "Normal",
  "NormalNC",
  "EndOfBuffer",
  "SignColumn",
  "FoldColumn",
  "LineNr",
  "CursorLineNr",
  "NonText",
  "VertSplit",
  "StatusLine",
  "StatusLineNC",
  "NormalFloat",
  "FloatBorder",
  "Pmenu",
  "PmenuSel",
  "NvimTreeNormal",
  "NvimTreeNormalNC",
  "NvimTreeEndOfBuffer",
}

for _, group in ipairs(groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none" })
end

-- 浮窗/补全菜单轻微透明
vim.opt.winblend = 10
vim.opt.pumblend = 10

-- CursorLine 优化
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", {
  fg = "#d8a657",
  bold = true
})

