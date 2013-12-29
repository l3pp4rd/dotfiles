se nocompatible             " Use vim defaults, should be first entry

""" Load bundles
filetype off                " must be off for vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

""" Dependencies for bundles
Bundle 'gmarik/vundle'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

""" Appearance
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'

""" General
Bundle 'tpope/vim-commentary'
Bundle 'tlib'
Bundle 'Rename'
Bundle 'vim-addon-mw-utils'
Bundle 'mileszs/ack.vim'
Bundle 'Align'

""" Navigation
Bundle 'wincent/Command-T'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'LustyExplorer'
Bundle 'scrooloose/nerdtree'

""" Editing {
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'Raimondi/delimitMate'
Bundle 'ervandew/supertab'
Bundle 'SirVer/ultisnips'
Bundle 'mattn/emmet-vim'

""" Language specific
Bundle 'tpope/vim-markdown'
Bundle 'evanmiller/nginx-vim-syntax'
Bundle 'arnaud-lb/vim-php-namespace'
Bundle 'jnwhiteh/vim-golang'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'vim-scripts/a.vim'

filetype plugin indent on       " enable detection, plugins and indenting in one step
syntax on                       " syntax highlighting

" Syntax highlighting

se t_Co=16                      " number of colors supported
se background=dark

let g:solarized_termcolors=16
let g:solarized_termtrans=0
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast="low"
let g:solarized_visibility="high"

if $TERM =~ "-256color"
  se t_Co=256
  let g:solarized_termcolors=256
  let g:solarized_contrast="high"
  let g:solarized_termtrans=1
endif

colo solarized

" General options
se autoread                     " Automatically read a file that has changed on disk
se clipboard=unnamedplus        " Use default X-System register for copy and paste
se history=200                  " Sets how many lines of history VIM has to remember
se undolevels=1000              " Number of changes that can be undone
se undoreload=10000             " Number lines to save for undo on a buffer reload
se noundofile                   " Don't keep a persistent undofile
se autoread                     " Automatically read a file that has changed on disk
se nobackup                     " Don't make a backup before overwriting a file.
se nowritebackup                " And again.
se noswapfile                   " Use an SCM instead of swap files
se nospell                      " Disable spell checking
se hidden                       " Handle multiple buffers better.
se cmdheight=2                  " command bar height
se laststatus=2                 " always show status bar
se completeopt=menuone,preview  " autocompletion options
se ruler                        " show the cursor position all the time
se lazyredraw                   " turn on lazy redraw
se number                       " line numbers
se noshowcmd                    " don't display incomplete commands
se esckeys                      " Allow cursor keys in insert mode
se ttyfast                      " Optimize for fast terminal connections
se enc=utf-8 nobomb             " Use UTF-8 without BOM
se wildmenu                     " command line autocompletion
se wildmode=list:longest,full   " options for autocompletion
se wildignore+=*.o,*/.git/*,*/.hg/*,*/.svn/*,*/*cache,*/logs,*/tmp,*.swp,*.jpg,*.png,*.xpm,*.gif,*.ico,*/vendor,web/css,web/js,web/bundles,*/target/*
se wildignore+=*/tags,*/vendor.tags,*.phar
se tags+=vendor.tags            " read vendor.tags also
se gdefault                     " the /g flag on :s substitutions by default

" Enables the reading of .vimrc, .exrc and .gvimrc in the current directory. http://stackoverflow.com/a/7541744/186355
se exrc
se secure " disable unsafe commands in them

" Search related options

se smartcase                    " case-sensitive search if expression contains a capital letter.
se hlsearch                     " Highlight matches.
se ignorecase                   " Case-insensitive searching.
se incsearch                    " Highlight matches as you type.
se showmatch

" Indentation

se backspace=indent,eol,start   " Intuitive backspacing.
se list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:·
se autoindent                   " automatic indent new lines
se expandtab                    " expand tabs to spaces
se smartindent
se tabstop=4
se tildeop
se shiftwidth=4
se softtabstop=4

" scrolling
se scrolljump=3
se scrolloff=3

" wrapping linebreak
se wrap linebreak
se textwidth=120
se colorcolumn=120
se formatoptions=qrn1

" session options
set ssop-=options               " do not store global and local values in a session
set ssop-=folds                 " do not store folds

" Diff options
if &diff
  nmap <leader>do :diffget<space>
  nmap <leader>dp :diffput<space>
endif

set diffopt=filler,vertical
set diffopt+=iwhite

" Use perl regex style
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Highlight cursor line
au insertEnter * se cursorline
au insertLeave * se nocursorline
highlight cursorline term=underline cterm=underline ctermbg=0 guibg=#000000

" Restore cursor position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm$"|endif|endif

" ------ Actions on file types -----
au FileType helpfile setlocal nonumber
au FileType php set omnifunc=phpcomplete#CompletePHP " php autocompletion specifics

au BufRead,BufNewFile *.html.twig,*.html    setlocal filetype=htmldjango
au BufRead,BufNewFile *.js.twig,*.json      setlocal filetype=javascript

" set tab width to 2
au BufRead,BufNewFile *.feature,*.css,*.scss,*.js,*.scala,*.yml,*.html,*.twig,*.sql setlocal tabstop=2 shiftwidth=2 softtabstop=2

" strip trailing space on write
au BufWrite * :call <SID>StripTrailingWhitespaces()

" create directory when writing
au BufWrite * :call <SID>MkdirsIfNotExists(expand('<afile>:h'))

" -------------MAPPINGS-------------
let mapleader=","       " Use the comma as leader
nmap <leader>2 :setlocal tabstop=2<cr>:setlocal shiftwidth=2<cr>:setlocal softtabstop=2<cr>
nmap <leader>4 :setlocal tabstop=4<cr>:setlocal shiftwidth=4<cr>:setlocal softtabstop=4<cr>
nmap <leader>8 :setlocal tabstop=8<cr>:setlocal shiftwidth=8<cr>:setlocal softtabstop=8<cr>

" Toggle line numbering
nmap <silent> <leader>nn :set nonumber!<cr>

" Rename current file
nmap <leader>r :Rename

" Toggle nowrap
nmap <silent> <leader>nw :set nowrap!<cr>

" Clear search highlight
nmap <silent> <leader>/ :let @/=""<cr>

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>ss :%s#<C-r>=expand("<cword>")<cr>#

" Global quick search-replace
nmap <leader>sr :!ack -l <C-r>=expand("<cword>")<cr> \|
      \ xargs perl -pi -E 's/<C-r>=expand("<cword>")<cr>//g'<left><left><left>

" run write with root perms
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" strip tralling whitespaces
nmap <silent> <leader>cw :call <SID>StripTrailingWhitespaces()<cr>

" Select all text
nmap <C-a> ggVG$

" delete without yanking by default
nnoremap d "_d
vnoremap d "_d
" yank only when <leader> is used
nnoremap <leader>d "+d
vnoremap <leader>d "+d

" replace currently selected text with default register, without yanking it
vnoremap p "_dP
" replace with yanking, only when <leader> is used
vnoremap <leader>p "+dP

" CTAGS - Rebuild tags
nmap <leader>ct :!ctags&<cr><cr>

" save a session
nmap <leader>s :mksession!

" go to previous most recent file opened
nmap <leader>m :e#<cr>

" open or create a file in currently opened file directory
nmap <leader>c :e %:p:h/

" jump to a line which contains word under the cursor
nmap <leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<cr>

" ------------PLUGINS---------------

" Airline
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Nerd tree
nmap <Leader>lt :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
nmap <Leader>ld :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>

" ACK, used for silver search aka ag
let g:ackprg = 'ag --nogroup --nocolor --column'
nmap <leader>a :Ack

" PHP namespace
map <leader>u :call PhpInsertUse()<cr>

" UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsListSnippets = '<c-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories = ["snippets"]

" Command-T fix the arrow keys
if &term =~ "st" || &term =~ "screen"
  let g:CommandTCancelMap     = ['<Esc>', '<C-c>']
  let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<ESC>OB']
  let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<ESC>OA']
endif
" exclude vendor directory
nmap <leader>ev :se wig+=*/vendor<CR>:CommandTFlush<CR>
" include vendor directory
nmap <leader>iv :se wig-=*/vendor<CR>:CommandTFlush<CR>
nmap <leader><leader>r :CommandTFlush<CR>

" Delimit mate
let delimitMate_autoclose = 1
let delimitMate_matchpairs = "(:),[:],{:}"

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons=1
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['scala'] }
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Alternate
nmap <leader>h :A<cr>

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
set pumheight=15
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Zencoding - aka emmet-vim
let g:user_emmet_leader_key = '<c-l>'

" -------------FUNCTIONS-------------
function! <SID>StripTrailingWhitespaces()
    " Preparation save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! <SID>MkdirsIfNotExists(directory)
    if(!isdirectory(a:directory))
        call system('mkdir -p '.shellescape(a:directory))
    endif
endfunction

"  Clean code function
function! CleanCode()
  %retab          " Replace tabs with spaces
  %s/\r/\r/eg     " Turn DOS returns ^M into real returns
  %s=  *$==e      " Delete end of line blanks
  echo "Cleaned"
endfunction
nmap <leader>C :call CleanCode()<cr>

