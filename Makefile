.PHONY: install dotfiles fonts bins tmuxstart vim nvim systemd tools

FONT_CONF_DIR := $(HOME)/.config/fontconfig/conf.d
FONT_DIR := $(HOME)/.fonts
DIR := $(shell pwd)
BIN_DIR := $(HOME)/.local/bin

BINS := $(shell find local/bin -executable -type f)
SYSTEMD_USER_DIR := $(HOME)/.config/systemd/user
SERVICES := $(shell find config/systemd/user -name '*.service')

# make a symlink to home directory for given dotfile
define dot =
ln -sfn $(DIR)/$(1) $(HOME)/.$(1)
endef

define installed =
command -v $(1) >/dev/null 2>&1 || (echo "$(1) needs to be installed and available in $$PATH"; exit 1)
endef

install: .deps fonts dotfiles bins tmuxstart
	@git submodule update --init
	vim +PlugInstall +qall
	vim +GoUpdateBinaries +qall
	nvim --headless +qall

update: .deps fonts tmuxstart
	@git submodule update --init
	curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	git submodule foreach git pull origin master
	vim +PlugInstall +PlugUpdate +GoUpdateBinaries +qall
	nvim --headless "+lua vim.pack.update(nil, { force = true })" +qall

# WARNING: will overwrite these dotfiles in $HOME
dotfiles: .deps
	@$(call dot,vim)
	@$(call dot,vimrc)
	@$(call dot,alacritty.toml)
	@$(call dot,xinitrc)
	@$(call dot,xmodmap)
	@$(call dot,zshrc)
	@$(call dot,tmux.conf)
	@$(call dot,mplayer)
	@$(call dot,gitignore)
	@$(call dot,gitconfig)
	@$(call dot,config/ranger)
	@$(call dot,config/nvim)
	@$(call dot,config/solarized)

tmuxstart: .deps
	curl -L https://raw.githubusercontent.com/treyhunner/tmuxstart/master/tmuxstart > $(BIN_DIR)/tmuxstart
	chmod +x $(BIN_DIR)/tmuxstart
	cp tmuxstart/dotfiles $(HOME)/.tmuxstart/dotfiles

bins:
	@mkdir -p $(BIN_DIR)
	@cp -f $(BINS) $(BIN_DIR)/

POWERLINE := https://raw.github.com/Lokaltog/powerline

fonts: .deps
	@curl -L $(POWERLINE)/develop/font/10-powerline-symbols.conf > $(FONT_CONF_DIR)/10-powerline-symbols.conf
	@curl -L $(POWERLINE)/develop/font/PowerlineSymbols.otf > $(FONT_DIR)/PowerlineSymbols.otf
	@curl -L $(POWERLINE)-fonts/master/Inconsolata/Inconsolata%20for%20Powerline.otf > $(FONT_DIR)/Inconsolata.otf
	@fc-cache -vf $(FONT_DIR)

tools: bins
	@$(call installed,go)
	@go-get-cmd github.com/davecheney/httpstat
	@go-get-cmd github.com/gongo/9t
	@go-get-cmd github.com/DATA-DOG/goup
	@go-get-cmd github.com/vektorlab/slackcat
	@curl -Lo $(GOPATH)/bin/ctop https://github.com/bcicen/ctop/releases/download/v0.5.1/ctop-0.5.1-linux-amd64
	@chmod +x $(GOPATH)/bin/ctop


vim:
	@$(call installed,git)
	@rm -rf /tmp/vim_src
	@mkdir -p /tmp/vim_src
	@curl -s -L https://github.com/vim/vim/tarball/master | tar -C /tmp/vim_src -zx --strip-components 1
	@cd /tmp/vim_src && ./configure \
--prefix=$(HOME)/.local \
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
--enable-python3interp && make && make install

NVIM_DIR := $(HOME)/.local/opt/nvim

# official release build, lives next to vim
nvim:
	@$(call installed,curl)
	@rm -rf $(NVIM_DIR)
	@mkdir -p $(NVIM_DIR) $(BIN_DIR)
	@curl -fsSL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz | tar -C $(NVIM_DIR) -zx --strip-components 1
	@ln -sfn $(NVIM_DIR)/bin/nvim $(BIN_DIR)/nvim

systemd: bins
	@$(call installed,systemctl)
	@$(call installed,xss-lock)
	@$(call installed,i3lock)
	@mkdir -p $(SYSTEMD_USER_DIR)
	@cp -f $(SERVICES) $(SYSTEMD_USER_DIR)/
	@systemctl --user daemon-reload
	@systemctl --user enable --now $(notdir $(SERVICES))

.deps:
	@$(call installed,git)
	@$(call installed,vim)
	@$(call installed,nvim)
	@$(call installed,curl)
	@mkdir -p $(FONT_DIR) $(FONT_CONF_DIR) $(HOME)/.tmuxstart $(BIN_DIR)
