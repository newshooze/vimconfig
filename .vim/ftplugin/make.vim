
let maplocalleader=","

nnoremap <buffer> <localleader>c :copen<CR>
" Edit this file
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/make.vim<CR>
" Comment out current line
nnoremap <buffer> <localleader>/ 0i#<ESC> 
" Close makefile easily 
nnoremap <buffer> q :bd<CR>
nnoremap <buffer> <localleader>q :bd<CR>

" Go to gcc documentation at word under cursor
nnoremap <buffer> <S-K> :silent view +/<C-R><C-W> ~/.vim/dict/gcc.txt<CR>

nnoremap <buffer> <F3> :source ~/.vim/ftplugin/make.vim<CR> 
inoremap <buffer> <F6> <ESC>:!make run<CR>
nnoremap <buffer> <F6> :!make run<CR>

inoremap <buffer> <F8> <ESC>:!make<CR>
nnoremap <buffer> <F8> :!make<CR>

inoremap <buffer> <S-F8> <ESC>:!make clean<CR>
nnoremap <buffer> <S-F8> :!make clean<CR>

inoremap <buffer> <F12> <ESC>:source ~/.vim/template/makefile.vim<CR>gg^
nnoremap <buffer> <F12> :source ~/.vim/template/makefile.vim<CR>gg^

" create completion dictionary with `man gcc > gcc.txt`
set dict=~/.vim/dict/gcc.txt
set iskeyword+=-
set complete+=k
set helpfile=~/.vim/dict/gcc.txt

