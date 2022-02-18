# Load version control information
#autoload -Uz vcs_info
#precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
#zstyle ':vcs_info:git:*' formats ' (%b)'

# Set up the prompt (with git branch name)

#autoload -U colors && colors
#setopt histignorealldups sharehistory


parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

setopt PROMPT_SUBST
PROMPT='%F{240}%n%F{red}@%F{green}%m:%F{141}%d%F{reset}$(parse_git_branch) > '
#PROMPT='%9c%{%F{green}%}$(parse_git_branch)%{%F{none}%} $ '


# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#auto-startX to tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

#add keyboard layout to dwm
setxkbmap us,ua -option grp:ctrl_alt_toggle

# {{{ Environment
export HISTSIZE=10000
export SAVEHIST=10000
export LESSHISTFILE="-"
export READNULLCMD="${PAGER}"
export BROWSER="brave-browser"
export XTERM="st"
# }}}

# set up the pager for syntax hyghlight in terminal
#export PAGER="most"


# {{{ Aliases
alias n="newsboat"
alias c="cmus"
alias sd="sudo shutdown now"
alias rb="sudo reboot"
alias t="tmux"
alias mc='. /usr/lib/mc/mc-wrapper.sh'
alias bm="bash /home/$USER/.config/bashmount/bashmount"
alias nm="nmtui"
alias v="nvim"
alias h="cht.sh --shell"

# init bare repo for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# After you've executed the setup any file within the $HOME folder can be versioned with normal commands, replacing git with your newly created config alias, like:
# git init --bare $HOME/.dotfiles
# config config --local status.showUntrackedFiles no
# config status
# config add .vimrc
# config commit -m "Add vimrc"
# config add .bashrc
# config commit -m "Add bashrc"
# config push

# To clone the repo use next commands
# git clone \
#    --separate-git-dir=$HOME/.dotfiles \
#    git@github.com:xwav/.dotfiles.git \
#    .dotfiles
# {{{ Main


alias ..="cd .."
alias ...="cd ../.."
alias ls="ls -aF --color=always"
alias ll="ls -l"
alias grep="grep --color=always"
alias cp="cp -ia"
alias mv="mv -i"
alias rm="rm -i"
alias shred="shred -uz"
alias top="htop"
alias psg="ps auxw | grep -i "
alias psptree="ps auxwwwf"
alias df="df -hT"
alias du="du -hc"
alias dus="du -S | sort -n"
alias free="free -m"
alias x="startx &"
alias screen="screen -U -l"
alias passgen="< /dev/urandom tr -cd \[:graph:\] | fold -w 32 | head -n 5"
# }}}

# {{{ Git aliases need to be added }}}

#source zsh-syntax-highlightning and zsh-autosuggestions
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#mount GoogleDrive

mount | grep "${HOME}/GoogleDrive" >/dev/null || /usr/bin/google-drive-ocamlfuse "${HOME}/GoogleDrive"&

#support colors in tmux
TERM=tmux-256color
