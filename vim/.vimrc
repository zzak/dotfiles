syntax on

let mapleader = ","
set t_Co=256
set background=dark
set nocompatible
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set incsearch
set hlsearch
set number
set ruler
set directory=~/.swap
set title
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
set novisualbell
set noerrorbells
set pastetoggle=<F2>
set wrap linebreak nolist
set scrolloff=7
set ttyscroll=3

" Clear last search highlight with Spacebar
nnoremap <Space> :noh<cr>

" Add some line space for easy reading
set linespace=4

"indent settings
set shiftwidth=2
set softtabstop=2
set expandtab

" for C
au FileType c setl ts=8 sw=4 softtabstop=4 noexpandtab

set mouse=niv
set ttymouse=xterm2
set clipboard=unnamed

set hidden

" Map CTRL+{h,j,k,l} keys to window switching
nnoremap <c-k> <C-w><Up>
nnoremap <c-j> <C-w><Down>
nnoremap <c-l> <C-w><Right>
nnoremap <c-h> <C-w><Left>

" Map - and = to resize window
nnoremap - <C-W>_
nnoremap = <C-W>=

" Adds whitespace highlighter by @eileencodes:
" https://github.com/rails/rails/pull/17526#discussion_r19922368
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
