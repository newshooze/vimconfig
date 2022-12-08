
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

	func ColorSelected(id, result)
		echo a:result
	endfunc


function! Menu()
		let l:list = ['red','green','blue']
			call popup_create(l:list, #{
				\ pos: 'botleft',
				\ line: 'cursor-1',
				\ col: 'cursor',
				\ moved: 'WORD',
				\ zindex: 200,
				\ drag: 1,
				\ wrap: 0,
				\ border: [],
				\ cursorline: 1,
				\ padding: [0,1,0,1],
				\ filter: 'popup_filter_menu',
				\ mapping: 0,
				\ callback: 'ColorSelected'
				\ })

"	let s:winid = popup_create('Title',{})
"	let s:bufnr = winbufnr(s:winid)
"	call setbufline(s:bufnr, 2, 'second line')
endfunction

let maplocalleader = ","
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/text.vim<CR>
nnoremap <buffer> <localleader>m :call Menu()<CR>


nnoremap <buffer> <F2> :source ~/.vim/ftplugin/text.vim<CR>
let b:did_ftplugin = 1
