export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
)

source "$ZSH/oh-my-zsh.sh"

export EDITOR=nvim
export VISUAL=nvim

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt AUTO_CD

eval "$(zoxide init zsh)"

alias ll='ls -lah'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias v='nvim'
alias t='tmux'
