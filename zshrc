# Go
export GOPATH=$HOME/go
export PATH=$PATH:$(go env GOPATH)/bin

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Editor
export EDITOR="code --wait"

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS    # don't record duplicate commands
setopt HIST_IGNORE_SPACE   # don't record commands starting with a space
setopt SHARE_HISTORY       # share history across terminal tabs

# --- Aliases ---

# Navigation
alias ..="cd .."
alias ...="cd ../.."

# Git
alias gs="git status"
alias gss="git status --short"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"

# Go
alias gr="go run ."
alias gt="go test ./..."
alias gtv="go test -v ./..."
alias gob="go build ./..."
alias gmod="go mod tidy"

# List files
alias ll="ls -lAh"

# --- Functions ---

# Jump to a project under ~/go/src/qu1queee
# Usage: c <project-name>
function c() {
  cd ~/go/src/qu1queee/$1
}

# Open current repo on GitHub in the browser
# Usage: hb
function hb() {
  gh repo view --web
}

# Wraps claude CLI to always run from the git root
# Usage: claude (same as normal, just run it anywhere inside a repo)
function claude() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    local root=$(git rev-parse --show-toplevel)
    if [ "$PWD" != "$root" ]; then
      echo "Switching to git root: $root"
      cd "$root"
    fi
  fi
  command claude $@
}

# Switch Go versions, installs the version if not present
# Usage: usego 1.22.0
function usego() {
  if [ -z "$1" ]; then
    echo "Usage: usego <version>  (e.g. usego 1.22.0)"
    return 1
  fi
  local ver=$1
  if ! command -v go$ver > /dev/null 2>&1; then
    echo "Installing go$ver..."
    go install golang.org/dl/go$ver@latest
    go$ver download
  fi
  ln -sf $(which go$ver) $GOBIN/go
  echo "Switched to $(go version)"
}

# --- Prompt ---
# Shows: current dir + git branch + dirty/staged indicators
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}✖%f'
zstyle ':vcs_info:git:*' formats ' %F{cyan}(%b)%f%c%u'
precmd() { vcs_info }
setopt PROMPT_SUBST
PROMPT='%B%~%b${vcs_info_msg_0_} $ '

# --- fzf (fuzzy finder) ---
# Ctrl+R = interactive history search
# Ctrl+T = fuzzy find file in current directory
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- zoxide (smart cd) ---
# Usage: z <partial-name>  jumps to most frecent match
eval "$(zoxide init zsh)"

# --- Private config (never committed) ---
[ -f ~/.private.zsh ] && source ~/.private.zsh
