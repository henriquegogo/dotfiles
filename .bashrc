
### MY CHANGES ###
# Bash prompt
export PROMPT_DIRTRIM=2
export GIT_PS1='$(__git_ps1 " \[\e[34m\](\[\e[31m\]%s\[\e[34m\])")'
export PS1="\n\[\e[33m\]▶ \[\e[36m\]\w$GIT_PS1 \[\e[00m\]"
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}▶ \w\a\]$PS1"
    ;;
*)
    ;;
esac

export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
