# Custom changes
export PROMPT_DIRTRIM=2
export PS1='\n\[\e[01;33m\]\$ \[\e[34m\]\w \[\e[0m\]'
if which git > /dev/null; then
    export PS1=$PS1'$(__git_ps1 "(\[\e[31m\]%s\[\e[0m\]) ")'
fi
