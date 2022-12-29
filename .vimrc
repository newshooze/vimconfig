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
nnoremap <leader>n :set number!<CR>
" edit .vimrc with \e ( <leader>e )
nnoremap <leader>e :edit ~/.vimrc<CR>
" edit .vimrc with \v ( <leader>v )
nnoremap <leader>v :edit ~/.vimrc<CR>
" Switch to hex mode
nnoremap <leader>x :call TextfileToHex()<CR>
" Switch to text mode
nnoremap <leader>X :call HexfileToText()<CR>
" Launch terminal with \t ( <leader>t )
nnoremap <leader>t :tab term<CR>
" Launch terminal with <C-t>
nnoremap <C-t> :tab term<CR>
" Open the Quickfix List
" <ESC> is mapped in filetype 'qf' (quickfix) to close
nnoremap Q :silent! copen 5<CR>:echo<CR>
nnoremap <leader>q  <ESC>:silent! copen 5<CR>:echo<CR>
" Open command line window
nnoremap <leader>c <ESC>:<C-F>

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

" Close system header files easily
autocmd BufRead /usr/include/* nnoremap q <ESC>:bd<CR>
" Restore q
autocmd BufLeave /usr/include/* nnoremap q <NOP>

" Move through command line history
cnoremap <C-N> <Up>
cnoremap <C-P> <Down>

tnoremap <ESC> <C-\><C-N><CR>
" Close terminal with escape
tnoremap <ESC><ESC> exit<CR>

autocmd BufLeave * let b:winview = winsaveview() 
autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif 

syntax on
colorscheme pastel256

let loaded_matchparen=1

set shortmess+=I
set ruler
set nobackup
set noswapfile
set tabstop=2
set shiftwidth=2
set nowrap
set noshowmatch
set autoread
set autowriteall
set incsearch
set nofoldenable
" Make escape work instantly
set ttimeoutlen=10

filetype plugin on

let g:loaded_matchparen=1

set t_Co=256

" Virtual console cursor block
let &t_ve= "\e[?25h\e[?16;143;255c"
