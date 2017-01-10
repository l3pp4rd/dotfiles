#!/bin/sh

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

# activate ssh agent
is_bin ssh-agent && eval $(ssh-agent)

# start pulseaudio
is_bin pulseaudio && pulseaudio --start

# start transparency daemon
is_bin xcompmgr && xcompmgr -c &

# custom key mapping modifications
xmodmap ~/.xmodmap

# disable screen saver
is_bin xset && xset -dpms s off

exec dwm-personalized

