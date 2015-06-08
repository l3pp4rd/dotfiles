.PHONY: install symlinks fonts bins tmuxstart

FONT_CONF_DIR := $(HOME)/.config/fontconfig/conf.d
FONT_DIR := $(HOME)/.fonts
DIR := $(shell cd "$( dirname "$0" )" && pwd)

install: .deps fonts symlinks bins tmuxstart
	vim +PlugInstall +qall

update: .deps fonts tmuxstart
	git submodule foreach git pull origin master
	vim +PlugUpdate +qall

symlinks:
	@mkdir -p $(HOME)/.config
	@mkdir -p $(HOME)/.mpd/playlists
	@ln -sfn $(DIR)/vim $(HOME)/.vim
	@ln -sfn $(DIR)/vimrc $(HOME)/.vimrc
	@ln -sfn $(DIR)/zshrc $(HOME)/.zshrc
	@ln -sfn $(DIR)/tmux.conf $(HOME)/.tmux.conf
	@ln -sfn $(DIR)/mpd.conf $(HOME)/.mpdconf
	@ln -sfn $(DIR)/mplayer $(HOME)/.mplayer
	@ln -sfn $(DIR)/config/ranger $(HOME)/.config/ranger
	@ln -sfn $(DIR)/config/solarized $(HOME)/.config/solarized
	@ln -sfn $(DIR)/xinitrc $(HOME)/.xinitrc
	@ln -sfn $(DIR)/git/gitignore $(HOME)/.gitignore
	@ln -sfn $(DIR)/git/gitconfig $(HOME)/.gitconfig

tmuxstart:
	curl -L https://raw.githubusercontent.com/treyhunner/tmuxstart/master/tmuxstart > /tmp/tmuxstart
	chmod +x /tmp/tmuxstart
	sudo mv /tmp/tmuxstart /usr/local/bin/tmuxstart
	mkdir -p $(HOME)/.tmuxstart
	cp tmuxstart/dotfiles $(HOME)/.tmuxstart/dotfiles

systemd:
	@command -v systemctl >/dev/null 2>&1 || (echo "systemd is not available"; exit 1)
	@sudo cp $(DIR)/usr/lib/systemd/system/slimlock.service /usr/lib/systemd/system/slimlock.service

bins:
	@for BINARY in $(shell ls -1 $(DIR)/usr/local/bin); do sudo cp -f "$(DIR)/usr/local/bin/$$BINARY" "/usr/local/bin/$$BINARY"; done

fonts:
	@command -v curl >/dev/null 2>&1 || (echo "curl needs to be installed"; exit 1)
	@mkdir -p $(FONT_DIR)
	@mkdir -p $(FONT_CONF_DIR)
	@curl -L https://raw.github.com/Lokaltog/powerline/develop/font/10-powerline-symbols.conf > $(FONT_CONF_DIR)/10-powerline-symbols.conf
	@curl -L https://raw.github.com/Lokaltog/powerline/develop/font/PowerlineSymbols.otf > $(FONT_DIR)/PowerlineSymbols.otf
	@curl -L 'https://raw.github.com/Lokaltog/powerline-fonts/master/Inconsolata/Inconsolata%20for%20Powerline.otf' > $(FONT_DIR)/Inconsolata.otf
	@fc-cache -vf $(FONT_DIR)

.deps:
	@command -v git >/dev/null 2>&1 || (echo "git needs to be installed"; exit 1)
	@command -v vim >/dev/null 2>&1 || (echo "vim needs to be installed"; exit 1)
	@git submodule update --init
