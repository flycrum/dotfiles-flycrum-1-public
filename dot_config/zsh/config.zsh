# Main zsh configuration file
# Located at ~/.config/zsh/config.zsh

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins using zinit (turbo mode for fast loading)
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf \
        zsh-users/zsh-completions

# fzf-tab for enhanced tab completion
zinit light Aloxaf/fzf-tab

# wd (warp directory) for bookmarks
zinit light mfaerevaag/wd

# Load OMZ snippets we want (with turbo mode)
zinit wait lucid for \
    OMZP::git \
    OMZP::sudo \
    OMZP::command-not-found

# Install fzf binary and shell integrations
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf
# Shell integrations (modern approach)
eval "$(fzf --zsh)"
# Load fzf shell integrations (key bindings and completion) - commented out for cleaner approach
# zinit ice lucid wait'0'
# zinit snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh'
# zinit ice lucid wait'0'
# zinit snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh'

# Install zoxide (smarter cd command)
zinit ice from"gh-r" as"program"
zinit load ajeetdsouza/zoxide
# Initialize zoxide
eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd cd zsh)"

# History settings
HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

# Basic settings
# setopt AUTO_CD
# setopt EXTENDED_GLOB
# setopt NOTIFY
# setopt PROMPT_SUBST

# Completion settings
autoload -Uz compinit
if [[ -n "$XDG_CACHE_HOME/zsh/compdump" ]]; then
    compinit -d "$XDG_CACHE_HOME/zsh/compdump"
else
    compinit
fi

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Key bindings
bindkey -e  # Use emacs key bindings

# History search bindings (built-in zsh functions)
bindkey '^[[A' history-search-backward    # Up arrow
bindkey '^[[B' history-search-forward     # Down arrow  
bindkey '^P' history-search-backward      # Ctrl+P
bindkey '^N' history-search-forward       # Ctrl+N

# Word navigation (iTerm default sequences)
bindkey '^[[1;3D' backward-word           # Option+Left Arrow
bindkey '^[[1;3C' forward-word            # Option+Right Arrow
# Line editing shortcuts
bindkey '^U' kill-whole-line              # Ctrl+U or CMD+Delete (kill whole line)
bindkey '^K' kill-line                    # Ctrl+K (kill from cursor to end)
bindkey '^W' backward-kill-word           # Ctrl+W (kill word backward)

# Aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Oh My Posh prompt THEME - Conditional loading to prevent Cursor agent hangs
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  # Use a minimal prompt in Cursor to avoid command detection issues
  PROMPT='%n@%m:%~%# '
  RPROMPT=''
else
  # Load oh-my-posh normally in other terminals
  # eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/catppuccin_mocha_custom.omp.json)"  # Catppuccin custom
  # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/neko.omp.json')"  # Neko
  # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/negligible.omp.json')"  # Negligible original
  # eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/negligible_custom.omp.json)"  # Negligible custom
  # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/craver.omp.json')"  # Craver original
  # eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/craver_custom.omp.json)"  # Craver custom
  # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/illusi0n.omp.json')"  # Illusi0n original
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/illusi0n_custom.omp.json)"
fi

# Environment variables
export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'

# Path additions (if needed)
# export PATH="$HOME/.local/bin:$PATH" 