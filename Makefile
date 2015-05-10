.PHONY: install symlinks fonts bins

FONT_CONF_DIR := "$(HOME)/.config/fontconfig/conf.d"
FONT_DIR := "$(HOME)/.fonts"
HOME_BIN := "$(HOME)/bin"
DIR := $(shell cd "$( dirname "$0" )" && pwd)

install: .deps fonts symlinks bins
	vim +PlugInstall +qall

update: .deps fonts
	git submodule foreach git pull origin master
	vim +PlugUpdate +qall

symlinks:
	@if [ ! -d "$(HOME)/.config" ]; then mkdir "$(HOME)/.config"; fi
	@if [ ! -d "$(HOME)/.mpd" ]; then mkdir -p "$(HOME)/.mpd/playlists"; fi
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

systemd:
	@command -v systemctl >/dev/null 2>&1 || (echo "systemd is not available"; exit 1)
	@sudo cp $(DIR)/usr/lib/systemd/system/slimlock.service /usr/lib/systemd/system/slimlock.service

bins:
	@if [ ! -d "$(HOME_BIN)" ]; then mkdir "$(HOME_BIN)"; fi
	@for BINARY in $(shell ls -1 $(DIR)/bin); do ln -sf "$(DIR)/bin/$$BINARY" "$(HOME_BIN)/$$BINARY"; done

fonts:
	@command -v curl >/dev/null 2>&1 || (echo "curl needs to be installed"; exit 1)
	@if [ ! -d "$(FONT_DIR)" ]; then mkdir "$(FONT_DIR)"; fi
	@if [ ! -d "$(FONT_CONF_DIR)" ]; then mkdir -p "$(FONT_CONF_DIR)"; fi
	@curl -L https://raw.github.com/Lokaltog/powerline/develop/font/10-powerline-symbols.conf > $(FONT_CONF_DIR)/10-powerline-symbols.conf
	@curl -L https://raw.github.com/Lokaltog/powerline/develop/font/PowerlineSymbols.otf > $(FONT_DIR)/PowerlineSymbols.otf
	@curl -L 'https://raw.github.com/Lokaltog/powerline-fonts/master/Inconsolata/Inconsolata%20for%20Powerline.otf' > $(FONT_DIR)/Inconsolata.otf
	@fc-cache -vf $(FONT_DIR)

.deps:
	@command -v git >/dev/null 2>&1 || (echo "git needs to be installed"; exit 1)
	@command -v vim >/dev/null 2>&1 || (echo "vim needs to be installed"; exit 1)
	@git submodule update --init
