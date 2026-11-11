#!/usr/bin/env bash

# Reinstalls my packages and tools on a fresh Ubuntu (made for 26.04).
# Safe to re-run, every step skips or updates what is already there.
#
#   ./ubuntu_install.sh              # run all steps
#   ./ubuntu_install.sh apt rust     # run only the given steps
#
# Steps: repos apt debs rust bun tools suckless dotfiles system

# Checks I made for 26.04:
# - Every repo signing key the script downloads matches the key on your current system.
# - Docker and both PPAs already publish a resolute (26.04) suite.
# - If a package has been renamed or dropped in 26.04, the script skips it with a warning instead of stopping.

# Left out on purpose:
# - Company security agents (mdatp, qualys-*, jcagent), Landscape and Ubuntu Pro/livepatch: IT usually installs these with company-specific setup.
# - Old docker.io and docker-compose v1: replaced by docker-compose-plugin, so you'd use docker compose instead of docker-compose.
# - Brother printer driver: it needs Brother's interactive installer, so the script just prints a reminder.
# - zig: the old /usr/local/bin/zig link pointed to ~/src/zig, which no longer exists.
# - Your own project binaries in ~/.local/bin (routing, mynet, local-kanban and so on).

# Back these up before upgrading, because the script can't recreate them:
# - ~/src/statusbar has 1 commit that isn't pushed.
# - ~/.config/statusbar.json and ~/.dotfiles/zsh/local.zsh (not tracked in git).
# - ~/.ssh, ~/.gnupg, and your personal projects in ~/src.

# On a fresh system: clone the dotfiles over HTTPS first, since you won't have an SSH key yet, then run the script.

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODENAME="$(. /etc/os-release && echo "$VERSION_CODENAME")"
KEYRINGS=/etc/apt/keyrings
SRC="$HOME/src"
LOCAL_BIN="$HOME/.local/bin"

