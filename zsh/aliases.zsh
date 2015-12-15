# human friendly output
alias df="df -h"
alias du="du -h -d 2"

# archlinux services
alias start="sudo systemctl start"
alias restart="sudo systemctl restart"
alias stop="sudo systemctl stop"

# ssh servers
alias blog="ssh -A blog -t tmux attach"

# systemd system messages
alias journal-now="sudo journalctl -f"
alias journal-boot="sudo journalctl -b"
alias journal-prev-boot="sudo journalctl --since=today | tac | sed -n '/-- Reboot --/{n;:r;/-- Reboot --/q;p;n;b r}' | tac"

# reload configuration
alias reload=". ~/.zshrc"

# git
# remove all merged branches, except current and master
alias git-clean-branches="git branch --merged | grep -v '\*' | grep -v master | xargs -n 1 git branch -d"

