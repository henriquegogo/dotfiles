export PROMPT_DIRTRIM=2                                       # Trim long prompts
export PS1='\n\[\e[01;33m\]\$ \[\e[34m\]\w \[\e[0m\]'         # Fancy prompt
if [ $(type -t __git_ps1) ]; then
  export PS1=$PS1'$(__git_ps1 "(\[\e[31m\]%s\[\e[0m\]) ")'    # Git branch
fi

alias ll='ls -ahps1 --group-directories-first --color'

google() {
  lynx google.com/search?q="$*"
}

loadenv() {
  if [ -z "$1" ]
  then
    echo "Load folder into env variables"
    echo
    echo "Usage: loadenv [FOLDER1] [FOLDER2]..."
  else
    for arg in "$@"
    do
      __PREFIX=`realpath $arg`

      if [[ "$PATH" != *"$__PREFIX"* ]]; then
        [ -d "$__PREFIX/share/man" ]     && export MANPATH="$__PREFIX/share/man:$MANPATH"
        [ -d "$__PREFIX/include" ]       && export CPATH="$__PREFIX/include:$CPATH"
        [ -d "$__PREFIX/lib" ]           && export LD_LIBRARY_PATH="$__PREFIX/lib:$LD_LIBRARY_PATH"
        [ -d "$__PREFIX/lib" ]           && export LIBRARY_PATH="$__PREFIX/lib:$LIBRARY_PATH"
        [ -d "$__PREFIX/lib/pkgconfig" ] && export PKG_CONFIG_PATH="$__PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
        [ -d "$__PREFIX/bin" ]           && export PATH="$__PREFIX/bin:$PATH" || export PATH="$__PREFIX:$PATH"
      fi

      unset __PREFIX
    done
  fi
}
[ -d "$HOME/opt" ] && loadenv $HOME/opt/*

chrootless() {
  if [ -z "$1" ]
  then
    echo "Start chroot with clean environment"
    echo
    echo "Usage: chrootless [PATH]"
    echo "Copy /etc/resolv.conf to [PATH]/etc to make network works"
  else
    __COMMAND="${@:2}"
    [ -z "$2" ] && __COMMAND="sh -l"
    unshare --mount-proc -prf chroot $1 env - DISPLAY=$DISPLAY $__COMMAND
    unset __COMMAND
  fi
}
