local coc_pulgin_list = {"coc-prettier",
                        "coc-sh",
                        "coc-pyright",
                        "coc-json",
                        "coc-go",
                        "coc-cmake",
                        "coc-clangd"}
vim.api.nvim_set_var('coc_global_extensions', coc_pulgin_list)

local expr_opts = { noremap = true, silent = true, expr = true }

vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", {silent = true})
vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", {silent = true})
vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", {silent = true})

vim.api.nvim_set_keymap("n", "en", "<Plug>(coc-diagnostic-next)", {silent = true})
vim.api.nvim_set_keymap("n", "eN", "<Plug>(coc-diagnostic-prev)", {silent = true})

vim.api.nvim_set_keymap("n", "<leader>h", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", {})
vim.api.nvim_set_keymap("n", "<leader>qf", "<Plug>(coc-fix-current)", {})

vim.api.nvim_set_keymap("i", "<C-Space>", [[coc#refresh()]], expr_opts)

vim.api.nvim_set_keymap("i",
    "<TAB>",
    [[coc#pum#visible() ? coc#pum#next(1) : coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetNext', [])<cr>" : "<TAB>"]],
    expr_opts)

vim.api.nvim_set_keymap("i",
    "<S-TAB>",
    [[coc#pum#visible() ? coc#pum#prev(1) : coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetPrev', [])<cr>" : "<S-TAB>"]],
    expr_opts)

vim.api.nvim_set_keymap("i",
    "<CR>",
    [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
    expr_opts)
