local status, ibl = pcall(require, "ibl")
if not status then
  vim.notify("没有找到 indent-blankline.nvim")
  return
end

ibl.setup({
  indent = {
    char = "¦",
  },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
  },
})
