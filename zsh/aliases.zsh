# human friendly output
alias df="df -h"
alias du="du -h -d 2"

# archlinux services
alias start="sudo systemctl start"
alias restart="sudo systemctl restart"
alias stop="sudo systemctl stop"

# if available use silver searcher instead of grep (much more faster)
has_executable "ag" && alias grep="ag"

# ssh servers
alias gediminasm="ssh -A gediminasm -t tmux attach"

# systemd system messages
alias sys-log-now="sudo journalctl -f"
alias sys-log-boot="sudo journalctl -b"
alias sys-log-last-boot="sudo journalctl --since=today | tac | sed -n '/-- Reboot --/{n;:r;/-- Reboot --/q;p;n;b r}' | tac"

# reload configuration
alias reload=". ~/.zshrc"

# misc
alias music="ncmpc"
alias halt="echo 'Use poweroff instead'"
