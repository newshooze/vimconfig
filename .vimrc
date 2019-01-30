nmap <S-T> :bprevious<CR>
nmap <S-Y> :bnext<CR>
" Use the minus sign to save
nmap - :w<CR>
nmap <S-E> $
vmap <S-E> $

set nobackup
set noswapfile
let loaded_matchparen=1
" Turn on syntax highlighting
syntax on
"
colorscheme termcolors
"
set tabstop=2
"
set shiftwidth=2
" Turn of word wrap 
set nowrap

set noshowmatch
"set laststatus=2
" autoread files modified outside vim
set autoread
" autowrite on all events
set autowriteall
" turn on incremental searching
set incsearch
" Turn on file specific plug-ins
filetype plugin on

"set cpoptions+=u
" Use dictionary files for keyword completion
set complete+=k
autocmd FileType &filetype set dict+=/home/vinny/.vim/dict/&filetype " This doesn't work for some reason


" Erase File (EF) 
command! SA execute "normal gg^vG$$"
command! SL execute "normal ^v$"
command! EF execute "normal ggdG"  
command! Prj execute ":16vs ~/projects"				
command! CsoundProjects silent! execute ":16vs ~/csound" 

"-------------------- csd autocmds
autocmd bufnewfile,bufreadpre csd source ~/.vim/ftplugin/csd.vim
autocmd bufenter csd set dict=/home/vinny/.vim/dict/csd
"--------------------- cpp autocmds
autocmd bufenter c,cpp,c,cxx,cc,h,hpp,hxx set dict=/home/vinny/.vim/dict/c
autocmd BufEnter c,cpp,c,cxx,cc,h,hpp,hxx set tags=~/.vim/tags/c
"autocmd FileType cpp,c,cxx,cc,h,hpp,hxx set path+=/usr/include/**

" Disable parentheses matching depends on system. This way we should address
" " NoMatchParen " This doesnt work as it belongs to a plugin, which is only
" loaded _after_ all files are.
" " Trying disable MatchParen after loading all plugins
" "
let g:loaded_matchparen=1
