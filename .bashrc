### MY CHANGES ###
# Bash prompt
export PROMPT_DIRTRIM=2
if [ -x "$(command -v __git_ps1)" ]; then
  export GIT_PS1='$(__git_ps1 " \[\e[34m\](\[\e[31m\]%s\[\e[34m\])")'
fi
export PS1="\n\[\e[33m\]▶ \[\e[36m\]\w$GIT_PS1 \[\e[00m\]"
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}▶ \w\a\]$PS1"
    ;;
*)
    ;;
esac

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.npm-global/bin
