# Add to .bashrc: source $HOME/.bash_profile

export PS1='\[\e]0;\w \u@\h\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
if [ $(uname -s) == "FreeBSD" ]; then
    # FreeBSD-specific
    export LSCOLORS=ExGxFxdxCxDaDahbadacec
elif [ -f /etc/debian_version ]; then
    # Debian-specific
    alias worldupdate='apt upgrade && apt autoremove --purge'
    
    apt(){
        if [ "$1" = "search" ]; then
            env apt search -F '%p' --disable-columns ${@:2} | fzf --border=none -m --preview='apt-cache show -q=0 {} 2>&1 | grep -E "^N:|^Description-en|^ [^.]"' --preview-window="right,75%,border-none,follow,wrap"
        else
            env apt $@
        fi
    }

    pkg(){
        if [ "$1" = "which" ]; then
            dpkg -S ${@:2}

        elif [ "$1" = "info" ] || [ "$1" = "rinfo" ]; then
            apt show ${@:2}
        else
            apt $@
        fi
    }
fi

export PAGER=less
export EDITOR=nano
export HISTCONTROL=ignoreboth
export XZ_OPT=-T0
alias ls='exa --icons --binary --time-style=long-iso'
alias nano='nano -w'
alias grep='grep --color=auto'
