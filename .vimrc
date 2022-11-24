" Cycle forward and backward through open files
nnoremap <S-T> :bprevious<CR>
nnoremap <S-Y> :bnext<CR>

" Open the Quickfix List
" <ESC> is mapped in filetype 'qf' (quickfix) to close
nnoremap silent Q :copen<CR>:echo <CR>

" default leader key is "\"
" edit .vimrc with \v
nnoremap <leader>v :edit ~/.vimrc<CR>
" Move between windows
nnoremap <leader>h <C-W>h 
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
" Launch terminal with \t ( <leader>t )
nnoremap <leader>t :tab term<CR>
" Launch terminal with <C-t>
nnoremap <C-t> :tab term<CR>
tmap <ESC> <C-\><C-N><CR>
tmap <ESC><ESC> exit<CR>

autocmd BufLeave * let b:winview = winsaveview() 
autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif 

" close command history window with escape
autocmd CmdWinEnter * nnoremap <buffer> <ESC> <ESC>:q<CR>
" Complete file name with <C-f>
inoremap <C-F> <C-X><C-F> 
" Complete line
inoremap  <C-L> <C-X><C-L>

syntax on
colorscheme xoria256

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

filetype plugin on

let g:loaded_matchparen=1
if &term =~ '256color'
	set t_ut=
endif
