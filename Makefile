.PHONY: install dotfiles fonts bins tmuxstart vim systemd xsessions

FONT_CONF_DIR := $(HOME)/.config/fontconfig/conf.d
FONT_DIR := $(HOME)/.fonts
DIR := $(shell pwd)

BINS := $(shell find usr/local/bin -executable -type f)
SERVICES := $(shell find usr/lib/systemd/system -name '*.service')
XSESSIONS := $(shell find usr/share/xsessions -name '*.desktop')

# make a symlink to home directory for given dotfile
define dot =
ln -sfn $(DIR)/$(1) $(HOME)/.$(1)
endef

define installed =
command -v $(1) >/dev/null 2>&1 || (echo "$(1) needs to be installed and available in $$PATH"; exit 1)
endef

install: .deps fonts dotfiles bins tmuxstart
	@git submodule update --init
	vim +PlugInstall +GoUpdateBinaries +qall

update: .deps fonts tmuxstart
	@git submodule update --init
	curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	git submodule foreach git pull origin master
	vim +PlugInstall +PlugUpdate +GoUpdateBinaries +qall

# WARNING: will overwrite these dotfiles in $HOME
dotfiles: .deps
	@$(call dot,vim)
	@$(call dot,vimrc)
	@$(call dot,xinitrc)
	@$(call dot,xmodmap)
	@$(call dot,zshrc)
	@$(call dot,tmux.conf)
	@$(call dot,mplayer)
	@$(call dot,gitignore)
	@$(call dot,gitconfig)
	@$(call dot,config/ranger)
	@$(call dot,config/solarized)

tmuxstart: .deps
	curl -L https://raw.githubusercontent.com/treyhunner/tmuxstart/master/tmuxstart > /tmp/tmuxstart
	chmod +x /tmp/tmuxstart
	sudo mv /tmp/tmuxstart /usr/local/bin/tmuxstart
	cp tmuxstart/dotfiles $(HOME)/.tmuxstart/dotfiles

bins:
	@for BINARY in $(BINS); do sudo cp -f $$BINARY /$$BINARY; done

POWERLINE := https://raw.github.com/Lokaltog/powerline

fonts: .deps
	@curl -L $(POWERLINE)/develop/font/10-powerline-symbols.conf > $(FONT_CONF_DIR)/10-powerline-symbols.conf
	@curl -L $(POWERLINE)/develop/font/PowerlineSymbols.otf > $(FONT_DIR)/PowerlineSymbols.otf
	@curl -L $(POWERLINE)-fonts/master/Inconsolata/Inconsolata%20for%20Powerline.otf > $(FONT_DIR)/Inconsolata.otf
	@fc-cache -vf $(FONT_DIR)

vim:
	@$(call installed,git)
	@if [ ! -d "/tmp/vim_src" ]; then git clone https://github.com/vim/vim.git /tmp/vim_src; fi
	@cd /tmp/vim_src && ./configure \
--prefix=/usr/local \
--with-features=huge \
--with-compiledby="Custom edition" \
--enable-gpm \
--enable-acl \
--with-x=yes \
--disable-gui \
--enable-multibyte \
--enable-cscope \
--disable-netbeans \
--enable-pythoninterp \
--disable-python3interp && make && sudo make install

systemd:
	@$(call installed,systemctl)
	@for REL in $(SERVICES); do sudo cp -f $$REL /$$REL; done

xsessions:
	@for REL in $(XSESSIONS); do sudo cp -f $$REL /$$REL; done

.deps:
	@$(call installed,git)
	@$(call installed,vim)
	@$(call installed,curl)
	@mkdir -p $(FONT_DIR) $(FONT_CONF_DIR) $(HOME)/.tmuxstart
