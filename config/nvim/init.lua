-- Migrated from ~/.dotfiles/vimrc, sections kept in the same order.
-- Plugins are managed by the builtin vim.pack, revisions are pinned in
-- nvim-pack-lock.json next to this file.

local map = vim.keymap.set
local au = vim.api.nvim_create_autocmd
local group = function(name) return vim.api.nvim_create_augroup(name, {}) end

vim.g.mapleader = ','   -- Use the comma as leader, must be set before any <leader> mapping

--
--+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--|
--|  > PLUGINS
--|
--|
-- plugin options which must be set before the plugin loads
vim.g.solarized_contrast = 'low'
vim.g.solarized_visibility = 'high'
if vim.env.TERM:find('-256color', 1, true) then
  vim.g.solarized_termcolors = 256
  vim.g.solarized_contrast = 'high'
  vim.g.solarized_termtrans = 1
end

-- fzf.vim needs the fzf binary, same as { 'do': { -> fzf#install() } } in vim-plug
au('PackChanged', {
  group = group('PACK_HOOKS'),
  callback = function(ev)
    if ev.data.spec.name == 'fzf' and ev.data.kind ~= 'delete' then
      vim.system({ './install', '--bin' }, { cwd = ev.data.path }):wait()
    end
  end,
})

local gh = function(repo) return 'https://github.com/' .. repo end
vim.pack.add({
  ---- Base
  gh('vim-scripts/gitignore'),            -- use gitignore for wildignore
  gh('tpope/vim-dispatch'),               -- asynchronous build and test dispatcher
  gh('tpope/vim-eunuch'),

  ---- Appearance
  gh('altercation/vim-colors-solarized'), -- solorized color scheme
  gh('vim-airline/vim-airline'),          -- status bar without interpreter dependencies
  gh('vim-airline/vim-airline-themes'),   -- themes for status bar

  ---- Navigation
  gh('preservim/nerdtree'),
  gh('junegunn/fzf'),
  gh('junegunn/fzf.vim'),
  gh('easymotion/vim-easymotion'),

  ---- Editing
  gh('terryma/vim-multiple-cursors'),
  gh('PeterRincker/vim-argumentative'),
  gh('reedes/vim-pencil'),
  gh('tpope/vim-surround'),
  gh('tpope/vim-fugitive'),
  gh('tpope/vim-repeat'),
  gh('Raimondi/delimitMate'),

  ---- Language specific
  gh('fatih/vim-go'),
  gh('mitsuhiko/vim-jinja'),
}, { confirm = false })

-- Not carried over, neovim has these builtin:
--   vim-sensible (defaults), matchit, vim-commentary (gc/gcc),
--   vim-less, vim-markdown, vim-toml, SQLComplete.vim (runtime files),
--   gundo.vim (:Undotree), YouCompleteMe (see COMPLETION below)
vim.cmd.packadd('nvim.undotree')

--
--+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--|
--|  > SYNTAX HIGHLIGHTING
--|
--|
vim.o.background = 'dark'
-- this solarized only defines 256 color terminal highlights, as used in vim
vim.o.termguicolors = false

-- loads color scheme if available
pcall(vim.cmd.colorscheme, 'solarized')

--
--+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--|
--|  > GENERAL VIM SETTINGS
--|
--|
-- neovim defaults already cover: noundofile, nobackup, nospell, hlsearch,
-- hidden, foldmethod=manual, showcmd
vim.o.clipboard = 'unnamedplus'   -- Use default X-System register for copy and paste
vim.o.writebackup = false         -- Don't make a backup before overwriting a file.
vim.o.swapfile = false            -- Use an SCM instead of swap files
vim.o.number = true               -- line numbers

vim.opt.wildignore:append({ '*/.git/*', '*/.hg/*', '*/.svn/*' })                                    -- ignore VCS
vim.opt.wildignore:append({ '*.swp', '*.jpg', '*.jpeg', '*.bmp', '*.png', '*.xpm', '*.gif', '*.ico' }) -- ignore media

-- Enables the reading of .nvim.lua, .nvimrc and .exrc in the current
-- directory, neovim asks to trust the file first. See :help 'exrc'
vim.o.exrc = true

-- Indentation
vim.o.expandtab = true            -- expand tabs to spaces
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- wrapping linebreak
vim.o.wrap = true
vim.o.linebreak = true
vim.o.colorcolumn = '120'

-- Highlight whitespace, see FILE_TYPE_DIFFERENCES for GO files
vim.o.list = true
vim.o.listchars = 'tab:»·,trail:·,extends:>,precedes:<,nbsp:·'

-- Diff options
if vim.o.diff then
  map('n', '<leader>do', ':diffget<space>')
  map('n', '<leader>dp', ':diffput<space>')
end

vim.opt.diffopt:append({ 'vertical', 'iwhite' })

-- Use perl regex style
map({ 'n', 'v' }, '/', '/\\v')
map({ 'n', 'v' }, '?', '?\\v')

--
--+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--|
--|  > COMPLETION
--|
--|
-- Replaces YouCompleteMe: completion menu as you type, fed by buffer words
-- and omnifunc. Omnifunc comes from vim-go (gopls) for GO and from the
-- builtin LSP client for the servers below.
vim.o.autocomplete = true
vim.opt.complete:remove('t')      -- do not scan tag files, slow anyways
vim.opt.complete:append('o')
vim.opt.completeopt:append('noselect')

vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
})
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml' },
})
for _, name in ipairs({ 'clangd', 'rust_analyzer' }) do
  if vim.fn.executable(vim.lsp.config[name].cmd[1]) == 1 then
    vim.lsp.enable(name)
  end
