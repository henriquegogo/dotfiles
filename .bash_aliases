export PROMPT_DIRTRIM=2
export PS1='\n\[\e[01;33m\]\$ \[\e[34m\]\w \[\e[0m\]$(__git_ps1 "(\[\e[31m\]%s\[\e[0m\]) " 2>/dev/null)'

alias ll='ls -ahps1 --group-directories-first --color'
alias battery='cat /sys/class/power_supply/*/capacity'

websearch() {
  lynx duckduckgo.com/?q="$*"
}

wikipedia() {
  lynx en.m.wikipedia.org/?search="$*"
}

wikipediapt() {
  lynx pt.m.wikipedia.org/?search="$*"
}

loadenv() {
  if [ -z "$1" ]; then
    echo "Usage: loadenv [FOLDER1] [FOLDER2]..."
  else
    for arg in "$@"; do
      local PREFIX=`realpath $arg`

      if [[ "$PATH" != *"$PREFIX"* ]]; then
        [ -d "$PREFIX/share/man" ]     && export MANPATH="$PREFIX/share/man:$MANPATH"
        [ -d "$PREFIX/include" ]       && export CPATH="$PREFIX/include:$CPATH"
        [ -d "$PREFIX/lib" ]           && export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
        [ -d "$PREFIX/lib" ]           && export LIBRARY_PATH="$PREFIX/lib:$LIBRARY_PATH"
        [ -d "$PREFIX/lib/pkgconfig" ] && export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
        [ -d "$PREFIX/bin" ]           && export PATH="$PREFIX/bin:$PATH" || export PATH="$PREFIX:$PATH"
      fi
    done
  fi
}
[ -d "$HOME/opt" ] && loadenv $HOME/opt/*

confine() {
  if [ -z "$1" ]; then
    echo "Usage: confine [PATH]"
  else
    local COMMAND="${@:2}"
    [ -z "$2" ] && COMMAND="env - DISPLAY=$DISPLAY TERM=$TERM USER=root HOME=/root sh -l"
    sudo unshare --mount-proc -pfR $1 $COMMAND
  fi
}

chhome() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: chhome [PATH] [COMMAND]"
  else
    local NEWHOME=`realpath $1`
    HOME="$NEWHOME" PATH="$NEWHOME/bin:$PATH" LD_LIBRARY_PATH="$NEWHOME/lib:$NEWHOME/lib64:$LD_LIBRARY_PATH" "${@:2}"
  fi
}

watchpath() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: watchpath [PATH] [COMMAND]"
  else
    while :; do
      if [[ $(ls -lR --full-time "$1") != "$OLD" ]]; then
        local OLD=$(ls -lR --full-time "$1")
        eval "${@:2}"
      fi
      sleep 1
    done
  fi
}

selfextract() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: selfextract [FOLDER] [COMMAND] [PARAMS]"
  else
    local OUTPUT_BIN="${2}.bin"
    echo "#!/bin/bash" > "${OUTPUT_BIN}"
    echo "TMPDIR=\$(mktemp -d)" >> "${OUTPUT_BIN}"
    echo "tail -n +6 \$0 | tar x -C \$TMPDIR" >> "${OUTPUT_BIN}"
    echo "(cd \$TMPDIR && ./$2 $3 \$@)" >> "${OUTPUT_BIN}"
    echo "rm -rf \$TMPDIR; exit 0" >> "${OUTPUT_BIN}"
    tar cf - -C "$1" . >> "${OUTPUT_BIN}"
    chmod +x "${OUTPUT_BIN}"
  fi
}
