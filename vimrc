" General behavior

se nocompatible         " Use vim defaults, should be first entry

" Initialize bundles, `call pathogen#helptags()` to regenerate docs
" Infect Vim with pathogen >:)
runtime bundle/autoload/pathogen.vim
call pathogen#infect()

syntax on
filetype plugin indent on       " enable detection, plugins and indenting in one step

let feature_filetype='behat'

" Syntax highlighting

" Colorsheme
se t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=0
let g:solarized_menu=0
let g:solarized_italic=0
se background=dark
"colo solarized
colo jellybeans

" General options
se autoread                     " Automatically read a file that has changed on disk
se clipboard=unnamedplus        " Use default X-System register for copy and paste
se history=200                  " Sets how many lines of history VIM has to remember
se undolevels=1000              " use many levels of undo
se noundofile                   " Don't keep a persistent undofile
se autoread                     " Automatically read a file that has changed on disk
se nobackup                     " Don't make a backup before overwriting a file.
se nowritebackup                " And again.
se noswapfile                   " Use an SCM instead of swap files
se nospell                      " Disable spell checking
se hidden
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
se textwidth=100
se colorcolumn=100
se formatoptions=qrn1

" -------------MAPPINGS-------------

let mapleader=","       " Use the comma as leader
nmap <leader>2 :setlocal tabstop=2<cr>:setlocal shiftwidth=2<cr>:setlocal softtabstop=2<cr>
nmap <leader>4 :setlocal tabstop=4<cr>:setlocal shiftwidth=4<cr>:setlocal softtabstop=4<cr>

" Toggle line numbering
nnoremap <silent> <leader>nn :set nonumber!<cr>

" Toggle nowrap
nnoremap <silent> <leader>nw :set nowrap!<cr>

" Clear search highlight
nmap <silent> <leader>ch :let @/=""<cr>

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

" ------------PLUGINS---------------

" ACK
nnoremap <leader>a :Ack

" PHP namespace
map <leader>u :call PhpInsertUse()<cr>

" Snipmate
let g:snips_author = 'Gediminas Morkevicius <gediminas.morkevicius@gmail.com>'

" Behat
let feature_filetype='behat'

" Command-T fix the arrow keys
if &term =~ "rxvt-unicode" || &term =~ "xterm"
  let g:CommandTCancelMap     = ['<ESC>', '<C-c>']
  let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<ESC>OB']
  let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<ESC>OA']
endif
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

" Lookup the file in the local directory and execute if readable
func! TryToReadFileInLocalDir(fname)
    let s=findfile(a:fname, expand("%:p:h") . ';')
    if filereadable(s)
        exe 'sou ' . s
    endif
endfunc

"  Clean code function
function! CleanCode()
  %retab          " Replace tabs with spaces
  %s/\r/\r/eg     " Turn DOS returns ^M into real returns
  %s=  *$==e      " Delete end of line blanks
  echo "Cleaned up this mess."
endfunction
nmap <leader>C :call CleanCode()<cr>

"
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > AUTOCMD
"|
"|

if has('autocmd')
    au BufWinEnter * set foldlevel=999999
    au FocusLost silent! :wa
    au FileType helpfile setlocal nonumber

    " Highlight cursor line
    au insertEnter * se cursorline
    au insertLeave * se nocursorline
    highlight cursorline term=underline cterm=underline ctermbg=0 guibg=#000000

    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm$"|endif|endif

    """""""""""""""""""""""""""""""""""""""
    " Define a group so we can delete them when this file is sourced, and we don't
    " end up with multiple autocmd entries if this file is sourced more than once.
    "
    " Tries to read .vimlocal settings based on the directory vim is executed. Helps with specific
    " settings based per project
    "
    " Source code is used from
    " <http://github.com/chazy/dirsettings/blob/master/plugin/dirsettings.vim>
    " Author - Tye Z. < z d r o @ y a h o o . c o m >
    augroup dirsettings
    au! dirsettings
    au dirsettings BufNew,BufNewFile,BufReadPost,VimEnter * call TryToReadFileInLocalDir('.vimlocal')

    """"""""""""""""""""""""""""""""""""""""
    "
    "  FILE TYPES
    "
    au BufRead,BufNewFile *.phps        setlocal filetype=php
    au BufRead,BufNewFile *.twig        setlocal filetype=django
    au BufRead,BufNewFile *.html.twig   setlocal filetype=htmldjango
    au BufRead,BufNewFile *.ejs         setlocal filetype=html
    au BufRead,BufNewFile *.json        setlocal filetype=javascript

    """"""""""""""""""""""""""""""""""""""""
    "
    "  TABS
    "
    au BufRead,BufNewFile *.class.php   setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.jade        setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.yml         setlocal tabstop=4 shiftwidth=4 softtabstop=4
    au BufRead,BufNewFile *.feature     setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.css         setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.scss        setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.js          setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.coffee      setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.go          setlocal tabstop=4 shiftwidth=4 softtabstop=4
    au BufRead,BufNewFile *.scala       setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.html        setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au BufRead,BufNewFile *.twig        setlocal tabstop=2 shiftwidth=2 softtabstop=2

    """"""""""""""""""""""""""""""""""""""""
    "
    "  COMMANDS
    "
    au BufWrite *.php,*.js,*.feature,*.json,*.go,*.scala,*.twig :call <SID>StripTrailingWhitespaces()
    au BufWrite * :call <SID>MkdirsIfNotExists(expand('<afile>:h'))
endif