end

--
--+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--|
--|  > MAPPINGS
--|
--|
-- Reselect visual block after indent
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Toggle line numbering
map('n', '<leader>n', ':set nonumber!<cr>', { silent = true })

-- Force reload all buffers
map('n', '<leader>r', ':bufdo e!')

-- Run write with root perms, neovim can not prompt for password in ":w !sudo"
map('c', 'w!!', 'SudoWrite<cr>')

-- Select all text
map('n', '<C-a>', 'ggVG$')

-- go to previous most recent file opened
map('n', '<leader>m', ':e#<cr>')

-- replace all tabs to spaces, windows new lines to normal
map('n', '<leader>c', ':call CleanCode()<cr>')

-- map leader + x to execute selected text through shell
map('x', '<leader>x', "<esc>:'<,'>:w !sh<CR>")

--
--+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--|
--|  > PLUGIN SETTINGS
--|
--|
map('n', '<leader>b', ':Buffers<cr>')
map('n', '<leader>l', ':Files<cr>')

-- easymation, I do not use f
map('', 'f', '<Plug>(easymotion-prefix)')

-- Airline
vim.g.airline_theme = 'solarized'
vim.g.airline_powerline_fonts = 1

-- Nerd tree
map('n', '<Leader>.', ':let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>')

-- Delimit mate
vim.g.delimitMate_autoclose = 1
vim.g.delimitMate_matchpairs = '(:),[:],{:}'

-- Fugitive
map('n', '<leader>gs', ':Git<CR>', { silent = true })
map('n', '<leader>gd', ':Gdiffsplit<CR>', { silent = true })
map('n', '<leader>gc', ':Git commit<CR>', { silent = true })
map('n', '<leader>gb', ':Git blame<CR>', { silent = true })
map('n', '<leader>gl', ':Gclog<CR>', { silent = true })
map('n', '<leader>gp', ':Git push<CR>', { silent = true })
map('n', '<leader>gw', ':Gwrite<CR>', { silent = true })
map('n', '<leader>gr', ':GRemove<CR>', { silent = true })

-- ViM GO
vim.g.go_fmt_command = 'goimports'
vim.g.go_addtags_transform = 'camelcase' -- or snakecase for underscore
vim.g.go_def_mode = 'gopls'
vim.g.go_info_mode = 'gopls'

-- Undotree - handles undo branches
map('n', '<F10>', ':Undotree<cr>')

