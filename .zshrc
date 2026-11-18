if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if [[ -d "$HOME/.bin" ]]; then
  export PATH="$HOME/.bin:$PATH"
fi

export PATH="$HOME/dotfiles/bin:$PATH"
export CMD_CHEATS_DIR="$HOME/dotfiles/cheats"

# Shared color palette for completion, fuzzy finder, and file listings.
export CLICOLOR=1
export LSCOLORS="GxFxCxDxCxegedabagacad"
export LS_COLORS="di=1;36:ln=1;35:so=32:pi=33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:*.zip=31:*.tar=31:*.tgz=31:*.gz=31:*.bz2=31:*.xz=31:*.7z=31:*.jpg=35:*.jpeg=35:*.png=35:*.gif=35:*.webp=35:*.pdf=33:*.md=36:*.json=33:*.yml=33:*.yaml=33"

# Ctrl-q is the tmux prefix; disable terminal flow control so it reaches tmux.
stty -ixon 2>/dev/null

# Tab補完を有効化
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select                    # メニュー表示
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # 大文字小文字を区別しない
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

# 履歴から候補表示（→で確定）
if [[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -r /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -r /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if (( ${+ZSH_HIGHLIGHT_STYLES} )); then
  ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta,bold'
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
fi

if [[ -r /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
elif [[ -r /usr/local/opt/fzf/shell/completion.zsh ]]; then
  source /usr/local/opt/fzf/shell/completion.zsh
  source /usr/local/opt/fzf/shell/key-bindings.zsh
fi

export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --ansi --color=fg:#d8dee9,bg:#2e3440,hl:#88c0d0,fg+:#eceff4,bg+:#3b4252,hl+:#8fbcbb,info:#ebcb8b,prompt:#bf616a,pointer:#a3be8c,marker:#b48ead,spinner:#ebcb8b,header:#81a1c1"

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

# Make file listings easier to scan on macOS.
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=auto --group-directories-first"
  alias ll="eza -l --icons=auto --git --group-directories-first"
  alias la="eza -la --icons=auto --git --group-directories-first"
  alias lt="eza --tree --level=2 --icons=auto --group-directories-first"
else
  alias ls="ls -G"
  alias ll="ls -Gl"
  alias la="ls -Gla"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat --paging=never --style=plain"
fi

if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  alias k=kubectl
  compdef k=kubectl
fi

if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
