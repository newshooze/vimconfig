
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

map <buffer> <S-K> <C-W>q
" map escape to close the window since its read only
map <buffer> <ESC> <C-W>q
" Don't load another plugin for this buffer
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl com<"
