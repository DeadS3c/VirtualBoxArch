#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source "$HOME/.config/aliasrc"
PS1="%{\033[0;31m%}[%{\033[1;33m%}$USER%{\033[0;31m%}] %{\033[0;31m%}[%{\033[1;33m%}%~%{\033[0;31m%}]
%{\033[0;32m%}>%{\033[0m%} "
