local status, indent_blankline = pcall(require, "indent_blankline")
if not status then
  vim.notify("没有找到 indent_blankline")
  return
end

vim.api.nvim_set_var('indent_blankline_char', '¦')
vim.api.nvim_set_var('indent_blankline_show_first_indent_level', false)

indent_blankline.setup({
     -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = false,
})
