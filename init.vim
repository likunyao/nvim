" Create by likunyao(nwpulky@gmail.com)

set nocompatible
" 插件开始位置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" 欢迎页面
Plug 'mhinz/vim-startify'

" 树形目录
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" 括号和引号自动补全
Plug 'jiangmiao/auto-pairs'

" 缩进指示线
Plug 'Yggdroot/indentLine'

" airline
Plug 'vim-airline/vim-airline'

" 关键字高亮
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" 代码格式化插件
Plug 'rhysd/vim-clang-format'

" 主题插件
Plug 'sainnhe/gruvbox-material'

" 补全插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" git辅助插件
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" 注释插件
Plug 'preservim/nerdcommenter'

" 文档插件
Plug 'vim-scripts/DoxygenToolkit.vim'

" 时间统计
Plug 'wakatime/vim-wakatime'

call plug#end()
filetype plugin indent on
" 插件结束位置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" 按键映射
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 定义<leader>键
let mapleader = ","
" 插入模式下jk映射为ESC
inoremap jk <esc>
" 安装、更新、删除插件
nnoremap <leader><leader>i :PlugInstall<cr>
nnoremap <leader><leader>u :PlugUpdate<cr>
nnoremap <leader><leader>c :PlugClean<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" 基本设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 主题配置
set background=dark 
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_enable_bold = 0
colorscheme gruvbox-material
let g:airline_powerline_fonts=1
let g:airline_theme = 'gruvbox_material'
"let g:airline#extensions#tabline#enabled=1
" 显示行号
set number
" 交换文件落盘时间
set updatetime=100
" 自动重载配置文件
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
" 语法高亮显示
syntax enable
syntax on
" 一个tab占4个空格
set tabstop=4
" 将tab转换为空格
set expandtab
" 自动缩进4个空格
set shiftwidth=4
" 显示括号配对情况
set sm
" 实时查找
set incsearch
" 查找匹配高亮
set hls
" F12取消查找高亮
nmap <F12> :nohlsearch<CR>
" 修改一个文件后，自动进行备份，备份的文件名为原文件名加"~"后缀
set backup
" 恢复文件关闭前光标的位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" 更改到当前文件所在目录
autocmd BufEnter * lcd %:p:h
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" DoxygenToolkit配置
let g:DoxygenToolkit_authorName = "likunyao(likunyao@bigo.sg)"
let g:DoxygenToolkit_licenseTag = "Copyright (c) 2022-present BIGO TECHNOLOGY PTE. LTD.\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "License: ALL RIGHTS RESERVED.\<enter>"
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . "Author: likunyao(likunyao@bigo.sg)"
nnoremap <leader><leader>d :Dox<cr>


" treesitter配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"bash", "c", "cpp", "make", "cmake", "python", "java"},
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


" coc配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc插件
let g:coc_global_extensions = []
let g:coc_global_extensions += ['coc-clangd']
let g:coc_global_extensions += ['coc-pyright']
let g:coc_global_extensions += ['coc-cmake']
let g:coc_global_extensions += ['coc-json']
let g:coc_global_extensions += ['coc-sh']
let g:coc_global_extensions += ['coc-prettier']
" Tab, Shift+Tab切换自动补全选项
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" 回车确认补全选项
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" 跳转函数定义
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" 跳转错误
nmap <silent> eN <Plug>(coc-diagnostic-prev)
nmap <silent> en <Plug>(coc-diagnostic-next)
" AutoFix
nmap <leader>qf <Plug>(coc-fix-current)
" 查看文档
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" 重命名
nmap <leader>rn <Plug>(coc-rename)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 


" vim-gitgutter配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 跳转Hunk
nmap <leader>hn <Plug>(GitGutterNextHunk)
nmap <leader>hN <Plug>(GitGutterPrevHunk)
" 折叠没有修改的代码
nmap <leader>gf :GitGutterFold<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" vim-clang-format配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 保存自动格式化
autocmd FileType c,cpp,objc,proto ClangFormatAutoEnable
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" NerdTree配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
require'nvim-tree'.setup {
    filters = {
        dotfiles = false,
        custom = {"*.pyc", "*.swp"}
        },
    }
EOF
" 快捷键F2打开
nnoremap <F2> :NvimTreeToggle<CR>
" 刷新文件列表
nnoremap <leader><leader>r :NvimTreeRefresh<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" 缩进指示线配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缩进指示线样式
let g:indentLine_char='¦'
" 缩进指示线显示打开
let g:indentLine_enabled = 1
" 当打开json文件时关闭缩进指示功能, 否则看不到key和value的引号
autocmd Filetype json let g:indentLine_enabled = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" 编码设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
