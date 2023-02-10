
function Template()
  call append(0,"#!/bin/bash")
  :silent !chmod +x %
  redraw!
  echo "!chmod +x " . @%
endfunction

let maplocalleader = ","
nnoremap <buffer> <localleader>q :copen 5<CR>
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/sh.vim<CR>
nnoremap <silent> <buffer> <localleader>r :silent! :.w !sh<CR>
vnoremap <silent> <buffer> <localleader>r :silent! :w !sh<CR>
nnoremap <buffer> <F3> :source ~/.vim/ftplugin/sh.vim<CR>
" Run script
nnoremap <buffer> <F6> <ESC>:!./%:t<CR>
inoremap <buffer> <F6> <ESC>:!./%:t<CR>

nnoremap <buffer> <F12> :call Template()<CR>
