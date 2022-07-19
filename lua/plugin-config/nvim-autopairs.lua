-- https://github.com/windwp/nvim-autopairs
local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
  vim.notify("没有找到 nvim-autopairs")
  return
end

local remap = vim.api.nvim_set_keymap
autopairs.setup({map_cr=false})

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    return vim.fn["coc#_select_confirm"]()
  else
    return autopairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
