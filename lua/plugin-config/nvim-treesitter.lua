local status, treesitter = pcall(require, "nvim-treesitter")
if not status then
  vim.notify("没有找到 nvim-treesitter")
  return
end

local filetypes = {
  "sh",
  "bash",
  "c",
  "cpp",
  "make",
  "cmake",
  "python",
  "go",
  "lua",
  "sql",
  "yaml",
  "java",
  "markdown",
  "rust"
}

local installing = {}

treesitter.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local group = vim.api.nvim_create_augroup("myTreesitter", {
  clear = true,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = filetypes,
  callback = function(args)
    local filetype = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(filetype)
    if lang == nil then
      return
    end

    if not vim.treesitter.language.add(lang) then
      local available = treesitter.get_available()
      if not installing[lang] and vim.tbl_contains(available, lang) then
        installing[lang] = true
        treesitter.install(lang)
      end
      return
    end

    vim.treesitter.start(args.buf, lang)
  end,
})
