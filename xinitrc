#!/bin/sh

xrdb -merge $HOME/.Xresources

exec xmonad
