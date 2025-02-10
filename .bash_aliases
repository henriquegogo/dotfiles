export PROMPT_DIRTRIM=2
export PS1='\n\[\e[01;33m\]\$ \[\e[34m\]\w \[\e[0m\]$(__git_ps1 "(\[\e[31m\]%s\[\e[0m\]) " 2>/dev/null)'

alias ll='ls -ahps1 --group-directories-first --color'
alias battery='cat /sys/class/power_supply/*/capacity'

google() {
  lynx google.com/search?q="$*"
}

email() {
  if [ -z "$1" ]; then
    echo "Usage: email [FILE]"
  elif [[ -z "$SMTP_SERVER" || -z "$SMTP_USER" || -z "$SMTP_PASS" ]]; then
    echo "Ensure that env vars SMTP_SERVER, SMTP_USER, and SMTP_PASS are all set."
  else
    curl --ssl-reqd "$SMTP_SERVER" -u "$SMTP_USER:$SMTP_PASS" --upload-file "$1" "${@:2}" \
      $(sed -nE 's/^(To:|Cc:) *(.*)$/--mail-rcpt \2/p' "$1" | sed 's/ .*</ /; s/>//' | tr '\r\n' ' ')
  fi
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

ticker() {
  for arg in "$@"; do
    curl -s https://query1.finance.yahoo.com/v8/finance/chart/$arg |\
      jq '.chart.result[0].meta' |\
      jq -M '[.symbol,.regularMarketPrice,.previousClose] | join(" ")' |\
      tr -d '"' | { read symbol price previous
        local LC_NUMERIC=en_US.UTF-8
        [ `bc <<< "$price<$previous"` -eq 1 ] && COLOR="\e[31m" || COLOR="\e[32m"
        busybox printf "\e[37m%-9s \e[36m%9.2f $COLOR%8.2f %6.2f%%\n" $symbol $price \
          `bc -l <<< "$price - $previous"` \
          `bc -l <<< "($price - $previous) / (($price + $previous) / 2) * 100"`
      }
  done
}

