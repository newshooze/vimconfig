" File: qf.vim
" quickfix window settings
" Maintainer: Vinny
" Revision: 2024-5-28 

if exists("b:did_ftplugin")
  finish
endif

let maplocalleader = ","

" Delete the current line in the quickfix list
nnoremap <buffer> <silent> dd :call <SID>DeleteLineFunction(line('.'))<CR>
nnoremap <buffer> <silent> dG :DeleteToEnd<CR>
nnoremap <buffer> <silent> da :call <SID>DeleteAllLinesFunction()<CR>
nnoremap <buffer> <silent> <C-k> :resize +2<CR>
nnoremap <buffer> <silent> <C-j> :resize -2<CR>
nnoremap <buffer> <silent> <S-k> :resize +2<CR>
nnoremap <buffer> <silent> <S-j> :resize -2<CR>

" THESE ARE SET IN .vimrc FOR ALL FILES
" Go to next quickfix error
"nnoremap <buffer> cn :cnext<CR>
"nnoremap <buffer> <localleader>n :bd<CR>:cnext<CR>

" Go to previous quickfix error
"nnoremap <buffer> cp :cprevious<CR>
"nnoremap <buffer> <localleader>p :bd<CR>:cprev<CR>

nnoremap <buffer> <localleader>e :bd<CR>:edit ~/.vim/ftplugin/qf.vim<CR>
nnoremap <buffer> <localleader>s :unlet b:did_ftplugin<CR>:source ~/.vim/ftplugin/qf.vim<CR>
nnoremap <buffer> m :call DialogCentered(getline('.'))<CR>
nnoremap <buffer> co <C-w>p

function! s:AddItemFunction(item)
  caddexpr(a:item)
endfunction

" Debugging only
function! s:AddItems()
  let l:itemcount = 1
  while l:itemcount < 2500
    caddexpr("Item " . l:itemcount)
    let l:itemcount = l:itemcount + 1
  endwhile
endfunction


" quickfix items are zero based (dictionary)
function! s:DeleteLineFunction(line) abort
  let l:cursorpos = getpos('.')
  call setqflist(filter(getqflist(),{idx -> idx != a:line -1}),'r')
  call setpos('.',l:cursorpos)
endfunction

function! s:DeleteLinesFunction(first,last) abort
  let l:cursorpos = getpos('.')
  let l:qflist = deepcopy(getqflist())
  call setqflist([],'f')
  " The -1 is used because vim lines are one based
  " and lists[] are zero based.
  let l:filteredqflist = filter(l:qflist,'v:key < ' . a:first . ' - 1 || v:key > ' . a:last . ' -1')
  call setqflist(l:filteredqflist,'r')
  call setpos('.',l:cursorpos)
endfunction

function! s:DeleteRangeFunction(first,last) abort
  call <SID>DeleteLinesFunction(a:first,a:last)
endfunction

function! s:DeleteToEndFunction() abort
  let l:firstline = line('.')
  let l:lastline = line('$')
  call <SID>DeleteLinesFunction(l:firstline,l:lastline)
endfunction

function! s:DeleteAllLinesFunction() abort
  call setqflist([])
endfunction

command! -nargs=+ DeleteLine call <SID>DeleteLineFunction(<f-args>)
command! -range DeleteRange call <SID>DeleteRangeFunction(<line1>,<line2>)
command! -nargs=+ DeleteLines call <SID>DeleteLinesFunction(<f-args>)
command! DeleteToEnd call <SID>DeleteToEndFunction()
command! DeleteAllLines call <SID>DeleteAllLinesFunction()

let b:did_ftplugin = 1
