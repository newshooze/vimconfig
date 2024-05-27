" File: qf.vim
" quickfix window settings
" Maintainer: Vinny
" Revision: 2024-5-14 

if exists("b:did_ftplugin")
  finish
endif
nnoremap <silent> <buffer> <S-Y> <NOP>
nnoremap <silent> <buffer> <S-T> <NOP>

let maplocalleader = ","

nnoremap <buffer> <localleader>e :bd<CR>:edit ~/.vim/ftplugin/qf.vim<CR>
nnoremap <buffer> <localleader>s :unlet b:did_ftplugin<CR>:source ~/.vim/ftplugin/qf.vim<CR>
nnoremap <buffer> <localleader>q :bd<CR>
nnoremap <buffer> \q :bd<CR>

function! s:ChangeWindowHeight(howmuch) abort
  let l:cursorpos = getpos('.')
	let b:height = winheight(winnr())
	let b:newheight = b:height + a:howmuch
	if b:newheight < 1 || b:newheight > 25
    return
  endif
	silent exec "copen " . b:newheight
  call setpos('.',l:cursorpos)
endfunction

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

nnoremap <buffer> gq :call <SID>AddItems()<CR>
nnoremap <silent> <buffer> cc :caddexpr("Hello")<CR>

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

" Delete the current line in the quickfix list
nnoremap <buffer> <silent> dd :call <SID>DeleteLineFunction(line('.'))<CR>
nnoremap <buffer> <silent> dG :DeleteToEnd<CR>
nnoremap <buffer> <silent> da :call <SID>DeleteAllLinesFunction()<CR>
nnoremap <buffer> <silent> <localleader>k :bprevious<CR>
nnoremap <buffer> <silent> <localleader>j :bnext<CR>
nnoremap <buffer> <silent> <C-k> :call <SID>ChangeWindowHeight(2)<CR>
nnoremap <buffer> <silent> <C-j> :call <SID>ChangeWindowHeight(-2)<CR>
nnoremap <buffer> <silent> <S-k> :call <SID>ChangeWindowHeight(2)<CR>
nnoremap <buffer> <silent> <S-j> :call <SID>ChangeWindowHeight(-2)<CR>


" Go to next quickfix error
nnoremap <buffer> cn :cnext<CR>
nnoremap <buffer> n :bd<CR>:cnext<CR>
nnoremap <buffer> <localleader>n :bd<CR>:cnext<CR>

" Go to previous quickfix error
nnoremap <buffer> cp :cprevious<CR>
nnoremap <buffer> p :bd<CR>:cprev<CR>
nnoremap <buffer> <localleader>p :bd<CR>:cprev<CR>
let b:did_ftplugin = 1
