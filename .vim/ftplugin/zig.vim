
if exists("b:did_ftplugin")
  finish
endif

let maplocalleader = ","

au BufEnter ~/.vim/doc/zig/zig.txt {
	set ft=help
	set iskeyword+=-
}
" Shift k for help at cursor (:view for read only mode)
nnoremap <buffer> <S-K> :silent! :view +/[*]<C-R><C-W>[*] ~/.vim/doc/zig/zig.txt<CR>:echo ""<CR>

" Control k for man page at cursor
nnoremap <buffer> <C-K> :!man <C-r><C-W><CR> 

nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/zig.vim<CR>

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

let b:did_ftplugin = 1
