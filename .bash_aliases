export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\n\[\e['"$([ -n "$SSH_CLIENT" ] && echo 33 || ([ -n "$container" ] && echo 35 || echo 32))"'m\]\u\
$([ -n "$SSH_CLIENT$container" ] && echo "@\h") \[\e[34m\]\w \[\e[0m\]\
$(__git_ps1 "(\[\e[31m\]%s\[\e[0m\]) " 2>/dev/null)\n\$ '

alias battery='cat /sys/class/power_supply/*/capacity'

unalias l 2> /dev/null
l() {
  local cmd="ls"
  type busybox >/dev/null 2>&1 && cmd="busybox ls"
  $cmd -shAp1 --group-directories-first --color=always "$@"
}

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
    return 1
  fi
  for arg in "$@"; do
    local PREFIX=$(realpath $arg)

    if [[ "$PATH" != *"$PREFIX"* ]]; then
      [ -d "$PREFIX/share/man" ]     && export MANPATH="$PREFIX/share/man:$MANPATH"
      [ -d "$PREFIX/include" ]       && export CPATH="$PREFIX/include:$CPATH"
      [ -d "$PREFIX/lib" ]           && export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
      [ -d "$PREFIX/lib" ]           && export LIBRARY_PATH="$PREFIX/lib:$LIBRARY_PATH"
      [ -d "$PREFIX/lib/pkgconfig" ] && export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
      [ -d "$PREFIX/bin" ]           && export PATH="$PREFIX/bin:$PATH" || export PATH="$PREFIX:$PATH"
    fi
  done
}

confine() {
  if [ -z "$1" ]; then
    echo "Usage: confine [PATH] [COMMAND]"
    return 1
  fi
  local TARGET=$(realpath "$1"); shift
  mkdir -p "$HOME"/{.home,.config,.local,.cache}
  bwrap --ro-bind / / --dev-bind /dev /dev --proc /proc \
    --tmpfs "$HOME" --tmpfs /var/tmp --bind /tmp /tmp \
    --overlay-src "$HOME/.home"   --tmp-overlay "$HOME" \
    --overlay-src "$HOME/.config" --tmp-overlay "$HOME/.config" \
    --overlay-src "$HOME/.local"  --tmp-overlay "$HOME/.local" \
    --overlay-src "$HOME/.cache"  --tmp-overlay "$HOME/.cache" \
    --bind "$TARGET" "$TARGET" --chdir "$TARGET" "${@:-bash}"
}

machinespawn() {
  if [ -z "$1" ]; then
    echo "Usage: machinespawn [MACHINE] [PARAMS]"
    return 1
  fi
  sudo systemd-nspawn -M "$1" --hostname="$1" --background="" \
    --directory=/var/lib/machines/base \
    --overlay=/var/lib/machines/base:/var/lib/machines/"$1":/ "${@:2}"
}

mksquashbin() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: mksquashbin [FOLDER] [COMMAND] [PARAMS]"
    return 1
  fi
  local OUTPUT_BIN="${2}.bin"
  echo "#!/usr/bin/env bash" > "${OUTPUT_BIN}"
  echo "TMP=\$(mktemp -d)" >> "${OUTPUT_BIN}"
  echo "tail -n +6 \$0 > \$TMP.squashfs && squashfuse \$TMP.squashfs \$TMP" >> "${OUTPUT_BIN}"
  echo "PATH=\"\$TMP:\$TMP/bin:\$PATH\" LD_LIBRARY_PATH=\"\$TMP/lib:\$TMP/lib64:\$LD_LIBRARY_PATH\" \$TMP/$2 $3 \$@" >> "${OUTPUT_BIN}"
  echo "fusermount -u \$TMP && rm -rf \$TMP \$TMP.squashfs; exit 0" >> "${OUTPUT_BIN}"
  mksquashfs "$1" "${OUTPUT_BIN}.tmp" -comp zstd -noappend >/dev/null 2>&1
  cat "${OUTPUT_BIN}.tmp" >> "${OUTPUT_BIN}"
  rm "${OUTPUT_BIN}.tmp"
  chmod +x "${OUTPUT_BIN}"
}

watchpath() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: watchpath [PATH] [COMMAND]"
    return 1
  fi
  while :; do
    if [[ $(ls -lR --full-time "$1") != "$OLD" ]]; then
      local OLD=$(ls -lR --full-time "$1")
      eval "${@:2}"
    fi
    sleep 1
  done
}

appinstall() {
  sudo find /usr/local/bin -xtype l -delete
  if [ "$#" -lt 1 ]; then
    echo "Usage: appinstall [FILE]"
    return 0
  fi
  local FILE=$(realpath "$1")
  local DEST="/usr/local/apps/$(basename "${FILE%%.*}")"
  sudo mkdir -p "$DEST"
  [[ "$FILE" == *.zip ]] && \
    sudo unzip -q "$FILE" -d "$DEST" || sudo tar xf "$FILE" -C "$DEST"
  find "$DEST" -maxdepth 3 -path "*/bin/*" -exec \
    sudo ln -sfv {} /usr/local/bin/ \;
}

ai() {
  local OLLAMA_HOST="${OLLAMA_HOST:-http://localhost:11434}"; local MODEL="${OLLAMA_MODEL:-qwen2.5-coder:1.5b}"
  local AUTH_HEADER=(); [ -n "$OLLAMA_API_KEY" ] && AUTH_HEADER=(-H "Authorization: Bearer ${OLLAMA_API_KEY}")
  local PROMPT=""
  [ $# -gt 0 ] && PROMPT="$*"
  [ $# -eq 0 ] && [ ! -t 0 ] && PROMPT=$(cat)
  [ $# -eq 0 ] && [ -t 0 ] && OLLAMA_HOST="$OLLAMA_HOST" ollama run "$MODEL" && return 0
  jq -n --arg m "$MODEL" --arg p "$PROMPT" \
    '{model: $m, prompt: $p, stream: false}' \
    | curl -s "${AUTH_HEADER[@]}" "${OLLAMA_HOST}/api/generate" -H "Content-Type: application/json" --data-binary @- \
    | jq -r '.response // empty' \
    | sed -z 's/.*<\/think>[[:space:]]*//'
}
export -f ai
