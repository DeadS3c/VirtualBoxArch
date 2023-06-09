# Load colours and then set prompt
# Prompt preview:
# [user] [~]
# x
autoload -U colors && colors
PS1="%{$fg[red]%}[%{$fg[yellow]%}$USER%{$fg[red]%}] %{$fg[red]%}[%{$fg[yellow]%}%~%{$fg[red]%}]
%{$fg[green]%}>%{$reset_color%} "

# Load aliases and shortcuts if existent
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# ZSH history file
HISTSIZE=100
SAVEHIST=100
HISTFILE=~/.config/zsh/.zsh_history

# Fancy auto-complete (with vi movement)
autoload -Uz compinit
zstyle ':completion:*' menu select=0
zmodload zsh/complist
zstyle ':completion:*' format '>>> %d'
compinit
_comp_options+=(globdots) # hidden files are included

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey "\e[3~" delete-char

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor depending on current mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # Initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;}

export PATH="$PATH:$HOME/scripts/bin/:$HOME/scripts/bin/streams/"
export PASSWORD_STORE_GPG_OPTS="--pinentry-mode loopback --passphrase <passphrase>"
