
let maplocalleader=","

nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/make.vim<CR>

" Go to gcc documentation at word under cursor
nnoremap <buffer> <S-K> :silent view +/<C-R><C-W> ~/.vim/dict/gcc.txt<CR>/<C-R><C-W><CR>

nnoremap <buffer> <F3> :source ~/.vim/ftplugin/make.vim<CR> 

inoremap <buffer> <F6> <ESC>:call RunAsync("make","run"],"")<CR>
nnoremap <buffer> <F6> <ESC>:call RunAsync("make","run"],"")<CR>
" make
inoremap <buffer> <F8> <ESC>:call Make()<CR>
nnoremap <buffer> <F8> <ESC>:call Make()<CR>
" make clean
inoremap <buffer> <S-F8> <ESC>:call RunAsync(["make","clean"],"")<CR>
nnoremap <buffer> <S-F8> <ESC>:call RunAsync(["make","clean"],"")<CR>

inoremap <buffer> <F12> <ESC>:source ~/.vim/template/makefile.vim<CR>gg^
nnoremap <buffer> <F12> :source ~/.vim/template/makefile.vim<CR>gg^

" create completion dictionary with `man gcc > gcc.txt`
set dict=~/.vim/dict/gcc.txt
set iskeyword+=-
set complete+=k