# everything of mine installs here, make it usable within this run
mkdir -p "$LOCAL_BIN" "$HOME/.config"
export PATH="$LOCAL_BIN:$PATH"

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33mWARN: %s\033[0m\n' "$*" >&2; }

# adds an apt repository with its own signing key
# usage: add_repo <name> <key url> <repo line without "deb [signed-by]">
add_repo() {
    local key="$KEYRINGS/$1.gpg"
    curl -fsSL "$2" | sudo gpg --dearmor --yes -o "$key"
    echo "deb [arch=amd64 signed-by=$key] $3" | sudo tee "/etc/apt/sources.list.d/$1.list" >/dev/null
}

# installs only packages which have an install candidate, so a renamed or
# dropped package in a new release does not abort the whole run
apt_install() {
    local available=() missing=()
    for pkg in "$@"; do
        if apt-cache policy "$pkg" 2>/dev/null | grep -q 'Candidate: [^(]'; then
            available+=("$pkg")
        else
            missing+=("$pkg")
        fi
    done
    sudo apt-get install -y "${available[@]}"
    if [ ${#missing[@]} -gt 0 ]; then
        warn "not available on $CODENAME, skipped: ${missing[*]}"
    fi
}

# downloads and installs a .deb package from url
install_deb() {
    local tmp
    tmp="$(mktemp -d)"
    curl -fsSL -o "$tmp/pkg.deb" "$1"
    sudo apt-get install -y "$tmp/pkg.deb"
    rm -rf "$tmp"
}

# clones or updates a git repository
clone() {
    if [ -d "$2/.git" ]; then
        git -C "$2" pull --ff-only || warn "could not update $2"
    else
        git clone "$1" "$2"
    fi
}

step_repos() {
    log "apt repositories"
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg software-properties-common
    sudo install -m 0755 -d "$KEYRINGS"

    add_repo docker https://download.docker.com/linux/ubuntu/gpg \
        "https://download.docker.com/linux/ubuntu $CODENAME stable"
    add_repo google-cloud https://packages.cloud.google.com/apt/doc/apt-key.gpg \
        "https://packages.cloud.google.com/apt cloud-sdk main"
    add_repo antigravity https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg \
        "https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main"
    add_repo slack https://packagecloud.io/slacktechnologies/slack/gpgkey \
        "https://packagecloud.io/slacktechnologies/slack/debian/ jessie main"
    add_repo github-cli https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        "https://cli.github.com/packages stable main"

    sudo add-apt-repository -y -n ppa:longsleep/golang-backports
    sudo add-apt-repository -y -n ppa:cappelikan/ppa # mainline kernels

    sudo apt-get update
}

step_apt() {
    log "apt packages"
    sudo apt-get upgrade -y

    # X session, dwm, desktop utilities
    apt_install \
        xorg xserver-xorg xterm x11-xkb-utils x11-xserver-utils xclip xdg-utils \
        slim suckless-tools arandr picom feh dunst dzen2 i3lock xss-lock scrot libnotify-bin \
        gnome-keyring seahorse libsecret-tools pinentry-gtk2 dbus-x11 \
        fonts-inconsolata fonts-liberation alacritty

    # sound, bluetooth, network
    apt_install \
        pulseaudio pulseaudio-module-bluetooth pavucontrol alsa-utils bluez \
        network-manager network-manager-openconnect openconnect

    # applications
    apt_install \
        libreoffice qpdfview mplayer ranger ueberzug sqlitebrowser visualvm

    # cli tools
    apt_install \
        zsh tmux byobu screen git tig curl jq ripgrep silversearcher-ag \
        bat fd-find tree htop atop powertop lsof net-tools netcat-openbsd \
        autojump unzip zip gdebi-core apt-rdepends apt-show-versions \
        sqlite3 postgresql-client gnupg2 scdaemon

    # development
    apt_install \
        build-essential cmake pkg-config patch protobuf-compiler golang \
        python3-dev python3-pip python3-venv \
        default-jdk openjdk-17-jdk openjdk-17-doc openjdk-21-jdk openjdk-21-source \
        maven yui-compressor lib32stdc++6 libfuse2t64 libnss3-tools libu2f-udev libusb-0.1-4 \
        libbluetooth-dev libfontconfig1-dev libfreetype-dev libjpeg-dev libncurses-dev \
        libpam0g-dev libpcap-dev libplist-utils libpng-dev libsqlite3-dev libssl-dev \
        libx11-dev libxcb-xfixes0-dev libxft-dev libxinerama-dev libxkbcommon-dev \
        libxmu-dev libxrandr-dev libxt-dev

    # printing and hardware
    apt_install cups cups-ipp-utils hplip fwupd ubuntu-drivers-common

    # third party repositories
    apt_install \
        docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
        google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin kubectl \
        slack-desktop antigravity mainline gh
}

step_debs() {
    log "standalone .deb packages"
    dpkg -s google-chrome-stable >/dev/null 2>&1 ||
        install_deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg -s sniffnet >/dev/null 2>&1 ||
        install_deb https://github.com/GyulyVGC/sniffnet/releases/latest/download/Sniffnet_LinuxDEB_amd64.deb

    warn "Brother DCP-1610W printer driver is manual: https://support.brother.com (linux-brprinter-installer)"
}

step_rust() {
    log "rust"
    if ! command -v rustup >/dev/null 2>&1 && [ ! -x "$HOME/.cargo/bin/rustup" ]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    fi
    . "$HOME/.cargo/env"
    rustup toolchain install stable 1.92 1.96
    rustup default stable
    rustup component add rust-src rust-analyzer
    cargo install --locked cargo-tarpaulin ast-grep
}

step_bun() {
    log "bun"
    [ -x "$HOME/.bun/bin/bun" ] || curl -fsSL https://bun.sh/install | bash
    "$HOME/.bun/bin/bun" add -g @owloops/claude-powerline
}

step_tools() {
    log "tools in $LOCAL_BIN"
    mkdir -p "$LOCAL_BIN"

    # ubuntu names these batcat and fdfind
    ln -sf /usr/bin/batcat "$LOCAL_BIN/bat"
    ln -sf /usr/bin/fdfind "$LOCAL_BIN/fd"

    curl -fsSL -o "$LOCAL_BIN/yq" https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
    chmod +x "$LOCAL_BIN/yq"

    curl -fsSL https://claude.ai/install.sh | bash

    curl -fsSL https://install.duckdb.org | sh
    ln -sf "$(ls -d "$HOME"/.duckdb/cli/*/duckdb | sort -V | tail -1)" "$LOCAL_BIN/duckdb"

    # java language server
    rm -rf "$HOME/.local/share/jdtls" && mkdir -p "$HOME/.local/share/jdtls"
    curl -fsSL https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz |
        tar -xz -C "$HOME/.local/share/jdtls"
    ln -sf "$HOME/.local/share/jdtls/bin/jdtls" "$LOCAL_BIN/jdtls"

    # jetbrains toolbox, run it once to install IntelliJ IDEA
    local toolbox="$HOME/.local/share/jetbrains-toolbox"
    rm -rf "$toolbox" && mkdir -p "$toolbox"
    curl -fsSL 'https://data.services.jetbrains.com/products/download?platform=linux&code=TBA' |
        tar -xz -C "$toolbox" --strip-components=1
    ln -sf "$toolbox/bin/jetbrains-toolbox" "$LOCAL_BIN/jetbrains-toolbox"
}

step_suckless() {
    log "dwm, st, dmenu, statusbar"
    mkdir -p "$SRC"
    for name in dwm st dmenu; do
        clone "https://github.com/l3pp4rd/$name.git" "$SRC/$name"
        make -C "$SRC/$name" clean all
        make -C "$SRC/$name" PREFIX="$HOME/.local" install
    done

    clone https://github.com/l3pp4rd/statusbar.git "$SRC/statusbar"
    # its own "make install" target goes to /usr/local with sudo
    (cd "$SRC/statusbar" && go build -o "$LOCAL_BIN/statusbar")
    if [ ! -f "$HOME/.config/statusbar.json" ] && [ -f "$SRC/statusbar/statusbar.json" ]; then
        cp "$SRC/statusbar/statusbar.json" "$HOME/.config/statusbar.json"
    fi
}

step_dotfiles() {
    log "dotfiles"
    git -C "$DIR" submodule update --init
    make -C "$DIR" vim     # vim from source with python3, into ~/.local
    make -C "$DIR" nvim    # neovim release build, into ~/.local
    export GOPATH="$HOME" GOBIN="$HOME/bin"
    make -C "$DIR" install # fonts, symlinks, bins, tmuxstart, vim and nvim plugins, go binaries
    make -C "$DIR" systemd
}

step_system() {
    log "system settings"
    [ "$(getent passwd "$USER" | cut -d: -f7)" = "$(command -v zsh)" ] || sudo chsh -s "$(command -v zsh)" "$USER"
    if getent group docker >/dev/null; then
        sudo usermod -aG docker "$USER"
        sudo systemctl enable --now docker
    fi
    warn "log out and back in for the zsh shell and docker group to apply"
}

STEPS=(repos apt debs rust bun tools suckless dotfiles system)
[ $# -gt 0 ] && STEPS=("$@")

for step in "${STEPS[@]}"; do
    if ! declare -F "step_$step" >/dev/null; then
        echo "unknown step: $step" >&2
        exit 1
    fi
    "step_$step"
done

log "done"
