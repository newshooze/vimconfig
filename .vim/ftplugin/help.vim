" Latest Revision:  2022-11-14

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif


let maplocalleader = ","
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/help.vim<CR>

"setlocal bufhidden=wipe
" make help window full screen
autocmd BufEnter <buffer> exec ":only"
" map q to close help buffer
nnoremap <buffer> q <ESC>:bd<CR>
" map Shift + k to close the help buffer
nnoremap <buffer> <S-K> <ESC>:bd<CR>
" map Escape to close the help buffer :bd = bufferdelete
nnoremap <buffer> <ESC> <ESC>:bd<CR>
" map Enter to follow tag
nnoremap <buffer> <CR> <C-]>
" Don't load another plugin for this buffer
let b:did_ftplugin = 1
let b:undo_ftplugin = 1
