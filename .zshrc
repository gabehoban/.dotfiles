autoload -U compinit && compinit
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"
export TERM="xterm-256color"
export EDITOR='nano'
export GPG_TTY="$(tty)"
export HOMEBREW_GITHUB_API_TOKEN=7151aba422c97deb5a7063e8ed354b978cc2cc4e
export HOMEBREW_TEMP=/usr/local/temp
export PATH="/usr/local/sbin:$PATH"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export ZSH="/Users/gabehoban/.oh-my-zsh"
ZSH_THEME=""
gpgconf --launch gpg-agent
plugins=(
    extract
    history-substring-search
    virtualenv
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ls="ls"


transfer() { 
    if [ $# -eq 0 ]; 
        then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; 
    fi
    tmpfile=$( mktemp -t transferXXX ); 
    if tty -s; 
        then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); 
            curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; 
        else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; 
    fi; 
    cat $tmpfile; 
    rm -f $tmpfile; 
}

source /Users/gabehoban/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

