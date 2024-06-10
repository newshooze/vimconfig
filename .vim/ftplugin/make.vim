if exists("b:did_ftplugin")
  finish
endif
let maplocalleader=","

" makefiles need embedded tabs
setlocal noexpandtab

nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/make.vim<CR>

" Go to gcc documentation at word under cursor
nnoremap <buffer> <S-K> :silent view +/<C-R><C-W> ~/.vim/dict/gcc.txt<CR>/<C-R><C-W><CR>
nnoremap <buffer> <C-K> :tag make<CR>

inoremap <buffer> <F6> <ESC>:call RunAsync(["make","run"],{})<CR>
nnoremap <buffer> <F6> <ESC>:call RunAsync(["make","run"],{})<CR>
" make
inoremap <buffer> <F8> <ESC>:call Make()<CR>
nnoremap <buffer> <F8> <ESC>:call Make()<CR>
" make clean
inoremap <buffer> <S-F8> <ESC>:call RunAsync(["make","clean"],{})<CR>
nnoremap <buffer> <S-F8> <ESC>:call RunAsync(["make","clean"],{})<CR>

inoremap <buffer> <F12> <ESC>:source ~/.vim/template/makefile.vim<CR>gg^
nnoremap <buffer> <F12> :source ~/.vim/template/makefile.vim<CR>gg^

" create completion dictionary with `man gcc > gcc.txt`
setlocal dict=~/.vim/dict/gcc.txt
setlocal iskeyword+=-
setlocal complete+=k
let b:did_ftplugin = 1
