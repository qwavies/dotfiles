# initialise starship for terminal prompt
eval "$(starship init zsh)"

# set up zoxide to better navigate file system
eval "$(zoxide init zsh --cmd cd)"

# set up fzf keybindings and fuzzy completion
source <(fzf --zsh)

# enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[path]="none"
ZSH_HIGHLIGHT_STYLES[path_prefix]="none"
ZSH_HIGHLIGHT_STYLES[command]="none"
ZSH_HIGHLIGHT_STYLES[builtin]="none"
ZSH_HIGHLIGHT_STYLES[alias]="none"
ZSH_HIGHLIGHT_STYLES[function]="none"

# enable autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# set autocomplete to case-insensitive
autoload -Uz compinit && compinit
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ':completion:*' menu select
setopt MENU_COMPLETE

# -----------------
# aliases
# -----------------

# eza
alias ls="eza -T --level=1  --group-directories-first --icons ."
alias lls="eza -Tla --level=1  --group-directories-first --icons ."
alias ll="eza -T --level=2  --group-directories-first --icons ."
alias lll="eza -T --level=3  --group-directories-first --icons ."
alias llll="eza -T --level=4  --group-directories-first --icons ."

# fzf
alias fzfp='fzf --preview="bat --color=always {}"'
alias fzfe='nvim $(fzf --preview="bat --color=always {}")'

# neovim
alias vim="nvim"

# fastfetch
alias neofetch="fastfetch"

# bat
alias cat="bat"

# yazi
function ff() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d "" cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# ripgrep
alias grep="rg"

# fd
alias find="fd"

# ncdu
alias duu="ncdu"

# vscodium
alias code="codium"

# common "exit" mistype
alias eixt="exit"

# traverse to root of the git directory
alias cdg='cd $(git rev-parse --show-toplevel)'

# -----------------
# movement commands
# -----------------

home() {
   cd $HOME
   clear
   fastfetch
}

gh() { cd $HOME }
gd() { cd $HOME/Downloads }
gc() { cd $HOME/.config }
:q() { exit }

# -----------------
# binds
# -----------------

bindkey "\e\e" kill-whole-line
bindkey "^ " autosuggest-accept

# use vim keybindings
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line


# -----------------
# environment variables
# -----------------

export EDITOR="nvim"
export TERM="wezterm"
export TERMINAL="wezterm"
export MANPAGER="nvim +Man!"

# -----------------
# other settings
# -----------------

unsetopt PROMPT_SP

# -----------------
# startup
# -----------------
fastfetch

