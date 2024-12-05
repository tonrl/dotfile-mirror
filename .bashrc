#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
DEFAULT=$PS1
PS1="(\u)-[\w]\$ "


RPROMPT="%F{241}%B%t [%?]%b%f"


if [ "$XDG_SESSION_DESKTOP" = "sway" ] ; then
    # https://github.com/swaywm/sway/issues/595
    export _JAVA_AWT_WM_NONREPARENTING=1
fi


# alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ls='eza --color --icons'
alias l='eza --color --icons'
alias ll='exa --color --icons --header --grid --long'
alias la='eza --color --icons --header --all --grid --long'
alias vim='nvim'
alias v='nvim'
alias cat='bat -p'
# alias ls= "eza --icons"


. "$HOME/.cargo/env"
