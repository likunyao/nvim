local status, neogen = pcall(require, "neogen")
if not status then
  vim.notify("没有找到 neogen")
  return
end

neogen.setup({

})
