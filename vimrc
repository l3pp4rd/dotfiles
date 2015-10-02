se nocompatible                         " use vim defaults, should be first entry

call plug#begin('~/.vim/bundle')
""" Base
Plug 'tpope/vim-sensible'               " sensible defaults for ViM
Plug 'vim-scripts/gitignore'            " use gitignore for wildignore

""" Appearance
Plug 'altercation/vim-colors-solarized' " solorized color scheme
Plug 'bling/vim-airline'

""" Navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'kien/ctrlp.vim'

""" Editing
Plug 'tmhedberg/matchit'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'Raimondi/delimitMate'
let hasUltisnips = 0
if has('python') || has('python3')
  let hasUltisnips = 1
  Plug 'SirVer/ultisnips'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
  Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
else
  Plug 'ervandew/supertab'
endif

""" Language specific
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'evanmiller/nginx-vim-syntax'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'mitsuhiko/vim-jinja'
" Plug 'mxw/vim-jsx', { 'for': 'jsx' }
Plug 'vim-scripts/sql.vim--Stinson', { 'for': 'sql' }
call plug#end()

"
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > SYNTAX HIGHLIGHTING
"|
"|
set background=dark

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
se clipboard=unnamedplus        " Use default X-System register for copy and paste
se noundofile                   " Don't keep a persistent undofile
se nobackup                     " Don't make a backup before overwriting a file.
se nowritebackup                " And again.
se noswapfile                   " Use an SCM instead of swap files
se nospell                      " Disable spell checking
se number                       " line numbers
se hlsearch                     " Highlight matches.
se hidden                       " Handle multiple buffers better.
se complete-=i                  " do not scan all included files
se complete-=t                  " do not scan tag files, slow anyways
se completeopt-=preview         " disable scratch preview window
se foldmethod=manual            " increases the autocompletion speed

se wildignore+=*/.git/*,*/.hg/*,*/.svn/*                          " ignore VCS
se wildignore+=*.swp,*.jpg,*.jpeg,*.bmp,*.png,*.xpm,*.gif,*.ico   " ignore media

se exrc   " Enables the reading of .vimrc, .exrc and .gvimrc in the current directory. http://stackoverflow.com/a/7541744/186355
se secure " disable unsafe commands in them

" Indentation
se expandtab                                                    " expand tabs to spaces
se tabstop=2
se shiftwidth=2
se softtabstop=2

" wrapping linebreak
se wrap linebreak
se colorcolumn=120

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

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Toggle line numbering
nmap <silent> <leader>n :set nonumber!<cr>

" Create a new file, suggest current directory of the file edited
nmap <leader>c :e <c-r>=expand('%:h')<cr>/

" Force reload all buffers
nmap <leader>r :bufdo e!

" Run write with root perms
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" Select all text
nmap <C-a> ggVG$

" go to previous most recent file opened
nmap <leader>m :e#<cr>

" replace all tabs to spaces, windows new lines to normal
nmap <leader>C :call CleanCode()<cr>

"
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > PLUGINS
"|
"|
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>l :CtrlP<cr>

let g:ctrlp_custom_ignore = '\v[\/](vendor|\.git|\.hg|\.svn|node_modules|dist)$'

" Airline
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1

" Nerd tree
nmap <Leader>. :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>

" UltiSnips
let g:UltiSnipsSnippetDirectories = ["ultisnips"]
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Delimit mate
let delimitMate_autoclose = 1
let delimitMate_matchpairs = "(:),[:],{:}"

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons=1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" npm install -g jsxhint
let g:syntastic_javascript_checkers = ['jsxhint']

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
let g:user_emmet_leader_key = '<c-l>' " CTRL + L + <leader>
let g:user_emmet_install_global = 0

" ViM GO
let g:go_fmt_command = "goimports"

" Gundo - handles undo branches
nmap <F10> :GundoToggle<cr>
let g:gundo_close_on_revert = 1

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
if has('autocmd')
  augroup CURSOR
    autocmd!
    au FocusLost silent! :wa
    " Highlight cursor line
    au insertEnter * se cursorline
    au insertLeave * se nocursorline
    highlight cursorline term=underline cterm=underline ctermbg=0 guibg=#000000

    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm$"|endif|endif
  augroup END

  augroup FILE_TYPE_DIFFERENCES
    autocmd!
    au FileType helpfile setlocal nonumber

    au BufRead,BufNewFile *.json setlocal filetype=javascript
    au BufRead,BufNewFile *.md setlocal spell spelllang=en_us
    au BufRead,BufNewFile *.twig,*.html,*.htm setlocal filetype=htmljinja

    " set tab width to 4
    au BufRead,BufNewFile *.java,*.php,*.go,*.md setlocal ts=4 sw=4 sts=4

    " Highlight whitespace for non GO files
    au BufRead,BufNewFile * if index(['go'], &ft) < 0 | setlocal list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:·
  augroup END

  augroup COMMENTS
    autocmd!
    au BufRead,BufNewFile *.twig setlocal commentstring=\{#\ %s\ #\}
    au BufRead,BufNewFile *.php setlocal commentstring=//\ %s
  augroup END

  augroup PLUGINS
    autocmd!
    " If you prefer the Omni-Completion tip window to close when a selection is
    " made, these lines close it on movement in insert mode or when leaving
    " insert mode
    au CursorMovedI * if pumvisible() == 0|pclose|endif
    au InsertLeave * if pumvisible() == 0|pclose|endif

    if hasUltisnips
      au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
    endif
    au FileType html,css,htmljinja EmmetInstall
  augroup END

  augroup GENERAL
    autocmd!
    " strip trailing space on write, go runs FMT anyways
    au BufWrite * :call <SID>StripTrailingWhitespaces()
    " create parent directory when writing new file
    au BufWrite * :call <SID>MkdirsIfNotExists(expand('<afile>:h'))
    " when buffer activated reread
    " au FocusGained,BufEnter * :silent! !
    " when focus lost save
    " au FocusLost,WinLeave * :silent! w
  augroup END
endif
