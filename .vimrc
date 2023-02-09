" Cycle forward and backward through open files
nnoremap <silent> <S-Y> :bnext<CR>
nnoremap <silent> <S-T> :bprevious<CR>

" These are annoying
nnoremap <buffer> ( <NOP>
nnoremap <buffer> ) <NOP>

" Control q begins a macro
nnoremap <C-q> q
" Kill original macro mapping
nnoremap q <NOP>
vnoremap q <NOP>

" default leader key is "\"
" Source vimrc
nnoremap <leader>s :source ~/.vimrc<CR>
" Toggle line numbers
nnoremap <leader>n :set number!<CR>
" edit .vimrc with \e ( <leader>e )
nnoremap <leader>e :edit ~/.vimrc<CR>
" edit .vimrc with \v ( <leader>v )
nnoremap <leader>v :edit ~/.vimrc<CR>
" Edit misc functions
nnoremap <leader>f :edit ~/.vim/ftdetect/functions.vim<CR>
" Edit makefile
nnoremap <leader>m :edit makefile<CR>
" Switch to hex mode
nnoremap <leader>x :call TextfileToHex()<CR>
" Switch to text mode
nnoremap <leader>X :call HexfileToText()<CR>
" Launch terminal with \t ( <leader>t )
nnoremap <leader>t :tab term<CR>
" Start python3
nnoremap <leader>p :!python3<CR>
" Do a REPL on the current line
nnoremap <leader>r :.w !sh<CR>
" Do a REPL on visual selection
vnoremap <leader>r :w !sh<CR>
" Launch terminal with <C-t>
nnoremap <C-t> :tab term<CR>
" Doom terminal
nnoremap ` <ESC>:tab term<CR>
" Open the Quickfix List
" <ESC> is mapped in filetype 'qf' (quickfix) to close
nnoremap Q :silent! copen 5<CR>:echo<CR>
nnoremap <leader>q  :silent! copen 5<CR>:echo<CR>
" Open command line window
nnoremap <leader>c :<C-F>
" Open search history
nnoremap <leader>/ /<C-F>

nnoremap <S-K> :tag <C-r><C-W><CR>
nnoremap <C-K> :!man <C-r><C-W><CR>

" Move between windows
nnoremap <leader>h <C-W>h 
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l

" Complete file name with <C-f>
inoremap <C-F> <C-x><C-F> 
" Complete line
inoremap  <C-L> <C-x><C-L>

" Close command history window in several ways.
autocmd CmdWinEnter * nnoremap <buffer> <ESC> <ESC>:q<CR>
autocmd CmdWinEnter * nnoremap <buffer> ,c :q<CR>
autocmd CmdWinEnter * nnoremap <buffer> \c :q<CR>
autocmd CmdWinEnter * nnoremap <buffer> q :q<CR>

" Full screen help
autocmd BufEnter * if &bt=='help' | exec ":only" | endif
" Return to previous help topic with 'H
autocmd BufLeave * if &bt=='help' | mark H | endif

" Zighelp zighelp
autocmd BufRead ~/.vim/doc/zig/**/* setlocal nomodifiable
autocmd BufRead ~/.vim/doc/zig/**/* setlocal filetype=zighelp

autocmd BufRead ~/.vim/doc/zig/**/*.zig setlocal nomodifiable
autocmd BufRead ~/.vim/doc/zig/**/*.zig setlocal filetype=zighelp

autocmd BufRead /usr/lib/zig/**/*.zig setlocal nomodifiable
autocmd BufRead /usr/lib/zig/**/*.zig setlocal filetype=zighelp

" Zig manual
autocmd BufRead ~/.vim/doc/zig/zigmanual.txt setlocal nomodifiable
autocmd BufRead ~/.vim/doc/zig/zigmanual.txt setlocal filetype=help
autocmd BufRead  ~/.vim/doc/zig/zigmanual.txt setlocal iskeyword+=-

" All man pages from man 3 in vimhelp form
autocmd BufRead ~/.vim/doc/c/mantovimhelp/*.txt setlocal nomodifiable
autocmd BufRead ~/.vim/doc/c/mantovimhelp/*.txt setlocal filetype=help

autocmd! BufEnter /usr/include/* nnoremap <buffer> q :bd<CR>
autocmd BufEnter /usr/include/* nnoremap <buffer> <ESC> :bd<CR>

" Move through command line history
cnoremap <C-N> <Up>
cnoremap <C-P> <Down>

tnoremap <ESC> <C-\><C-N><CR>
" Close terminal with 2 escapes
tnoremap <ESC><ESC> exit<CR>
tnoremap ` exit<CR>
autocmd BufLeave * let b:winview = winsaveview() 
autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif 

syntax on
colorscheme pastel256

let loaded_matchparen=1

set tags=~/.vim/doc/**/tags
set shortmess+=I
set ruler
set nobackup
set noswapfile
set expandtab
set shiftwidth=2
set tabstop=2
set nowrap
set noshowmatch
set autoread
set autowriteall
set incsearch
set nofoldenable
set nopaste
" Make escape work instantly
set ttimeoutlen=10

filetype plugin on

let g:loaded_matchparen=1

" Virtual console cursor block
let &t_ve= "\e[?25h\e[?16;143;255c"
