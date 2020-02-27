set termguicolors
syntax enable
colorscheme dracula

let mapleader=","
let maplocalleader=";"

set omnifunc=syntaxcomplete#Complete
set completefunc=LanguageClient#complete
set number " Line numbers
set autoindent " Auto indenting
set incsearch " search as characters are entered
set hlsearch "highlight matches
set title
set tabstop=8
set softtabstop=2
set expandtab
set autoindent
set spelllang=en_us
set encoding=utf-8 nobomb

"Formatting
set formatoptions-=t "Prevent autowrapping
set formatoptions+=c "Format Comments
set formatoptions+=r "Continue comments by default

set ttyfast
set shiftwidth=4
set fileformats="unix,dos,mac"
set linebreak
set autoread
set lazyredraw
set laststatus=2
set cmdheight=2
set backspace=indent,eol,start
set smartcase
set ignorecase
set relativenumber
set lazyredraw
set backup
set undofile
set undodir=~/.vimtmp/undo//
set backupdir=~/.vimtmp/backup//
set directory=~/.vimtmp/swap//
set encoding=utf-8
set nocompatible
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre *.sh :ShellCheck!