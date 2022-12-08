" Zig file plugin
" See also ~/.vim/ftplugin/zighelp.vim
if exists("b:did_ftplugin")
  finish
endif

let maplocalleader = ","

" ----------------------- TESTING ----------------------------------
function Select(id,result)
	echo(a:result)
endfunction

function DO()
	call popup_menu(['Red','Green','Blue'], #{callback: 'Select',line:'cursor',col:'cursor'})
endfunction

nnoremap <F2> :call DO()<CR>
" ----------------------- END TESTING ------------------------------
set tags=~/.vim/doc/zig/**/tags
set complete+=t

au BufRead ~/.vim/doc/zig/zigmanual.txt setlocal nomodifiable
au BufRead ~/.vim/doc/zig/zigmanual.txt setlocal filetype=help
au BufRead ~/.vim/doc/zig/zigmanual.txt setlocal iskeyword+=-
" <CR> moves to hyperlink under cursor
au BufRead ~/.vim/doc/zig/zigmanual.txt nnoremap <buffer> <CR> :silent! tag <C-R><C-W><CR>
" close help in many ways
au BufRead ~/.vim/doc/zig/zigmanual.txt nnoremap <buffer> q :bd<CR>
au BufRead ~/.vim/doc/zig/zigmanual.txt nnoremap <buffer> <ESC> :bd<CR>
au BufRead ~/.vim/doc/zig/zigmanual.txt nnoremap <buffer> <C-K> :bd<CR>
au BufRead ~/.vim/doc/zig/zigmanual.txt nnoremap <buffer> <S-K> :call GoToDefinition()<CR>

function! GoToDefinition()
	if len("<cword>")
		silent! exe "tag " expand("<cword>")
		echo ""
	endif
endfunction

" Shift K goes to zig function reference
nnoremap <buffer> <S-K> :call GoToDefinition()<CR>
" Control k for zig manual
nnoremap <buffer> <C-K> :silent! :view ~/.vim/doc/zig/zigmanual.txt<CR>:echo ''<CR>
"nnoremap <buffer> <C-K> :silent! :view +/[*]<C-R><C-W>[*] ~/.vim/doc/zig/zig.txt<CR>:echo ''<CR>

" Open quickfix list
nnoremap <buffer> <localleader>q :copen 5<CR>
" Open location list
nnoremap <buffer> <localleader>l :lopen 5<CR>
" Opne command line history
nnoremap <buffer> <localleader>c :<C-F>
" Open this file
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/zig.vim<CR>


" sourcing doesn't seem to work in vim 9
inoremap <buffer> <F3> <ESC>:source ~/.vim/ftplugin/zig.vim<CR>
nnoremap <buffer> <F3> <ESC>:source ~/.vim/ftplugin/zig.vim<CR>

inoremap <buffer> <F5> <ESC>:!zig build-exe %:t<CR>
nnoremap <buffer> <F5> <ESC>:!zig build-exe %:t<CR>

" Run 
inoremap <buffer> <F6> <ESC>:make run<CR>
nnoremap <buffer> <F6> <ESC>:make run<CR>
" zig test
inoremap <buffer> <F7> <ESC>:make test<CR>
nnoremap <buffer> <F7> <ESC>:make test<CR>
" Make
inoremap <buffer> <F8> <ESC>:make<CR>
nnoremap <buffer> <F8> <ESC>:make<CR>
" Make Clean
inoremap <buffer> <S-F8> <ESC>:make clean<CR>
nnoremap <buffer> <S-F8> <ESC>:make clean<CR>


"compiler zig_build

" Match Zig builtin fns
setlocal iskeyword+=@-@
" Recomended code style, no tabs and 2-space indentation
setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal formatoptions+=croql
setlocal formatoptions-=t
setlocal suffixesadd=.zig,.zir

" Compiler error format
set efm=\%f:%l:%c:\ %t%.%#:\ %m,
  \%Z%p^,
  \%C%.%#,
  \%-G%.%#

if has('comments')
    setlocal comments=:///,://!,://,:\\\\
    setlocal commentstring=//\ %s
endif

if has('find_in_path')
    let &l:includeexpr='substitute(v:fname, "^([^.])$", "\1.zig", "")'
    let &l:include='\v(\@import>|\@cInclude>|^\s*\#\s*include)'
endif

let &l:define='\v(<fn>|<const>|<var>|^\s*\#\s*define)'

"if !exists('g:zig_std_dir') && exists('*json_decode') && executable('zig')
"    silent let s:env = system('zig env')
"    if v:shell_error == 0
"        let g:zig_std_dir = json_decode(s:env)['std_dir']
"    endif
"    unlet! s:env
"endif

"if exists('g:zig_std_dir')
"    let &l:path = g:zig_std_dir . ',' . &l:path
"endif
function! InferContext(atom)
	
endfunction

let b:did_ftplugin = 1
