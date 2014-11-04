syntax on

let mapleader = ","
set t_Co=256
set background=light

fu! Jstdate()
  let date = system("TZ=Japan date +'%a %b %e %T %Y'")
  return substitute(date, "\\\n", "", "")
endfu
fu! ChangeLogStamp()
  return Jstdate() . "  Zachary Scott  <e@zzak.io>"
endfu
imap <C-J> <C-R>=Jstdate()<CR>
imap <C-T> <C-R>=ChangeLogStamp()<CR>

set nocompatible
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set incsearch
set hlsearch
set number
set ruler
set directory=/tmp
set title
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
set novisualbell
set noerrorbells
set pastetoggle=<F2>
set showbreak=...
set wrap linebreak nolist
set scrolloff=7
set ttyscroll=3
" Enables the reading of .vimrc, .exrc and .gvimrc in the current directory.
set exrc
set secure
"mapping for command key to map navigation thru display lines instead
"of just numbered lines
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

" Clear last search highlight
nnoremap <Space> :noh<cr>

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"add some line space for easy reading
set linespace=4

"indent settings
set shiftwidth=2
set softtabstop=2
set expandtab

" for C
au FileType c setl ts=8 sw=4 softtabstop=4 noexpandtab

"set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set mouse=niv
set ttymouse=xterm2
set clipboard=unnamed

set hidden

" Map ctrl-movement keys to window switching
nnoremap <c-k> <C-w><Up>
nnoremap <c-j> <C-w><Down>
nnoremap <c-l> <C-w><Right>
nnoremap <c-h> <C-w><Left>

" Map - and = to resize window
nnoremap - <C-W>_
nnoremap = <C-W>=
