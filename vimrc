se nocompatible             " Use vim defaults, should be first entry

""" Load bundles
filetype off                " must be off for vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

""" Dependencies for bundles
Bundle 'gmarik/vundle'

""" Appearance
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'

""" General
Bundle 'tpope/vim-commentary'
Bundle 'tlib'
Bundle 'Rename'
Bundle 'vim-addon-mw-utils'
Bundle 'mileszs/ack.vim'

""" Navigation
Bundle 'Lokaltog/vim-easymotion'
if has('ruby')
    Bundle 'LustyExplorer'
endif
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'

""" Editing {
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'Raimondi/delimitMate'
Bundle 'ervandew/supertab'
if has('python') || has('python3')
    Bundle 'SirVer/ultisnips'
endif
Bundle 'mattn/emmet-vim'
Bundle 'Tabular'

""" Language specific
Bundle 'tpope/vim-markdown'
Bundle 'evanmiller/nginx-vim-syntax'
Bundle 'arnaud-lb/vim-php-namespace'
Plugin 'fatih/vim-go'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'vim-scripts/a.vim'
Bundle 'Herzult/phpspec-vim'

"
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > SYNTAX HIGHLIGHTING
"|
"|
syntax on

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

" loads color scheme if available
try
    colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
    " deal with it
endtry


"
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > GENERAL VIM SETTINGS
"|
"|
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
" ignore in most cases
se wildignore+=*.o,*/.git/*,*/.hg/*,*/.svn/*,*/*cache,*/logs,*/tmp,*.swp,*.jpg
se wildignore+=*.png,*.xpm,*.gif,*.ico,*/vendor,web/dist,web/bundles,*/target/*
se wildignore+=*/tags,*/vendor.tags,*.phar,*/node_modules
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
se backspace=indent,eol,start                                   " Intuitive backspacing.
"se list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:·    " Highlight trailing spaces and tabs
se autoindent                                                   " automatic indent new lines
se expandtab                                                    " expand tabs to spaces
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

"
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > MAPPINGS
"|
"|
let mapleader=","       " Use the comma as leader
nmap <leader>2 :setlocal tabstop=2<cr>:setlocal shiftwidth=2<cr>:setlocal softtabstop=2<cr>
nmap <leader>4 :setlocal tabstop=4<cr>:setlocal shiftwidth=4<cr>:setlocal softtabstop=4<cr>
nmap <leader>8 :setlocal tabstop=8<cr>:setlocal shiftwidth=8<cr>:setlocal softtabstop=8<cr>
nmap <leader>16 :setlocal tabstop=16<cr>:setlocal shiftwidth=16<cr>:setlocal softtabstop=16<cr>

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Toggle line numbering
nmap <silent> <leader>nn :set nonumber!<cr>

" Rename current file, sugget the same name
nmap <leader>r :Rename <c-r>=@%<cr>

" Create a new file, suggest current directory of the file edited
nmap <leader>c :e <c-r>=expand('%:h')<cr>/

" Toggle nowrap
nmap <silent> <leader>nw :set nowrap!<cr>

" Clear search highlight
nmap <silent> <leader>/ :let @/=""<cr>

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>ss :%s#<C-r>=expand("<cword>")<cr>#

" Global quick search-replace
nmap <leader>sr :!ack -l <C-r>=expand("<cword>")<cr> \|
      \ xargs perl -pi -E 's/<C-r>=expand("<cword>")<cr>//g'<left><left><left>

" Run write with root perms
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" Select all text
nmap <C-a> ggVG$

" YANKING BEHAVIOR

" I found my self the default vim behavior less useful in day to day work
" when it yanks removed text into the default registry. So the default registry
" will be used only in case if command was followed by <leader>.
"
" It might be useful to use a different registry in that case, while maintaining default behavior.

" delete without yanking by default
nnoremap d "_d
vnoremap d "_d
" yank only when <leader> is used
nnoremap <leader>d "+d
vnoremap <leader>d "+d
" remove character without yanking
nnoremap x "_x
vnoremap x "_x
" yank only when <leader> is used
nnoremap <leader>x "+x
vnoremap <leader>x "+x
" replace character without yanking
nnoremap c "_c
vnoremap c "_c
" yank only when <leader> is used
" nnoremap <leader>c "+c
" vnoremap <leader>c "+c
" replace currently selected text with default register, without yanking it
vnoremap p "_dP
" replace with yanking, only when <leader> is used
vnoremap <leader>p "+dP

" save a session
nmap <leader>s :mksession!

" go to previous most recent file opened
nmap <leader>m :e#<cr>

" replace all tabs to spaces, windows new lines to normal
nmap <leader>C :call CleanCode()<cr>
nmap <leader>C$ :call StripTrailingWhitespaces()<cr>
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > PLUGINS
"|
"|

" CtrlP
nmap <leader>lp :CtrlP<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>t :CtrlP<cr>

let g:ctrlp_custom_ignore = '\v[\/](vendor|\.git|\.hg|\.svn)$'
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

func! MyCtrlPMappings()
    " remove from buffer
    nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunc

" Easymotion
let g:EasyMotion_leader_key='t' " always associated 't' AS 'to'

" Tabular
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" Airline
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1

" Nerd tree
nmap <Leader>lt :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
nmap <Leader>lT :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>

" ACK, used for silver search aka ag
if executable('ag')
    set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
    set grepformat=%f:%l:%c:%m
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif
nmap <leader>a :Ack

" PHP namespace
nmap <leader>u :call PhpInsertUse()<cr>
nmap <leader>e :call PhpExpandClass()<cr>

" UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsListSnippets = '<c-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories = ["ultisnips"]

" Delimit mate
let delimitMate_autoclose = 1
let delimitMate_matchpairs = "(:),[:],{:}"

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons=1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Alternate
nmap <leader>h :A<cr>

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
set pumheight=15
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Fugitive
nmap <silent> <leader>gs :Gstatus<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>gb :Gblame<CR>
nmap <silent> <leader>gl :Glog<CR>
nmap <silent> <leader>gp :Git push<CR>
nmap <silent> <leader>gw :Gwrite<CR>
nmap <silent> <leader>gr :Gremove<CR>

" Zencoding - aka emmet-vim
let g:user_emmet_leader_key = '<c-l>'

"
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > FUNCTIONS
"|
"|
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

" delete from buffer, based on current line (used for ctrlp)
func! s:DeleteBuffer()
    let line = getline('.')
    let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
        \ : fnamemodify(line[2:], ':p')
    exec "bd" bufid
    exec "norm \<F5>"
endfunc

"  Clean code function
function! CleanCode()
  %retab          " Replace tabs with spaces
  %s/\r/\r/eg     " Turn DOS returns ^M into real returns
  %s=  *$==e      " Delete end of line blanks
  echo "Cleaned"
endfunction

"
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > AUTOCMD
"|
"|
filetype plugin indent on       " enable detection, plugins and indenting in one step

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=500
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

if has('autocmd')
    augroup Cursor
        autocmd!
        au FocusLost silent! :wa
        " Highlight cursor line
        au insertEnter * se cursorline
        au insertLeave * se nocursorline
        highlight cursorline term=underline cterm=underline ctermbg=0 guibg=#000000

        " Restore cursor position
        au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm$"|endif|endif
    augroup END

    augroup FileTypes
        autocmd!
        au FileType helpfile setlocal nonumber
        " php autocompletion sucks with ctags
        "au FileType php set omnifunc=phpcomplete#CompletePHP " php autocompletion specifics

        au BufRead,BufNewFile *.html.twig,*.html    setlocal filetype=htmldjango
        au BufRead,BufNewFile *.js.twig,*.json      setlocal filetype=javascript
        au BufRead,BufNewFile *.md                  setlocal spell spelllang=en_us

        " set tab width to 2
        au BufRead,BufNewFile *.feature,*.css,*.scss,*.js       setlocal ts=2 sw=2 sts=2
        au BufRead,BufNewFile *.scala,*.yml,*.html,*.twig,*.sql setlocal ts=2 sw=2 sts=2
    augroup END

    augroup OnSave
        autocmd!
        " strip trailing space on write
        au BufWrite * :call <SID>StripTrailingWhitespaces()

        " create directory when writing
        au BufWrite * :call <SID>MkdirsIfNotExists(expand('<afile>:h'))
    augroup END

endif

