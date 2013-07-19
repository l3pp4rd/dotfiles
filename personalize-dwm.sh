#!/bin/sh

# current directory
D="$( cd "$( dirname "$0" )" && pwd )"

sudo mkdir -p /usr/share/xsessions
sudo cp -f $D/xsessions/dwm-personalized.desktop /usr/share/xsessions/dwm-personalized.desktop
sudo cp -f $D/usr/local/bin/dwm-personalized /usr/local/bin/dwm-personalized

