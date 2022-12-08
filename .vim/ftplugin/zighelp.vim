" All zig library reference files
" Copied from /usr/lib/zig to ~/.vim/doc/zig
" 
if exists("b:did_ftplugin")
  finish
endif

" Set a mark to the last help topic
" Use 'H to return to previous topic
autocmd BufLeave * if &ft=='zighelp' | mark H | endif

function CloseZigHelp() abort
	let s:bufnumber = bufnr("$")
	while s:bufnumber > 0
		if bufexists(s:bufnumber)
			if getbufvar(s:bufnumber,"&ft") == 'zighelp'
				silent! exe ":bdelete " . s:bufnumber
			endif
		endif
		let s:bufnumber = s:bufnumber - 1
	endwhile
endfunction

setlocal readonly
setlocal nomodifiable
setlocal syntax=zig
nnoremap <buffer> q :call CloseZigHelp()<CR>
nnoremap <buffer> <ESC> :call CloseZigHelp()<CR>
nnoremap <buffer> <S-K> :call CloseZigHelp()<CR>
noremap <buffer> tn :tnext<CR>
noremap <buffer> tp :tprevious<CR>
noremap <buffer> cn :cnext<CR>
noremap <buffer> cp :cprev<CR>


let b:did_ft_plugin = 1
