export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

plugins=(git direnv)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# aliases
alias c="open $1 -a \"Cursor\""
alias v="open $1 -a \"Visual Studio Code\""
alias zed="open $1 -a \"Zed\""
alias lg="lazygit"
alias ld="lazydocker"
alias yz="yazi"
alias diff="delta $1 --side-by-side"
alias vim="nvim"

# DNS settings for mac
alias dns-reset="sudo networksetup -setdnsservers Wi-Fi empty"
alias dns-home="sudo networksetup -setdnsservers Wi-Fi 192.168.50.1"
alias dns-google="sudo networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4"
alias dns-cf="sudo networksetup -setdnsservers Wi-Fi 1.1.1.1"
alias dns-paks="sudo networksetup -setdnsservers Wi-Fi 192.168.88.60"

#source /Users/bencetoth/.config/op/plugins.sh

eval "$(zoxide init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
