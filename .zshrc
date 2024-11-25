#================================================#
#    ~/.zshrc file for zsh interactive shells.   #
#                                                #
#                (c) Tonrl 2024                  # 
#        Licensed Under GPL v3 or later          #
#================================================#

# Nerd fonts are required for icon support

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
#unsetopt extendedglob
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/kanji/.zshrc'
autoload -Uz compinit && compinit
compinit


#export LS_COLORS="di=34:fi=0:ln=36:so=32:pi=33:ex=31"
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#zstyle ':completion:*:commands' list-colors '=*=1;38;5;142'
#zstyle ':completion:*:parameters' list-colors '=*=2;38;5;128'
zstyle ':fzf-tab:completion:*' fzf-preview 'ls --color $ralpath'

# End of lines added by compinstall
# set -o vi
#================#
# Key bindings   #
#================#

bindkey -v
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# function to clear screen and scrollback
function clear-screen-and-scrollback() {
        printf '\x1Bc'
        zle clear-screen
}

zle -N clear-screen-and-scrollback
bindkey '^L' clear-screen-and-scrollback

# Select history
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Functions like autocorrect .zshrc
# setopt autocd              # change directory just by typing its name
setopt correct            # auto correct mistakes

#============================#
# Custom shell prompt (PS1)  #
#============================#
autoload -U colors && colors
autoload -Uz vcs_info
precmd() {
        set_exit_icons
        vcs_info
}
# Change color of arrow based on exit code (Green if 0, red if else)
set_exit_icons() {
        if [ $? -eq 0 ]; then
                exit_icons='%F{#93dc5c} %f'
        else
                exit_icons='%F{#ff07c0} %f'
        fi
}

zstyle ':vcs_info:git*' formats '%F{#3d59a1}git:%f%F{#ff007c}(%b)%f '


setopt PROMPT_SUBST

PROMPT='${exit_icons}(%f%F{#007f5c}%b%n%f)%F{#666699}-%f%F{#666699}[%f%F{#ffc777}${PWD/#$HOME/~}%f%F{#666699}]%f ${vcs_info_msg_0_}%f%F{#414868}%f '
RPROMPT="%F{241}%B%t [%f%F{#7aa2f7}%?%f%F{241}]%b%f"


#================================#
# Alias to use exa instead of ls #
#================================#
alias ex='eza --icons --header'
alias exa='eza --icons --header'
# alias eza='eza --icons --header'
alias l='eza --icons --header'
alias ls='eza --icons --header'
alias la='eza --long --all --icons --grid --header'
alias lg='eza --long --icons --header --git'
alias lag='eza --long --icons --header --grid --all --git --color-scale'
alias ll='eza --long --icons --header --grid'

alias tree='eza --icons --header --color-scale --tree'
#alias dir='exa --icons --header'
alias dir='ls'

#=================================#
# Plugins etc                     #
#=================================#

source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh

# enable auto-suggestions based on the history (Require zsh-autosuggestions to be installed)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#9b9b9b"
fi
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]='fg=#d0d0d0'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=#7aa2f7,bold'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=#ff007c'
    ZSH_HIGHLIGHT_STYLES[arg0]='fg=#c3e88d'
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ff757f'
    ZSH_HIGHLIGHT_STYLES[path]='fg=#c0caf5,underline'
fi

# Fix for bug on JAVA appliation on sway window manager
if [ "$XDG_SESSION_DESKTOP" = "sway" ] ; then
    # https://github.com/swaywm/sway/issues/595
    export _JAVA_AWT_WM_NONREPARENTING=1
fi

# Add RVM to PATH for scripting.
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
alias reload=". ~/.zshrc" #This will reread
alias unixtime="~/Documents/script/unixtime.sh"


# check shell
alias shellt="chsh -l"

# vim for neovim
alias vim="nvim"
alias vi="\vim"
alias v="nvim"

#sudo edit more easy
alias svim="sudoedit"

# use bat instead of cat
alias cat="bat -p"

# alias to paru
alias yay="paru"

# alias ncdu (color support)
alias ncdu="ncdu --color dark"

# alias sudo (to make things work with sudo
alias sudo="sudo "

# Check for app_id (Only works if you use sway)
alias swayapp="swaymsg -t get_tree | grep app_id"

# Manage dot files
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Rust command
. "$HOME/.cargo/env"

# Enable z command
eval "$(zoxide init --cmd cd zsh)"

# fzf
source <(fzf --zsh)
# Custom message script to run on new shell

