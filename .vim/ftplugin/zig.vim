" Zig file plugin
" See also ~/.vim/ftplugin/zighelp.vim
if exists("b:did_ftplugin")
"  finish
endif

let maplocalleader = ","
let g:currenttaglist = []

function! GoToDefinition() abort
	if len("<cword>")
		exe "tag " expand("<cword>")
	endif
endfunction

function! LeftPad(word,number=1,padchar=" ") abort
	let l:index = 0
	let l:returntext = a:word
	if a:number < 1
		return l:returntext
	endif
	while l:index < a:number
		let l:returntext = a:padchar . l:returntext
		let l:index = l:index + 1
	endwhile
	return l:returntext
endfunction

function! RightPad(word,number=1,padchar=" ") abort
	let l:index = 0
	let l:returntext = a:word
	if a:number < 1
		return l:returntext
	endif
	while l:index < a:number
		let l:returntext = l:returntext . a:padchar
		let l:index = l:index + 1
	endwhile
	return l:returntext
endfunction

" list1 is left justfied.
" list2 is right justified.
" There's probably a better way to do this.
function! JustifyPair(list1,list2) abort
	let l:maxleftside = 0
	let l:maxrightside = 0
	let l:returnlist = []
	let l:list1lengths = []
	let l:list2lengths = []
	for name in a:list1
		let l:testlength = strlen(name)
		call add(l:list1lengths,l:testlength)
		if l:testlength > l:maxleftside
			let l:maxleftside = l:testlength
		endif
	endfor	
	for name in a:list2
		let l:testlength = strlen(name)
		call add(l:list2lengths,l:testlength)
		if l:testlength > l:maxrightside
			let l:maxrightside = l:testlength
		endif
	endfor
	let l:index = 0
	while l:index < len(a:list1)
		let l:maxlength = l:maxrightside + l:maxleftside
		let l:itemlength = l:list1lengths[l:index] + l:list2lengths[l:index]
		let l:padlength = l:maxlength - l:itemlength
		let l:newtext = LeftPad(a:list2[l:index],l:padlength," ") 
		call add(l:returnlist,a:list1[l:index] . " " . l:newtext)
		let l:index = l:index + 1
	endwhile
	return l:returnlist
endfunction

function! SelectTagFromMenu(id,result) abort
	if a:result < 1
		return
	endif
	" menu selection is one based not zero based
	let index = a:result - 1
	" tags are stored as name <TAB> file <TAB> ex command
	let l:name = g:currenttaglist[index].name
	let l:filename = g:currenttaglist[index].filename
	let l:cmd = g:currenttaglist[index].cmd
	exe "view " . l:filename
	" execute ex command stored in tag file
	exe l:cmd
endfunction

" Return a filename without the path.
" Assumes at least one slash (/) is in path.
function! StripPath(path) abort
	let l:filename = matchstr(a:path,"[^/]*$")
	return l:filename
endfunction

" Uses tag files to find the word under the cursor.
" This function does not alter the tag stack.
" It uses `view filename /tag`.
" Alters jump list.
function! s:FindTagUnderCursor(word) abort
	let g:currenttaglist = deepcopy(taglist(expand(a:word)))
	if len(g:currenttaglist) < 2
		" Only one tag for this word.
		" Go straight to definition.
		call GoToDefinition()
		return
	endif
	let l:funcnames = []
	let l:filenames = []
	let l:menuitems = []
	for dictitem in g:currenttaglist
		let l:filename = StripPath(dictitem.filename)
		call add(l:filenames,l:filename)
		call add(l:funcnames,dictitem.name)
	endfor
	let l:menuitems = JustifyPair(l:funcnames,l:filenames)	
	call popup_menu(menuitems, #{callback: 'SelectTagFromMenu',line:'cursor',col:'cursor',maxheight: &lines -5})
endfunction

set tags=~/.vim/doc/zig/**/tags
set complete+=t

" Shift K goes to zig function reference
nnoremap <silent> <buffer> <S-K> :silent! call <SID>FindTagUnderCursor("<cword>")<CR>
" Control k for zig manual
nnoremap <buffer> <C-K> :silent! :view ~/.vim/doc/zig/zigmanual.txt<CR>:echo ''<CR>
" grep word under cursor and open the quickfix list
nnoremap <buffer> <localleader>g :vimgrep /<C-R><C-W>/j ~/.vim/doc/zig/std/**/*.zig<CR>:copen 5<CR>
" Open quickfix list
nnoremap <buffer> <localleader>q :copen 5<CR>
" Open location list
nnoremap <buffer> <localleader>l :lopen 5<CR>
" Open command line history
nnoremap <buffer> <localleader>c :<C-F>
" Open this file
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/zig.vim<CR>
nnoremap <expr> q pumvisible() ? '<ESC>' : '<CR>'

" Sourcing doesn't seem to work
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

let b:did_ftplugin = 1
