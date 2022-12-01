" Zig file plugin
if exists("b:did_ftplugin")
  finish
endif

let maplocalleader = ","
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/zig.vim<CR>
nnoremap <buffer> <localleader>c :copen 3


set tags=~/.vim/doc/zig/**/tags

" All zig library reference files
" Copied from /usr/lib/zig to ~/.vim/doc/zig
au BufRead ~/.vim/doc/zig/**/* set readonly
au BufRead ~/.vim/doc/zig/**/* nnoremap <buffer> q :bd<CR>
au BufRead ~/.vim/doc/zig/**/* nnoremap <buffer> <ESC> :bd<CR>
au BufRead ~/usr/lib/zig/**/* set readonly
au BufRead ~/usr/lib/zig/**/* nnoremap <buffer> q :bd<CR>
au BufRead ~/usr/lib/zig/**/* nnoremap <buffer> <ESC> :bd<CR>
au BufRead ~/usr/lib/zig/**/* nnoremap <buffer> <S-K> :bd<CR>
au BufRead ~/.vim/doc/zig/zigmanual.txt set ft=help
au BufRead ~/.vim/doc/zig/zigmanual.txt set isk+=-
au BufRead ~/.vim/doc/zig/zigmanual.txt nnoremap <buffer> <CR> <C-]>
au BufRead ~/.vim/doc/zig/zigmanual.txt nnoremap <buffer> q :bd<CR>
au BufRead ~/.vim/doc/zig/zigmanual.txt nnoremap <buffer> <ESC> :bd<CR>
au BufRead ~/.vim/doc/zig/zigmanual.txt nnoremap <buffer> <C-K> :bd<CR>
	
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

nnoremap <buffer> <localleader>c :copen<CR>
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/zig.vim<CR>


" sourcing doesn't seem to work in vim 9
inoremap <buffer> <F3> <ESC>:source ~/.vim/ftplugin/zig.vim<CR>
nnoremap <buffer> <F3> <ESC>:source ~/.vim/ftplugin/zig.vim<CR>

" Run 
inoremap <buffer> <F6> <ESC>:make run<CR>
nnoremap <buffer> <F6> <ESC>:make run<CR>
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
setlocal formatoptions-=t formatoptions+=croql
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

if !exists('g:zig_std_dir') && exists('*json_decode') && executable('zig')
    silent let s:env = system('zig env')
    if v:shell_error == 0
        let g:zig_std_dir = json_decode(s:env)['std_dir']
    endif
    unlet! s:env
endif

if exists('g:zig_std_dir')
    let &l:path = g:zig_std_dir . ',' . &l:path
endif

iabbrev <buffer> ArrayHashMapinit fuckyou

let b:did_ftplugin = 1
