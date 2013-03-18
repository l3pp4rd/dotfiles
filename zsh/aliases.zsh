
alias music="ncmpc"

# archlinux services
alias start="sudo systemctl start"
alias restart="sudo systemctl restart"
alias stop="sudo systemctl stop"

# modify tmux
alias tmux="tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$HOSTNAME"

# use ag instead of grep (much more faster)
alias grep="ag"

# ssh servers
alias jirafe-freebird="ssh -A jirafe-freebird -t tmux attach"
alias gediminasm="ssh -A gediminasm -t tmux attach"

# systemd system messages
alias sys-log-now="sudo journalctl -f"
alias sys-log-boot="sudo journalctl -b"
alias sys-log-last-boot="sudo journalctl --since=today | tac | sed -n '/-- Reboot --/{n;:r;/-- Reboot --/q;p;n;b r}' | tac"
