" Assembly files (.s)
if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <ESC> :bd<CR>

let b:did_ftplugin = 1
