

let maplocalleader = ","
nnoremap <buffer> ,c :copen<CR>
nnoremap <buffer> ,e :edit ~/.vim/ftplugin/sh.vim<CR>
" Run script
nnoremap <buffer> <F6> <ESC>:!./%:t<CR>
inoremap <buffer> <F6> <ESC>:!./%:t<CR>
