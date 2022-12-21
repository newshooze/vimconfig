
let maplocalleader=","

nnoremap <buffer> <localleader>c :copen<CR>
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/make.vim<CR>

inoremap <buffer> <F6> <ESC>:!make run<CR>
nnoremap <buffer> <F6> <ESC>:!make run<CR>

inoremap <buffer> <F8> <ESC>:!make<CR>
nnoremap <buffer> <F8> <ESC>:!make<CR>

inoremap <buffer> <S-F8> <ESC>:!make clean<CR>
nnoremap <buffer> <S-F8> <ESC>:!make clean<CR>

inoremap <buffer> <F12> <ESC>:source ~/.vim/template/makefile.vim<CR>gg^
nnoremap <buffer> <F12> :source ~/.vim/template/makefile.vim<CR>gg^

" create completion dictionary with `man gcc > gcc.txt`
set dict=~/.vim/dict/gcc.txt
set iskeyword+=-
set complete+=k
set helpfile=~/.vim/dict/gcc.txt

