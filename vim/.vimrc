"" Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
so $HOME/.dotfiles/vim/plugins.vim
call vundle#end()
filetype plugin indent on

so $HOME/.dotfiles/vim/settings.vim
so $HOME/.dotfiles/vim/settings/vim-autoformat.vim
so $HOME/.dotfiles/vim/settings/vim-gutter.vim
so $HOME/.dotfiles/vim/settings/rust.vim
so $HOME/.dotfiles/vim/settings/vim-snips.vim
so $HOME/.dotfiles/vim/settings/nerd-tree.vim
so $HOME/.dotfiles/vim/settings/statusline.vim