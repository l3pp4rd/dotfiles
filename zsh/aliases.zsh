
alias music="ncmpc"

# archlinux services
alias start="sudo systemctl start"
alias restart="sudo systemctl restart"
alias stop="sudo systemctl stop"

# if available use silver searcher instead of grep (much more faster)
if [ `which ag | grep "not found" | wc -l` -eq 0 ]; then
    alias grep="ag"
fi

# ssh servers
alias jirafe-freebird="ssh -A jirafe-freebird -t tmux attach"
alias gediminasm="ssh -A gediminasm -t tmux attach"

# systemd system messages
alias sys-log-now="sudo journalctl -f"
alias sys-log-boot="sudo journalctl -b"
alias sys-log-last-boot="sudo journalctl --since=today | tac | sed -n '/-- Reboot --/{n;:r;/-- Reboot --/q;p;n;b r}' | tac"
