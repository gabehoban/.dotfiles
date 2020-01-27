" ==================================================
" Name : vimrc
" Descrption : Vim Configuration File
" Author : Gabe Hoban
" Contact : ghoban14@gmail.com
" ==================================================

set nocompatible

" --------------------------------------------------
" Plugins
" --------------------------------------------------
call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'chrisbra/Colorizer'
    Plug 'arcticicestudio/nord-vim'
    Plug 'Yggdroot/indentLine'
		Plug 'godlygeek/tabular'
		Plug 'tpope/vim-eunuch'
		Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
    Plug 'ntpeters/vim-better-whitespace'
		Plug 'junegunn/vim-easy-align'
		Plug 'jiangmiao/auto-pairs'
		Plug 'ryanoasis/vim-devicons'
    Plug 'dracula/vim'
    Plug 'ascenator/L9', {'name': 'newL9'}
		Plug 'vim-python/python-syntax'
    Plug 'ap/vim-css-color'
    Plug 'lervag/vimtex'
call plug#end()

let g:webdevicons_enable_airline_tabline = 0
let g:webdevicons_enable_airline_statusline = 0
" --------------------------------------------------
" GUI
" --------------------------------------------------
syntax enable
syntax on
filetype on
set background=dark
set t_Co=256
set hidden
set noshowmode
set visualbell
set noshowcmd
set encoding=utf8
set guifont=Menlo\ for\ Powerline\ 10
set nolazyredraw
set smartcase
set ignorecase
set number
set ruler
set mouse=a
set wrap
set hlsearch
set incsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noexpandtab
set nobackup
set noswapfile
set nowritebackup
set title
set et
set sw=4
set smarttab
set number relativenumber
set wildmode=longest,list,full
set showmatch

filetype plugin on
filetype indent on

inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>

" --------------------------------------------------
" Dracula Theme
" --------------------------------------------------
let g:dracula_colorterm=0
let g:dracula_italic=0

" --------------------------------------------------
" Airline
" --------------------------------------------------
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

" --------------------------------------------------
" Colorscheme
" --------------------------------------------------
colorscheme nord

" --------------------------------------------------
" Syntax
" --------------------------------------------------
let g:vimtex_enabled=1
let g:vimtex_complete_recursive_bib=1
"let g:vimtex_fold_manual=1
let g:vimtex_fold_enabled =1
autocmd FileType tex set makeprg=rubber\ --inplace\ --maxerr\ 1\ \ --pdf\ --short\ --quiet\ --force\ %
let g:tex_flavor="latex"
autocmd FileType tex nmap <buffer> <C-T> :!latexmk -pdf %<CR>
autocmd FileType tex nmap <buffer> T :!open -a mupdf-gl %<.pdf %<.pdf<CR><CR>
autocmd FileType tex nmap <buffer> C :!rubber --clean<CR>


let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-u>"
let g:UltiSnipsJumpBackwardTrigger="<c-i>"
let g:UltiSnipsSnippetDirectories = ["/Users/gabehoban/UltiSnips"]
let g:tex_flavor = "latex"
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_mode = 2
let g:vimtex_compiler_method = "latexmk"
