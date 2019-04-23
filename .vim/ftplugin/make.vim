
nnoremap <buffer> <F6> <ESC>:!make run<CR>
inoremap <buffer> <F6> <ESC>:!make run<CR>

nnoremap <buffer> <F8> <ESC>:!make<CR>
inoremap <buffer> <F8> <ESC>:!make<CR>

nnoremap <buffer> <S-F8> <ESC>:!make clean<CR>
inoremap <buffer> <S-F8> <ESC>:!make clean<CR>

nnoremap <buffer> <F12> :source ~/.vim/template/makefile.vim<CR>gg^
inoremap <buffer> <F12> <ESC>:source ~/.vim/template/makefile.vim<CR>gg^

set dict=~/.vim/dict/gcc.txt
set iskeyword+=-
set complete+=k

