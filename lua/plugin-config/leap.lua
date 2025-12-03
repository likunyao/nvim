local status, leap = pcall(require, "leap")
if not status then
    vim.notify("没有找到 leap")
  return
end

vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
