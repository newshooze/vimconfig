" Cycle forward and backward through open files
nnoremap <S-T> :bprevious<CR>
nnoremap <S-Y> :bnext<CR>

" These are annoying
nnoremap <buffer> ( <NOP>
nnoremap <buffer> ) <NOP>

" Control q begins a macro
nnoremap <C-q> q
" Kill original macro mapping
nnoremap q <NOP>

" default leader key is "\"
" edit .vimrc with \e ( <leader>v )
nnoremap <leader>e :edit ~/.vimrc<CR>
" edit .vimrc with \v ( <leader>v )
nnoremap <leader>v :edit ~/.vimrc<CR>
" Launch terminal with \t ( <leader>t )
nnoremap <leader>t :tab term<CR>
" Launch terminal with <C-t>
nnoremap <C-t> :tab term<CR>

" Open the Quickfix List
" <ESC> is mapped in filetype 'qf' (quickfix) to close
nnoremap Q <ESC>:silent! copen 5<CR>:echo<CR>
nnoremap <leader>q  <ESC>:silent! copen 5<CR>:echo<CR>
" Open command line window
nnoremap <leader>c <ESC>:<C-F>

" Move between windows
nnoremap <leader>h <C-W>h 
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l

" Complete file name with <C-f>
inoremap <C-F> <C-X><C-F> 
" Complete line
inoremap  <C-L> <C-X><C-L>

" Close command history window with escape.
autocmd CmdWinEnter * nnoremap <buffer> <ESC> :q<CR>
autocmd CmdWinEnter * nnoremap <buffer> ,c :q<CR>
autocmd CmdWinEnter * nnoremap <buffer> \c :q<CR>
autocmd CmdWinEnter * nnoremap <buffer> q :q<CR>

" Return to previous help topic with 'H
autocmd BufLeave * if &bt=='help' | mark H | endif

" Zighelp zighelp
au! BufRead ~/.vim/doc/zig/**/*.zig setlocal filetype=zighelp

" move through command line history
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
set undodir=~/.vim/undo
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

filetype plugin on

let g:loaded_matchparen=1

function! ColorDemo() abort
  for n in range(0,255)
    exec 'hi ColorDemo ctermfg='.n.' ctermbg='.n
    echon printf("%3d",n)
    echohl ColorDemo
    echon 'XXX'
    echohl NONE
    if (n+1) % 16 == 0
      echo ""
    endif
  endfor
endfunction

command! ColorDemo call ColorDemo()
if &term =~ '256color'
  set t_ut=
endif
