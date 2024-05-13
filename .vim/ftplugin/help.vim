" Latest Revision:  2022-11-14
"
if exists("b:did_ftplugin")
  finish
endif

" Move to the next hyperlink
" Call with <TAB>
function! NextLink()
	exe "normal /|[a-zA-Z0-9-]/e\<CR>"
endfunction
" Move to the previous hyperlink
" Call with <S-TAB>
function! PrevLink()
	exe "normal ?|[a-zA-Z0-9-]?e\<CR>"
endfunction

let maplocalleader = ","
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/help.vim<CR>

"setlocal bufhidden=wipe
" map q to close help buffer
nnoremap <buffer> q <ESC>:bd<CR>
" map Shift + k to close the help buffer
nnoremap <buffer> <S-K> :silent! tag <C-R><C-W><CR>
" map Escape to close the help buffer :bd = bufferdelete
nnoremap <buffer> <ESC> <ESC>:bd<CR>
" map Enter to follow tag
nnoremap <buffer> <CR> <C-]>
" Tab jumps to next hyperlink in help files
nnoremap <TAB> <ESC>:silent! call NextLink()<CR>:echo ""<CR>
" Shift+Tab jumps to previous hyperlink in help files
nnoremap <S-TAB> <ESC>:silent! call PrevLink()<CR>:echo ""<CR>
" Jump to next help topic
nnoremap <C-N> /^ \+\*[a-zA-Z0-9-]*\*$<CR>
" Jump to previous help topic
nnoremap <C-P> ?^ \+\*[a-zA-Z0-9-_]*\*$<CR>

" Don't load another plugin for this buffer
let b:did_ftplugin = 1
let b:undo_ftplugin = 1
