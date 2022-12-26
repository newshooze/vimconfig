
function! RainingText()
	let l:lines = &lines
	let l:columns = &columns
	echo "RainingText called"
endfunction

function! WordUnderCursor() abort
	return expand("<cword>")
endfunction

function! TransformNumber(radix)
	let l:pos = getpos(".")
	let l:word = WordUnderCursor()
	let l:ret = deepcopy(l:word)
	if a:radix == 2
		let l:ret = printf("%08b",l:word)
	endif
	if a:radix == 8
		let l:ret = printf("%o",l:word)
	endif
	if a:radix == 10 
		let l:ret = printf("%d",l:word)	
	endif
	if a:radix == 16 
		let l:ret = printf("0x%x",l:word)	
	endif
	exe "silent! s/" . l:word . "/" . l:ret . "/"
	call setpos(".",l:pos)
endfunction

nnoremap <leader>bin :call ToBin()<CR>
nnoremap <leader>oct :call ToOct()<CR>
nnoremap <leader>dec :call ToDec()<CR>
nnoremap <leader>hex :call ToHex()<CR>

function! ToBin() abort
	call TransformNumber(2)
endfunction
function! ToHex() abort
	call TransformNumber(16)
endfunction
function! ToOct() abort
	call TransformNumber(8)
endfunction
function! ToDec() abort
	call TransformNumber(10)
endfunction

function! ColorDemo() abort
  for n in range(0,255)
    exec 'hi ColorDemo ctermfg='.n.' ctermbg='.n
    echon printf("%3d",n)
    echohl ColorDemo
    echon 'XXX'
    echohl NONE
    if (n+1) % 16 == 0
      echo ""
    endif
  endfor
endfunction
