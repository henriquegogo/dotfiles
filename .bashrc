# Bash prompt
export PROMPT_DIRTRIM=2
export PS1='\n\[\e[33m\]▶ \[\e[36m\]\w$(__git_ps1 " \[\e[34m\](\[\e[31m\]%s\[\e[34m\])") \[\e[00m\]'
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}▶ \w\a\]$PS1"
    ;;
*)
    ;;
esac

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/bin

# Node.js
export PATH=$PATH:$HOME/.npm-global/bin

# Deno
export DENO_INSTALL=$HOME/.deno
export PATH=$DENO_INSTALL/bin:$PATH

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export PATH=$PATH:/opt/apps/go/bin
export GOPATH=$HOME/.go
export GOBIN=$HOME/.go/bin
#export GOFLAGS=-mod=vendor
export GOFLAGS=
export PATH=$PATH:$GBIN
