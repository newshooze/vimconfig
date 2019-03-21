
" Vim filetype plugin file
" Language:	   Plain text help file 
" Maintainer:	   vinny 
" URL:		    
" Latest Revision:  2011-12-29
" arch-tag:	    


" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" map Shift + k to close the help buffer using next mapping <ESC>:bd<CR>
nnoremap <buffer> <S-K> <ESC>:bd<CR>
" map escape to close the help buffer :bd = bufferdelete
nnoremap <buffer> <ESC> <ESC>:bd<CR>
" Don't load another plugin for this buffer
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl com<"
