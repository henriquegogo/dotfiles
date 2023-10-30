export PROMPT_DIRTRIM=2                                       # Trim long prompts
export PS1='\n\[\e[01;33m\]\$ \[\e[34m\]\w \[\e[0m\]'         # Fancy prompt
if which git > /dev/null; then
    export PS1=$PS1'$(__git_ps1 "(\[\e[31m\]%s\[\e[0m\]) ")'  # Git branch
fi
set -o vi                                                     # Terminal Vi mode

google() {
  lynx google.com/search?q="$*"
}

duckduckgo() {
  lynx duckduckgo.com/html?q="$*"
}

nvlc() {
  /usr/bin/nvlc --no-video --global-key-faster Ctrl+] --global-key-slower Ctrl+[ --global-key-play-pause Ctrl+p $@
}

gitlog() {
  git log --format='%Cred%h %Creset%s (%Cgreen%an) %Creset- %Cblue%cr' --graph
}

gitsync() {
  for repo in $(echo */)
  do
    if [ -d $repo/.git ]
    then
      echo $repo
      git -C $repo pull
      echo
    fi
  done
}

wintitle() {
  while true; do echo -ne "\033[2K\r\033[7m $(date +%a\ %d\ %b\ %R) \033[0m\033[1m $(xdotool getwindowfocus getwindowname) \033[0m"; sleep 0.2; done
}

qemucreate() {
  qemu-img create -f qcow2 "$@" 80G
}

qemustart() {
  kvm \
    -cpu host \
    -m 4096M \
    -soundhw hda \
    -net nic -net user \
    -vga virtio \
    "$@"
}

loadenv() {
  if [ -z "$@" ]
  then
    echo "Load folder into env variables"
    echo
    echo "Usage: loadenv [FOLDER1] [FOLDER2]..."
    echo "After load, type 'unloadenv' to revert"
  else
    for arg in "$@"
    do
      __PREFIX=`realpath $arg`
      echo $__PREFIX

      [ ! $__MANPATH ] && __MANPATH=$MANPATH
      [ ! $__CPATH ] && __CPATH=$CPATH
      [ ! $__LD_LIBRARY_PATH ] && __LD_LIBRARY_PATH=$LD_LIBRARY_PATH
      [ ! $__LIBRARY_PATH ] && __LIBRARY_PATH=$LIBRARY_PATH
      [ ! $__PKG_CONFIG_PATH ] && __PKG_CONFIG_PATH=$PKG_CONFIG_PATH
      [ ! $__PATH ] && __PATH=$PATH

      export MANPATH="$__PREFIX/share/man:$MANPATH"
      export CPATH="$__PREFIX/include:$CPATH"
      export LD_LIBRARY_PATH="$__PREFIX/lib:$LD_LIBRARY_PATH"
      export LIBRARY_PATH="$__PREFIX/lib:$LIBRARY_PATH"
      export PKG_CONFIG_PATH="$__PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
      export PATH="$__PREFIX/bin:$PATH"

      unset __PREFIX
    done
  fi
}

unloadenv() {
  [ -v __MANPATH ] && export MANPATH=$__MANPATH
  [ -v __CPATH ] && export CPATH=$__CPATH
  [ -v __LD_LIBRARY_PATH ] && export LD_LIBRARY_PATH=$__LD_LIBRARY_PATH
  [ -v __LIBRARY_PATH ] && export LIBRARY_PATH=$__LIBRARY_PATH
  [ -v __PKG_CONFIG_PATH ] && export PKG_CONFIG_PATH=$__PKG_CONFIG_PATH
  [ $__PATH ] && export PATH=$__PATH

  unset __MANPATH
  unset __CPATH
  unset __LD_LIBRARY_PATH
  unset __LIBRARY_PATH
  unset __PKG_CONFIG_PATH
  unset __PATH

  [ ! $MANPATH ] && unset MANPATH
  [ ! $CPATH ] && unset CPATH
  [ ! $LD_LIBRARY_PATH ] && unset LD_LIBRARY_PATH
  [ ! $LIBRARY_PATH ] && unset LIBRARY_PATH
  [ ! $PKG_CONFIG_PATH ] && unset PKG_CONFIG_PATH
}

chrootstart() {
  if [ -z "$@" ]
  then
    echo "Usage: chrootstart [PATH]"
  else
    cd `realpath $1`

    for dir in "dev/" "proc/" "sys/" "tmp/" "etc/"
    do
      if [ ! -d "$dir" ]
      then
        echo "Directory `pwd`/$dir doesn't exist"
        echo "Please, make sure dev/ proc/ sys/ tmp/ etc/ are created"
        cd - > /dev/null
        return 1
      fi
    done

    sudo mount -o bind /dev dev/
    sudo mount -t proc none proc/
    sudo mount -o bind /sys sys/
    sudo mount -o bind /tmp tmp/

    cp -L /etc/resolv.conf etc/
    xhost + local: > /dev/null

    sudo chroot . sh -l

    sudo umount -R {dev/,proc/,sys/,tmp/}
    cd - > /dev/null
  fi
}