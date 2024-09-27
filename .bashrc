# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ $EUID -eq 0 ]; then
	export PS1='\[\e]0;\w \u@\h\a\]\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	export PS1='\[\e]0;\w \u@\h\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

#
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi

if [ -f /etc/debian_version ]; then
	alias worldupdate='apt upgrade && apt autoremove --purge'

	pkg() {
		if [ "$1" = "which" ]; then
			dpkg -S ${@:2}
		elif [ "$1" = "list" ]; then
			dpkg -L ${@:2}
		elif [ "$1" = "lock" ]; then
			apt hold ${@:2}
		elif [ "$1" = "unlock" ]; then
			apt unhold ${@:2}
		elif [ "$1" = "info" ] || [ "$1" = "rinfo" ]; then
			apt show ${@:2}
		else
			apt $@
		fi
	}
# Meh way of detecting this is Void Linux
elif [ -d "/etc/xbps.d/" ]; then
	# alias worldupdate='sudo zfsnap snapshot -p worldupdate- -a 4w -r zroot/ROOT && sudo xbps-install -Su'
	alias worldupdate='pkg update && [ $(pkg upgrade -n | wc -l) -gt 0 ] && sudo zfsnap snapshot -p worldupdate- -a 4w -r work/ROOT && sudo xbps-install -u'

	pkg() {
		case "$1" in
		update) sudo xbps-install -S ${@:2} ;;
		upgrade) sudo xbps-install -u ${@:2} ;;
		info) xbps-query -S ${@:2} ;;
		list) xbps-query -f ${@:2} ;;
		rinfo) xbps-query -RS ${@:2} ;;
		install) sudo xbps-install ${@:2} ;;
		remove) sudo xbps-remove ${@:2} ;;
		autoremove) sudo xbps-remove -o ;;
		search) xbps-query --regex -Rs ${@:2} ;;
		which) xbps-query -o ${@:2} ;;
		www) xdg-open $(xbps-query -p homepage -RS ${@:2}) ;;
		*) echo "Lolwut?" ;;
		esac
	}
fi

if [[ $OSTYPE == freebsd* ]]; then
	alias top='top -s1'
else # assume Linux
	alias top='top -d1'
fi

alias ls='exa --icons --binary --time-style=long-iso --no-quotes'
# alias nano='nano -w'
alias grep='grep --color=auto'
alias v='nvim-qt'

if [ $HOSTNAME = "work" ]; then
	PATH="$HOME/.local/share/bob/nvim-bin/:$HOME/.cargo/bin:$HOME/go/bin:$PATH"

	# set_window_title(){
	#     local CWD=$(pwd | sed "s|^$HOME|~|")
	#     echo -ne "\033]0;$CWD $USER@$HOSTNAME\007"
	# }
	# starship_precmd_user_func="set_window_title"
	# eval "$(starship init bash)"

	# export NVM_DIR="$HOME/.nvm"
	# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
