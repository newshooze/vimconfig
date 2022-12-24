" All zig library reference files
" Copied from /usr/lib/zig to ~/.vim/doc/zig

if exists("b:did_ftplugin")
  finish
endif

let maplocalleader = ","
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/zighelp.vim<CR>

" Set a mark to the last help topic
" Use 'H to return to previous topic
autocmd BufLeave * if &ft=='zighelp' | mark H | endif
autocmd BufEnter * if &ft=='zighelp' | normal <C-g> | endif

function! CloseZigHelp() abort
	let s:bufnumber = bufnr("$")
	while s:bufnumber > 0
		if bufexists(s:bufnumber)
			if getbufvar(s:bufnumber,"&ft") == 'zighelp'
				silent! exe ":bdelete " . s:bufnumber
			endif
		endif
		let s:bufnumber = s:bufnumber - 1
	endwhile
	echo
endfunction

set tags=~/.vim/doc/zig/**/tags
setlocal readonly
setlocal nomodifiable
setlocal syntax=zig
nnoremap <buffer> q :silent! call CloseZigHelp()<CR>
nnoremap <buffer> <ESC> :silent! call CloseZigHelp()<CR>
" GoToDefinition defined in ftplugin/zig.vim
nnoremap <buffer> <S-K> :silent! call GoToDefinition()<CR>
noremap <buffer> tn :silent! tnext<CR>
noremap <buffer> tp :silent! tprevious<CR>
noremap <buffer> <C-N> :silent! tnext<CR>
noremap <buffer> <C-P> :silent! tprevious<CR>
noremap <buffer> cn :silent! cnext<CR>
noremap <buffer> cp :silent! cprev<CR>

let b:did_ft_plugin = 1
