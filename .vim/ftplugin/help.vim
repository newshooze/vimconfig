
" Vim filetype plugin file
" Language:	   Plain text help file 
" Maintainer:	   vinny
" Latest Revision:  2022-11-17


" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" make help window full screen
autocmd BufWinEnter * exec ":only"
" map q to close help buffer
nnoremap <buffer> q <ESC>:bd<CR>
" map Shift + k to close the help buffer
nnoremap <buffer> <S-K> <ESC>:bd<CR>
" map escape to close the help buffer
nnoremap <buffer> <ESC> <ESC>:bd<CR>
" Don't load another plugin for this buffer
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl com<"
