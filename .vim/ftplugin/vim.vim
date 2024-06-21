if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let maplocalleader = ","
set dictionary=~/.vim/dict/vimscriptcompletions.txt
set complete+=k
nnoremap <silent> <buffer> <localleader>e :silent! edit ~/.vim/ftplugin/vim.vim<CR>
" Show a vimscript function definition
nnoremap <silent> <localleader>f :silent! call ShowVimFunctionDefinition(expand("<cword>"))<CR>
nnoremap <silent> <buffer> <leader>s :silent! call Source()<CR>

function! Source()
  if exists("b:did_ftplugin")
    unlet b:did_ftplugin
  endif
  execute "source " . expand("%")
endfunction

let s:lastsetfromregex = "^.*Last set from.*line.*[0-9]*$"
" TODO: list vim9 functions
function! ShowVimFunctionDefinition(functionstring) abort
  let l:functiondef = execute("verbose function " . a:functionstring,"silent!")
  if !len(l:functiondef)
    let l:functionlist = execute("function","silent!")
    let l:linelist = split(l:functionlist,'\n')
    let l:functionregex = '<SNR>[0-9]*_.*' . a:functionstring
    let l:matchlist = matchstrpos(l:linelist,l:functionregex)
    if !len(l:matchlist[0])
      return
    else
      let l:functiondef = execute("verbose function " . l:matchlist[0],"silent!")
      if !len(l:functiondef)
        return
      endif
    endif
  endif
  enew 
  setlocal nomodified
  setlocal syntax=vim
  nnoremap <buffer> <ESC> :bd!<CR>
  let l:index = 1
  let l:lines = split(l:functiondef,'\n')
  for l:line in l:lines
    let l:match = match(l:line,s:lastsetfromregex)
    if l:match > -1
      call append(0,"")
      call append(0,"  " . l:line)
      let l:index = l:index + 1
    else
      call setline(l:index,l:line)
    endif
    let l:index = l:index + 1
  endfor
endfunction
