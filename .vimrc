" Shift + t and Shift + y rotate buffers
nmap <S-T> :bprevious<CR>
nmap <S-Y> :bnext<CR>
" Use the minus sign to save
nmap - :w<CR>

nmap <S-E> $
vmap <S-E> $

syntax on
colorscheme xoria256

let loaded_matchparen=1

set modeline
set nobackup
set noswapfile
set tabstop=2
set shiftwidth=2
set nowrap
set noshowmatch
set autoread
set autowriteall
set incsearch
set complete+=k

filetype plugin on

"-------------------- csd autocmds
autocmd bufnewfile,bufreadpre csd source ~/.vim/ftplugin/csd.vim

let g:loaded_matchparen=1
