export PROMPT_DIRTRIM=2
export PS1='\n\[\e[01;33m\]\$ \[\e[34m\]\w \[\e[0m\]'
if which git > /dev/null; then
    export PS1=$PS1'$(__git_ps1 "(\[\e[31m\]%s\[\e[0m\]) ")'
fi

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

chroot-start() {
  # Create a folder, download Alpine Linux MINI ROOT FILESYSTEM and unpack
  # Save this file in that folder and run

  if [ -n "$1" ]
  then
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
  else
    echo "Usage: chroot-start [PATH]"
  fi
}

wintitle() {
  while true; do echo -ne "\033[2K\r\033[7m $(date +%a\ %d\ %b\ %R) \033[0m\033[1m $(xdotool getwindowfocus getwindowname) \033[0m"; sleep 0.2; done
}

qemu-create() {
  qemu-img create -f qcow2 "$@" 80G
}

qemu-start() {
  kvm \
    -cpu host \
    -m 4096M \
    -soundhw hda \
    -net nic -net user \
    -vga virtio \
    "$@"
}
