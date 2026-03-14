# Go
export GOPATH=$HOME/go
export PATH=$PATH:$(go env GOPATH)/bin

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Editor
export EDITOR="code --wait"

# --- Aliases ---

# Navigation
alias ..="cd .."
alias ...="cd ../.."

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"

# List files
alias ll="ls -lAh"

# --- Prompt ---
# Shows: current directory + git branch
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
PROMPT='%B%~%b${vcs_info_msg_0_} $ '
