" General behavior

se nocompatible         " Use vim defaults, should be first entry

" Initialize bundles, `call pathogen#helptags()` to regenerate docs
" Infect Vim with pathogen >:)
runtime bundle/autoload/pathogen.vim
call pathogen#infect()

filetype plugin indent on       " enable detection, plugins and indenting in one step
syntax on                       " syntax highlighting

" Syntax highlighting

" Colorsheme
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

  let g:jellybeans_background_color_256="NONE"
endif

"colo jellybeans
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
se wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/*cache,*/logs,*/tmp,*.swp,*.jpg,*.png,*.xpm,*.gif,*.ico,*/vendor,web/css,web/js,web/bundles,*/target/*
se tags+=vendor.tags            " read vendor.tags also
se gdefault                     " the /g flag on :s substitutions by default

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

au BufRead,BufNewFile *.html.twig   setlocal filetype=htmldjango
au BufRead,BufNewFile *.json        setlocal filetype=javascript

" set tab width to 2
au BufRead,BufNewFile *.feature,*.css,*.scss,*.js,*.scala,*.yml,*.html,*.twig setlocal tabstop=2 shiftwidth=2 softtabstop=2

" strip trailing space on write
au BufWrite *.php,*.js,*.feature,*.json,*.scala,*.twig :call <SID>StripTrailingWhitespaces()

" create directory when writing
au BufWrite * :call <SID>MkdirsIfNotExists(expand('<afile>:h'))

" -------------MAPPINGS-------------
let mapleader=","       " Use the comma as leader
nmap <leader>2 :setlocal tabstop=2<cr>:setlocal shiftwidth=2<cr>:setlocal softtabstop=2<cr>
nmap <leader>4 :setlocal tabstop=4<cr>:setlocal shiftwidth=4<cr>:setlocal softtabstop=4<cr>

" Toggle line numbering
nnoremap <silent> <leader>nn :set nonumber!<cr>

" Toggle nowrap
nnoremap <silent> <leader>nw :set nowrap!<cr>

" Clear search highlight
nmap <silent> <leader>/ :let @/=""<cr>

" launch help in vert mode split to the right window
nmap <Leader>h <Esc>:botright vert help<cr>:vert resize 80<cr>:help<space>

" run write with root perms
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" strip tralling whitespaces
nmap <silent> <leader>cw :call <SID>StripTrailingWhitespaces()<cr>

" exclude vendor directory
nmap <leader>ev :se wig+=*/vendor<CR>:CommandTFlush<CR>
" include vendor directory
nmap <leader>iv :se wig-=*/vendor<CR>:CommandTFlush<CR>

" XClip, sometimes x register just does not work
vmap <leader>y :!xclip -f -sel clip<CR>
map <leader>p :-1r !xclip -o -sel clip<CR>

" CTAGS
" Rebuild tags
nmap <leader>ct :!ctags&<cr><cr>
" Jump to next tag match
nmap ]t :bd<cr>:tnext<cr>
" Jump to previous tag match
nmap [t :bd<cr>:tprevious<cr>
" testers
" ------------PLUGINS---------------

" ACK
nnoremap <leader>a :Ack

" PHP namespace
map <leader>u :call PhpInsertUse()<cr>

" Snipmate
let g:snips_author = 'Gediminas Morkevicius <gediminas.morkevicius@gmail.com>'

" Behat
let feature_filetype = 'behat'

"au FileType *.html,*.xhtml,*.xml,*.twig ru ftplugin/autoclose_tag.vim

" Command-T fix the arrow keys
if &term =~ "rxvt-unicode" || &term =~ "xterm"
  let g:CommandTCancelMap     = ['<ESC>', '<C-c>']
  let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<ESC>OB']
  let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<ESC>OA']
endif

" Delimit mate
let delimitMate_autoclose = 1
let delimitMate_matchpairs = "(:),[:],{:}"

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

" Source project settings
if filereadable('.vimrc.local')
  source .vimrc.local
endif
