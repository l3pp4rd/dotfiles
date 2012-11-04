
alias music="ncmpc"

# archlinux services
alias start="sudo rc.d start"
alias restart="sudo rc.d restart"
alias stop="sudo rc.d stop"

# modify tmux
alias tmux="tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$HOSTNAME"

