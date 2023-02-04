if exists("b:did_ftplugin")
  finish
endif

let maplocalleader = ","
nnoremap <buffer> <F3> :unlet b:did_ftplugin<CR>:source ~/.vim/ftplugin/asm.vim<CR>
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/asm.vim<CR>
nnoremap <buffer> <localleader>o :only<CR>
" Close assembly files easily
nnoremap <buffer> <ESC> :bd<CR>
nnoremap <buffer> q :bd<CR>

let b:did_ftplugin = 1
