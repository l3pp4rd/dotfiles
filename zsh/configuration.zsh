#!/usr/bin/env zsh

# Add dircolors
eval $(dircolors $DOTFILES/zsh/dircolors-solarized/dircolors.ansi-dark)

# default text editor
export EDITOR=vim

# default browser
export BROWSER=google-chrome-stable

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# bin for golang
if [ -d "$HOME/go" ]; then
    export GOPATH=$HOME/go # golang workspace
    if [ -d "$HOME/go/bin" ]; then
        export GOBIN=$HOME/go/bin # go executables path
        export PATH=$PATH:$GOBIN # export in path as well
    fi
fi

# bin dir at home
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi

# java
if [ -z "${MAVEN_OPTS}" ]; then
  export MAVEN_OPTS="-Xmx1024m -Djava.security.egd=file:/dev/./urandom"
fi

#### ALIASES

# archlinux services
alias start="sudo systemctl start"
alias restart="sudo systemctl restart"
alias stop="sudo systemctl stop"

# systemd system messages
alias journal-now="sudo journalctl -f"
alias journal-boot="sudo journalctl -b"
alias journal-prev-boot="sudo journalctl --since=today | tac | sed -n '/-- Reboot --/{n;:r;/-- Reboot --/q;p;n;b r}' | tac"

# git remove all merged branches, except current and master
alias git-clean-branches="git branch --merged | grep -v '\*' | grep -v master | xargs -n 1 git branch -d"

# encrypt and decrypt
alias rsa-enc="openssl rsautl -encrypt -pubin -inkey <(ssh-keygen -f ~/.ssh/id_rsa.pub -e -m PKCS8) -ssl | openssl base64"
alias rsa-dec="openssl base64 -d | openssl rsautl -decrypt -inkey ~/.ssh/id_rsa"
alias gpg-enc="gpg --recipient gediminas.morkevicius@gmail.com --encrypt --armor"
alias gpg-dec="gpg --decrypt"

# if go is available install 9t as multi tail command
has_bin go && alias mtail="9t" && (has_bin 9t || go get github.com/gongo/9t/cmd/9t)

# systemd now manages ACPI
pidof systemd > /dev/null && (
  alias reboot="sudo systemctl reboot"
  alias poweroff="sudo systemctl poweroff"
  alias suspend="sudo systemctl suspend"
)
