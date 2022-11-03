# Add to .bashrc: source $HOME/.bash_profile
export PS1='\[\e]0;\w \u@\h\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# For FreeBSD:
#export LSCOLORS=ExGxFxdxCxDaDahbadacec
export PAGER=less
export EDITOR=nano
export HISTCONTROL=ignoreboth
alias ls='exa --icons --binary --time-style=long-iso'
alias nano='nano -w'
alias grep='grep --color=auto'
