# .bash_profile
export PAGER=less
export EDITOR=nvim
export XZ_OPT=-T0

if [[ $OSTYPE == freebsd* ]]; then
    export LSCOLORS=ExGxFxdxCxDaDahbadacec
fi

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
