vim.o.background = "dark"
vim.g.gruvbox_material_background = "soft"
vim.g.gruvbox_material_enable_bold = 0

local colorscheme = "gruvbox-material"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
  return
end
