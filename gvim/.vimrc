" ==================== 0. 基础防御 ====================
set nocompatible                " 必须放在第一位
set hidden                      " 允许切 buffer 时不存盘
set nobackup noswapfile nowritebackup   " 不生成备份文件

" ==================== 1. 外观与交互 ====================
set background=dark
colorscheme molokai
let g:molokai_original = 1

set laststatus=2                " 总是显示状态栏
set ruler                       " 右下角显示行列
set number                      " 行号
set cursorline cursorcolumn     " 高亮当前行列
set nowrap                      " 不自动折行
set title                       " 终端标题栏显示文件名

" 窗口大小（GUI/终端自适应）
set lines=30 columns=100
set guifont=DejaVu\ Sans\ Mono\ 14
" ==================== 2. 搜索与补全 ====================
set incsearch ignorecase smartcase  " 实时搜索 + 智能大小写
set hlsearch                        " 搜索结果高亮
nnoremap <silent><Esc> :noh<CR>     " 一键取消高亮
set wildmenu                        " 命令行补全
set history=200

" ==================== 3. 按键映射（leader = ;） ====================
let mapleader = ';'

" 窗口 / Buffer 导航
nnoremap <leader>q  :q<CR>
nnoremap <leader>w  :w<CR>
nnoremap <leader>Q  :qa!<CR>
nnoremap <leader>WQ :wa<CR>:q<CR>
nnoremap <leader>1  :b 1<CR>
nnoremap <leader>2  :b 2<CR>
nnoremap <leader>3  :b 3<CR>
nnoremap <leader>4  :b 4<CR>
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>

" 系统剪贴板
vnoremap <leader>y "*y
nnoremap <leader>p "*p

" 插入模式快速退出
inoremap jk <Esc>

" ==================== 4. 制表与缩进（按文件类型自动调整） ====================
set expandtab autoindent
set tabstop=4 shiftwidth=4 softtabstop=4

autocmd FileType java,javascript,html,css,xml
  \ set ts=2 sw=2 sts=2
autocmd FileType python,shell,bash
  \ set ts=4 sw=4 sts=4
autocmd FileType tex
  \ set ts=4 sw=2 sts=2 lbr
autocmd FileType verilog,systemverilog,verilog_systemverilog
  \ set ts=4 sw=4 sts=-1

" ==================== 5. 插件（Vundle 管理） ====================
" 如需启用，取消下面两段注释并执行 :PluginInstall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
 "Plugin 'VundleVim/Vundle.vim'
 "Plugin 'tomasr/molokai'
 "Plugin 'vim-airline/vim-airline'
 "Plugin 'vim-airline/vim-airline-themes'
 "Plugin 'scrooloose/nerdtree'
 "Plugin 'scrooloose/nerdcommenter'
 "Plugin 'majutsushi/tagbar'
 "Plugin 'vhda/verilog_systemverilog.vim'
 "Plugin 'ervandew/supertab'
 "Plugin 'Yggdroot/indentLine'
 Plugin 'git@github.com:VundleVim/Vundle.vim.git'
 Plugin 'git@github.com:tomasr/molokai.git'
 Plugin 'git@github.com:vim-airline/vim-airline.git'
 Plugin 'git@github.com:vim-airline/vim-airline-themes.git'
 Plugin 'git@github.com:scrooloose/nerdtree.git'
 Plugin 'git@github.com:scrooloose/nerdcommenter.git'
 Plugin 'git@github.com:majutsushi/tagbar.git'
 Plugin 'git@github.com:vhda/verilog_systemverilog.vim.git'
 Plugin 'git@github.com:ervandew/supertab.git'
 Plugin 'git@github.com:Yggdroot/indentLine.git'
call vundle#end()
filetype plugin indent on
"以后想增删插件，只要把中间的 Plugin 'xxx' 行改一行即可，然后
":PluginInstall   – 安装
":PluginUpdate    – 更新
":PluginClean     – 把列表里删掉的插件真正卸掉
" NERDTree 快捷键（如已安装）
nnoremap <leader>f :NERDTreeToggle<CR>
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') &&
  \ b:NERDTree.isTabTree() == 'primary') | q | endif

" ==================== 6. 其他便利设置 ====================
set encoding=utf-8
set fileencoding=utf-8
set whichwrap+=<,>,h,l,[,]   " 左右键在行首行尾换行
set showtabline=1
set listchars=tab:>~,trail:. " 可视化制表符与行尾空格
set foldmethod=marker        " 用 {{{ / }}} 手动折叠
set pastetoggle=<F5>         " F5 切换粘贴模式
set grepprg=grep\ -nH\ $*    " latex-suite 需要
