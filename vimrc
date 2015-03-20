call pathogen#infect()
let mapleader=","
set nocompatible
set viminfo='1000,f1,:1000,/1000
set history=1000
"------  Visual Options  ------
syntax on
colorscheme Tomorrow-Night 
set enc=utf-8
set fenc=utf-8
set number
set nowrap
set vb
set ruler
set completeopt=menu
set mousemodel=popup
set backspace=2
set nocompatible
set cursorline
set statusline=%<%f\ %h%m%r%=%{fugitive#statusline()}\ \ %-14.(%l,%c%V%)\ %P
let g:buftabs_only_basename=1
let g:buftabs_marker_modified = "+"
" Toggle whitespace visibility with ,s
nmap <Leader>s :set list!<CR>
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×,eol:¬
" ,L = Toggle line numbers
map <Leader>L :set invnumber<CR>

set showcmd

"------  Generic Behavior  ------
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set pastetoggle=<f5>

set hidden
filetype indent on
filetype plugin on
set wildmenu
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,node_modules/*

"allow deletion of previously entered data in insert mode
set backspace=indent,eol,start

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" ,v = Paste
map <Leader>v "+gP

" ,c = Copy
map <Leader>c "+y

" Accidentally pressing Shift K will no longer open stupid man entry
noremap K <nop>

" Edit and Reload .vimrc files
nmap <silent> <Leader>ev :e $MYVIMRC<CR>
nmap <silent> <Leader>es :so $MYVIMRC<CR>

" When pressing ,cd switch to the directory of the open buffer
map ,cd :cd %:p:h<CR>

" Wtf is Ex Mode anyways?
nnoremap Q <nop>

" ------ Airline ----
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts=1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_paste=1
let g:airline_detect_modified=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" --- Backup and swap dirs ---
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
set undodir=~/.vim/undo/

"------  Text Navigation  ------
" Prevent cursor from moving to beginning of line when switching buffers
set nostartofline
" Keep the cursor in place while joining lines
nnoremap J mzJ`z
" H = Home, L = End
"noremap H ^
"noremap L $
"vnoremap L g_

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
"
if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.php :call DeleteTrailingWS()

"------  Window Navigation  ------
" ,hljk = Move between windows
nnoremap <Leader>h <C-w>h
nnoremap <Leader>l <C-w>l
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k

"------  Buffer Navigation  ------
" Ctrl Left/h & Right/l cycle between buffers
noremap <silent> <C-left> :bprev<CR>
noremap <silent> <C-h> :bprev<CR>
noremap <silent> <C-right> :bnext<CR>
noremap <silent> <C-l> :bnext<CR>
" ,q Closes the current buffer
nnoremap <silent> <Leader>q :Bclose<CR>
" ,Q Closes the current window
nnoremap <silent> <Leader>Q <C-w>c

"------  Searching  ------
set incsearch
set ignorecase
set smartcase
set hlsearch
" Clear search highlights when pressing ,b
nnoremap <silent> <leader>b :nohlsearch<CR>
" http://www.vim.org/scripts/script.php?script_id=2572
" ,a will open a prmompt for a term to search for
noremap <leader>a :Ack 
" ,A will close the new window created for that ack search
noremap <leader>A <C-w>j<C-w>c<C-w>l
let g:ackprg="ack -H --nocolor --nogroup --column"
" When searching for words with * and navigating with N/n, keep line centered vertically
"nnoremap n nzz
"nnoremap N Nzz
"nnoremap * *zz
"nnoremap # #zz
"nnoremap g* g*zz
"nnoremap g# g#zz
" CtrlP will load from the CWD, makes it easier with all these nested repos
let g:ctrlp_working_path_mode = ''
"type S, then type what you're looking for, a /, and what to replace it with
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>

"------  NERDTree Options  ------
let NERDTreeIgnore=['CVS','\.dSYM$']
"setting root dir in NT also sets VIM's cd
let NERDTreeChDirMode=2
" Toggle visibility using ,n
noremap <silent> <Leader>n :NERDTreeToggle<CR>
" These prevent accidentally loading files while focused on NERDTree
autocmd FileType nerdtree noremap <buffer> <c-left> <nop>
autocmd FileType nerdtree noremap <buffer> <c-h> <nop>
autocmd FileType nerdtree noremap <buffer> <c-right> <nop>
autocmd FileType nerdtree noremap <buffer> <c-l> <nop>
" Open NERDTree if we're executing vim without specifying a file to open
autocmd vimenter * if !argc() | NERDTree | endif
" Close if only NERDTree open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Hides "Press ? for help"
let NERDTreeMinimalUI=1


"---------- PHP Stuff -----------
autocmd FileType php let php_parent_error_close = 1
autocmd FileType php let php_parent_error_open = 1
autocmd FileType php let php_large_files = 0

autocmd FileType php,c,cpp noremap <F5> :s+^+//+<CR>
autocmd FileType php,c,cpp noremap <F6> :s+^//++<CR>

autocmd FileType php noremap \fb :silent! exe "s/$/\rfb(" . expand('<cword>') . ", '" . expand('<cword>') . "');/e" \| silent! exe "noh"<CR>
autocmd FileType php noremap \ft :call append(line('.'), 'FirePHP::getInstance(true)->trace(__FUNCTION__);')<CR>
autocmd FileType php set kp=phpdoc

let g:php_smart_members=1
let g:php_alt_properties=1
let g:php_smart_semicolon=1
let g:php_alt_construct_parents=1

"----------- PHP DOC------------
nnoremap <C-K> :call PhpDocSingle()<CR>
vnoremap <C-K> :call PhpDocRange()<CR>
let g:pdv_cfg_Author = 'Sergey Parfenov <s.parfenov@office.ngs.ru>'
let g:pdv_cfg_Copyright = 'NGS'

"--------- Syntastic ---------
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpmd_exec = '~/phpmd/src/bin/phpmd'
let g:syntastic_phpmd_rules = "codesize,design,unusedcode"
let g:syntastic_php_phpcs_args="--report=csv --standard=NGS"

"--------- TAGS ---------
set tags=~/.vim/tags
nnoremap <leader>t :CtrlPTag<cr>
" ,ct = Builds ctags
map <Leader>ct :! /usr/local/bin/ctags -R --fields=+aimS --languages=php -f ~/.vim/tags %:p:h<CR>


"------  Fugitive Plugin Options  ------
"https://github.com/tpope/vim-fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gr :Gremove<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gm :Gmove 
nnoremap <Leader>gp :Ggrep 
nnoremap <Leader>gR :Gread<CR>
nnoremap <Leader>gg :Git 
nnoremap <Leader>gd :Gdiff<CR>

"------  Text Editing Utilities  ------
" ,T = Delete all Trailing space in file
map <Leader>T :%s/\s\+$//<CR>
" ,U = Deletes Unwanted empty lines
map <Leader>U :g/^$/d<CR>
" ,R = Converts tabs to spaces in document
map <Leader>R :retab<CR>
" Deletes trailing space in file upon write
" autocmd BufWritePre * :%s/\s\+$//e

