#!/bin/sh

# Note:
# 1. pulseaudio uses user systemd service
export LIBGL_ALWAYS_SOFTWARE=1

is_bin() {
    TMP=`which $1 2> /dev/null`
    [ $? -eq 0 ]
}

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# activate gpg or ssh agent whichever is available
if hash gpg-agent 2> /dev/null; then
  export GPG_TTY=$(tty)
  gpg-connect-agent updatestartuptty /bye >/dev/null
  # note that uses systemd services to manage gpg-agent
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
elif hash ssh-agent 2> /dev/null; then
  eval $(ssh-agent)
fi

# start transparency daemon
# NOTE: is not compatible with ranger image preview (w3m, ueberzug)
# is_bin compton && compton -b

# custom key mapping modifications
xmodmap ~/.xmodmap

# disable screen saver
is_bin xset && xset -dpms s off
