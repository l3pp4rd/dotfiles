#!/bin/sh

# slim starts this without a login shell, ~/.profile and zsh config are not
# sourced, so add user scripts to PATH for dwm and everything it spawns
export PATH="$HOME/.local/bin:$PATH"

exec dwm-personalized
