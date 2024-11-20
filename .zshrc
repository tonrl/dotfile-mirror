#================================================#
#    ~/.zshrc file for zsh interactive shells.   #
#                                                #
#                (c) Tonrl 2024                  # 
#        Licensed Under GPL v3 or later          #
#================================================#

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/kanji/.zshrc'

autoload -Uz compinit && compinit
compinit
zstyle ':completion:*' menu select

# End of lines added by compinstall
# set -o vi
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# Functions like autocorrect .zshrc
# setopt autocd              # change directory just by typing its name
setopt correct            # auto correct mistakes

#============================#
# Custom shell prompt (PS1)  #
#============================#
autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git*' formats '( %b) '

setopt PROMPT_SUBST
#PROMPT="(%F{#007f5c}%b%n%f)-%B%F{#666699}[%f🐧%F{#e3f988}%~%f%F{#666699}]%f%b%F{#5e644f}%#%f "
PROMPT='(%F{#007f5c}%b%n%f)-%F{#666699}[%f%F{#e3f988}${PWD/#$HOME/~}%f%F{#666699}]%f%F{#ff007c} ${vcs_info_msg_0_}%f%F{#5e644f}>%f '
# RPROMPT='${vcs_info_msg_0_}'
RPROMPT="%F{241}%B%t [%?]%b%f"

#==========================#
# Terminal Tiele           #
#==========================#

autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi
#End here:

#================================#
# Alias to use exa instead of ls #
#================================#
alias ex='eza --icons --header'
alias exa='eza --icons --header'
# alias eza='eza --icons --header'
alias l='eza --icons --header'
alias ls='eza --icons --header --color-scale'
alias la='eza --long --all --icons --grid --header --color-scale'
alias lg='eza --long --icons --header --git'
alias lag='eza --long --icons --header --grid --all --git --color-scale'
alias ll='eza --long --icons --header --grid'

alias tree='eza --icons --header --color-scale --tree'
#alias dir='exa --icons --header'
alias dir='ls'

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi


# Fix the bug on JAVA appliation on sway window manager
if [ "$XDG_SESSION_DESKTOP" = "sway" ] ; then
    # https://github.com/swaywm/sway/issues/595
    export _JAVA_AWT_WM_NONREPARENTING=1
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Set neovim for man pager
export MANPAGER='nvim +Man!'

#========================================#
# Additional Alias: Put Alias below here #
#========================================#

# Color Support
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# hexdump alias as hd
alias hd="hexdump"
# fastfetch
alias neofetch="fastfetch"

# Kitty Terminal Alias
# ssh (Using kitty terminal function)
alias sss="kitty +kitten ssh"
# kitten icat
alias icat="kitty +kitten icat"

#======================================#
# alias to find or find & kill zombies #
#======================================#
alias zombie="ps -A -ostat,ppid | grep -e '[zZ]' | awk '{ print $2 }'"
alias killzombie="sudo kill -HUP `ps -A -ostat,ppid,pid,cmd | grep -e '^[Zz]' | awk '{print $2}'`"

# reload runs exec zsh to applie changes in .zshrc
alias restartzsh="exec zsh" #this will restart zsh
alias reload=". ~/.zshrc" #This will reread .zsh, may not work
alias unixtime="~/Documents/script/unixtime.sh"

# :w
# check shell
alias shellt="chsh -l"

# Disable vim and chage it to neovim
alias vim="nvim"
alias vi="\vim"
alias v="nvim"

#sudo edit more easy
alias svim="sudoedit"

# alias to paru
alias yay="paru"

# alias ncdu (color support)
alias ncdu="ncdu --color dark"

# Jump to Rust Project dir
alias rustpra="cd ~/Project/Practice/rust/"

# alias to sudo (to make things work with sudo
alias sudo="sudo "


# Check for app_id
alias swayapp="swaymsg -t get_tree | grep app_id"

# Manage dot files
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Rust command
. "$HOME/.cargo/env"

# Custom message script to run on new shell

