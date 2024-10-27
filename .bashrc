#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt

DEFAULT=$PS1
PS1="(%F{#007f5c}%b%n%f)-%B%F{#666699}[%f🐧%F{#e3f988}%~%f%F{#666699}]%f%b%F{#5e644f}%#%f "


RPROMPT="%F{241}%B%t [%?]%b%f"


if [ "$XDG_SESSION_DESKTOP" = "sway" ] ; then
    # https://github.com/swaywm/sway/issues/595
    export _JAVA_AWT_WM_NONREPARENTING=1
fi


# alias ls='ls --color=auto'
alias grep='grep --color=auto'

# alias ls= "eza --icons"


PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"