-- Argumentative
map('n', '[;', '<Plug>Argumentative_Prev')
map('n', '];', '<Plug>Argumentative_Next')
map('x', '[;', '<Plug>Argumentative_XPrev')
map('x', '];', '<Plug>Argumentative_XNext')
map('n', '<;', '<Plug>Argumentative_MoveLeft')
map('n', '>;', '<Plug>Argumentative_MoveRight')
map('x', 'i;', '<Plug>Argumentative_InnerTextObject')
map('x', 'a;', '<Plug>Argumentative_OuterTextObject')
map('o', 'i;', '<Plug>Argumentative_OpPendingInnerTextObject')
map('o', 'a;', '<Plug>Argumentative_OpPendingOuterTextObject')

--
--+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--|
--|  > FUNCTIONS
--|
--|
local function strip_trailing_whitespaces()
  -- keeps search history and cursor position
  local view = vim.fn.winsaveview()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.fn.winrestview(view)
end

-- Clean code function
vim.cmd([[
function! CleanCode()
  %retab          " Replace tabs with spaces
  %s/\r/\r/eg     " Turn DOS returns ^M into real returns
  %s=  *$==e      " Delete end of line blanks
  echo "Cleaned"
endfunction
]])

--
--+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--|
--|  > AUTOCMD
--|
--|
local cursor = group('CURSOR')
au('FocusLost', { group = cursor, command = 'silent! wa' })
-- Highlight cursor line
au('InsertEnter', { group = cursor, command = 'set cursorline' })
au('InsertLeave', { group = cursor, command = 'set nocursorline' })
vim.cmd('highlight CursorLine cterm=underline ctermbg=0 guibg=#000000')

-- Restore cursor position
au('BufReadPost', {
  group = cursor,
  callback = function()
    local line = vim.fn.line([['"]])
    if line > 0 and line <= vim.fn.line('$') then
      vim.cmd([[normal! g`"]])
    end
  end,
})

local ft = group('FILE_TYPE_DIFFERENCES')
au('FileType', { group = ft, pattern = 'help', command = 'setlocal nonumber' })
au('FileType', { group = ft, pattern = 'go', command = 'setlocal nolist' })

au({ 'BufRead', 'BufNewFile' }, { group = ft, pattern = '*.md', command = 'setlocal spell spelllang=en_us' })
au({ 'BufRead', 'BufNewFile' }, { group = ft, pattern = { '*.twig', '*.html', '*.htm' }, command = 'setlocal filetype=htmljinja' })

-- set tab width to 4
au({ 'BufRead', 'BufNewFile' }, { group = ft, pattern = { '*.java', '*.php', '*.go', '*.md' }, command = 'setlocal ts=4 sw=4 sts=4' })

local comments = group('COMMENTS')
au({ 'BufRead', 'BufNewFile' }, { group = comments, pattern = '*.twig', command = [[setlocal commentstring={#\ %s\ #}]] })
au({ 'BufRead', 'BufNewFile' }, { group = comments, pattern = '*.php', command = [[setlocal commentstring=//\ %s]] })

local general = group('GENERAL')
-- strip trailing space on write, go runs FMT anyways
au('BufWritePre', { group = general, callback = strip_trailing_whitespaces })
-- create parent directory when writing new file
au('BufWritePre', {
  group = general,
  callback = function(ev)
    if not ev.match:find('^%w+://') then
      vim.fn.mkdir(vim.fn.fnamemodify(ev.match, ':p:h'), 'p')
    end
  end,
})

au('FileType', {
  group = group('GOLANG'),
  pattern = 'go',
  callback = function()
    local gomap = function(lhs, rhs) map('n', lhs, rhs, { buffer = true }) end
    gomap('<Leader>r', '<Plug>(go-rename)')
    gomap('<Leader>i', '<Plug>(go-implements)')
    gomap('<Leader>d', '<Plug>(go-def)')
    gomap('<Leader>c', '<Plug>(go-callers)')
    gomap('<Leader>x', ':GoMetaLinter<cr>')
    gomap('<Leader>t', ':GoAddTags<cr>')
  end,
})

au('FileType', {
  group = group('PENCIL'),
  pattern = { 'markdown', 'mkd', 'text' },
  command = 'call pencil#init()',
})
