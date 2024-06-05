
if exists("b:did_ftplugin")
  finish
endif

let maplocalleader = ","

" Shift K goes to function reference
nnoremap <buffer> <S-K> <NOP>
" Control k for manual
nnoremap <buffer> <C-K> <NOP>
" grep word under cursor and open the quickfix list
" Open quickfix list
nnoremap <buffer> <localleader>q :copen 5<CR>
" Open location list
nnoremap <buffer> <localleader>l :lopen 5<CR>
" Open command line history
nnoremap <buffer> <localleader>c :<C-F>
" Open this file
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/nim.vim<CR>

inoremap <buffer> <F3> <ESC>:source ~/.vim/ftplugin/nim.vim<CR>
nnoremap <buffer> <F3> <ESC>:source ~/.vim/ftplugin/nim.vim<CR>

inoremap <buffer> <F5> <ESC>:!nim -c  %:t<CR>
nnoremap <buffer> <F5> <ESC>:!nim -c %:t<CR>

" Run 
inoremap <buffer> <F6> <ESC>:make run<CR>
nnoremap <buffer> <F6> <ESC>:make run<CR>
" test
inoremap <buffer> <F7> <ESC>:make test<CR>
nnoremap <buffer> <F7> <ESC>:make test<CR>
" Make
inoremap <buffer> <F8> <ESC>:make<CR>
nnoremap <buffer> <F8> <ESC>:make<CR>
" Make Clean
inoremap <buffer> <S-F8> <ESC>:make clean<CR>
nnoremap <buffer> <S-F8> <ESC>:make clean<CR>

" Match builtin fns
setlocal iskeyword+=@-@
" Recomended code style, no tabs and 2-space indentation
setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal formatoptions+=croql
setlocal formatoptions-=t
setlocal suffixesadd=.nim,.nimrod


let b:did_ftplugin = 1
