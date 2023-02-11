" Cycle forward and backward through open files
nnoremap <silent> <S-Y> :bnext<CR>
nnoremap <silent> <S-T> :bprevious<CR>

" These are annoying
nnoremap <buffer> ( <NOP>
nnoremap <buffer> ) <NOP>

" Control q begins a macro
nnoremap <C-q> q
" Kill original macro mapping
nnoremap q <NOP>
vnoremap q <NOP>
" default leader key is "\"
"
" Show a buffer menu
nnoremap <leader>b :call BufferMenu()<CR>
nnoremap ,b :silent! call BufferMenu()<CR>
" Source vimrc
nnoremap <leader>s :source ~/.vimrc<CR>
" Toggle line numbers
nnoremap <leader>n :set number!<CR>
" edit .vimrc with \e ( <leader>e )
nnoremap <leader>e :edit ~/.vimrc<CR>
" Do math on the command line
nnoremap <leader>v :silent! call EvaluateLine()<CR>
" Edit misc functions
nnoremap <leader>f :edit ~/.vim/ftdetect/functions.vim<CR>
" Edit makefile
nnoremap <leader>m :edit makefile<CR>
" Switch to hex mode
nnoremap <leader>x :call TextfileToHex()<CR>
" Switch to text mode
nnoremap <leader>X :call HexfileToText()<CR>
" Launch terminal with \t ( <leader>t )
nnoremap <leader>t :tab term<CR>
" Start python3
nnoremap <leader>p :!python3<CR>
" Do a REPL on the current line
nnoremap <leader>r :.w !sh<CR>
" Do a REPL on visual selection
vnoremap <leader>r :w !sh<CR>
" Select line
nnoremap vv 0v$
" Launch terminal with <C-t>
nnoremap <C-t> :tab term<CR>
" Doom terminal
inoremap ` <ESC>:tab term<CR>
nnoremap ` :tab term<CR>
" Open the Quickfix List
" <ESC> is mapped in filetype 'qf' (quickfix) to close
nnoremap Q :silent! copen 5<CR>:echo<CR>
nnoremap <leader>q  :silent! copen 5<CR>:echo<CR>
" Open command line window
nnoremap <leader>c :<C-F>
" Open search history
nnoremap <leader>/ /<C-F>
" Open reverse search history
nnoremap <leader>? ?<C-F>

" Go to tag for word under cursor
nnoremap <S-K> :tag <C-r><C-W><CR>
" Manual (man) for word under cursor
nnoremap <C-K> :!man <C-r><C-W><CR>

" Escape and q removes unwanted windows
nnoremap <silent> <ESC> :silent! call KillOutputWindows()<CR>
nnoremap <silent> q <ESC> :silent! call KillOutputWindows()<CR>

" Move between windows
nnoremap <leader>h <C-W>h 
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l

" Transform numbers in place
nnoremap <leader>bin :call ToBin()<CR>
nnoremap <leader>oct :call ToOct()<CR>
nnoremap <leader>dec :call ToDec()<CR>
nnoremap <leader>hex :call ToHex()<CR>

" Do a 8 bit color demo
nnoremap <leader>color :call ColorDemo()<CR>

" Complete file name with <C-f>
inoremap <C-F> <C-x><C-F> 
" Complete line
inoremap  <C-L> <C-x><C-L>

" Close command history window in several ways.
autocmd CmdWinEnter * nnoremap <buffer> <ESC> <ESC>:q<CR>
autocmd CmdWinEnter * nnoremap <buffer> ,c :q<CR>
autocmd CmdWinEnter * nnoremap <buffer> \c :q<CR>
autocmd CmdWinEnter * nnoremap <buffer> q :q<CR>

" Full screen help
autocmd BufEnter * if &bt=='help' | exec ":only" | endif
" Return to previous help topic with 'H
autocmd BufLeave * if &bt=='help' | mark H | endif

" Zighelp zighelp
autocmd BufRead ~/.vim/doc/zig/**/* setlocal nomodifiable
autocmd BufRead ~/.vim/doc/zig/**/* setlocal filetype=zighelp

autocmd BufRead ~/.vim/doc/zig/**/*.zig setlocal nomodifiable
autocmd BufRead ~/.vim/doc/zig/**/*.zig setlocal filetype=zighelp

autocmd BufRead /usr/lib/zig/**/*.zig setlocal nomodifiable
autocmd BufRead /usr/lib/zig/**/*.zig setlocal filetype=zighelp

" Zig manual
autocmd BufRead ~/.vim/doc/zig/zigmanual.txt setlocal nomodifiable
autocmd BufRead ~/.vim/doc/zig/zigmanual.txt setlocal filetype=help
autocmd BufRead  ~/.vim/doc/zig/zigmanual.txt setlocal iskeyword+=-

" Close most docs easily
autocmd BufRead ~/.vim/doc/c/**/* setlocal nomodifiable
autocmd BufRead ~/.vim/doc/c/**/* setlocal filetype=help

autocmd BufEnter /usr/include/* nnoremap <buffer> q :bwipeout!<CR>
autocmd BufEnter /usr/include/* nnoremap <buffer> <ESC> :bwipeout!<CR>

autocmd BufEnter runoutput nnoremap <silent> <buffer> <ESC> :bwipeout!<CR>
autocmd BufEnter runoutput nnoremap <silent> <buffer> q :bwipeout!<CR>
" Go to the bottom on entry
autocmd BufEnter runoutput normal G

autocmd BufEnter makeoutput nnoremap <silent> <buffer> <ESC> :bwipeout!<CR>
autocmd BufEnter makeoutput nnoremap <silent> <buffer> q :bwipeout!<CR>
" Go to the bottom on entry
autocmd BufEnter makeoutput normal G

" Move through command line history
cnoremap <C-N> <Up>
cnoremap <C-P> <Down>

tnoremap <ESC> <C-\><C-N><CR>
" Close terminal with 2 escapes
tnoremap <ESC><ESC> exit<CR>
" Close terminal Doom style
tnoremap ` exit<CR>

autocmd BufLeave * let b:winview = winsaveview() 
autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif 

syntax on
colorscheme pastel256

let loaded_matchparen=1

set tags=~/.vim/doc/**/tags
set shortmess+=I
set ruler
set nobackup
set noswapfile
set expandtab
set shiftwidth=2
set tabstop=2
set nowrap
set noshowmatch
set autoread
set autowriteall
set incsearch
set nofoldenable
set nopaste
" Make escape work instantly
set ttimeoutlen=10

filetype plugin on

let g:loaded_matchparen=1

let s:quickfixsize = 5
let s:runpopup = 0
let s:runoutputtext = []
let s:popupoutputtext = []
let s:makewarningcount = 0
let s:makeerrorcount = 0

function! KillOutputWindows() abort
  silent cclose
  call popup_close(s:runpopup)
  " Close ALL popups (popup_clear)
  call popup_clear(1)
  silent! execute "bwipeout! makeoutput" 
  silent! execute "bwipeout! runoutput"
  silent! execute "bwipeout! assemblyoutput"
endfunction

function! RunAsyncJobFunction(channel,msg) abort
  if bufexists("runoutput")
    let l:runwindownumber = bufwinnr("runoutput")
    let l:runwindowid = win_getid(l:runwindownumber)
  endif
endfunction

function! RunAsyncExitFunction(job,status) abort
endfunction

function! RunAsync(arglist,optionsdictionary) abort
  wall
  call KillOutputWindows()
  let l:programargs = a:arglist 
  let l:joboptions = {}
  let l:joboptions["out_msg"] = "0"
  let l:joboptions["err_msg"] = "0"
  let l:joboptions["out_io"] = "buffer"
  let l:joboptions["err_io"] = "buffer"
  let l:joboptions["out_name"] = "runoutput"
  let l:joboptions["err_name"] = "runoutput"
  let l:joboptions["callback"] = function('RunAsyncJobFunction')
  let l:joboptions["exit_cb"] = function('RunAsyncExitFunction')
  let s:runasyncjob = job_start(l:programargs,l:joboptions)
  botright 5split runoutput
  execute "wincmd p"
endfunction

function! RunAsyncInPopupFunction(channel,msg) abort
  call add(s:popupoutputtext,a:msg)
  call popup_settext(s:runpopup,s:popupoutputtext)
  silent call win_execute(s:runpopup,'normal G0')
endfunction

" TODO - Implement command! -range for popup height
function! RunAsyncInPopup(arglist,optionsdictionary) abort
  call KillOutputWindows()
  let l:programargs = a:arglist
  let l:joboptions = {}
  let l:joboptions["out_msg"] = "0"
  let l:joboptions["err_msg"] = "0"
  let l:joboptions["callback"] = function('RunAsyncInPopupFunction')
  let s:runpopup = popup_create('', #{
  \ pos: 'botleft',
  \ title: '',
  \ border: [0,0,0,0],
  \ padding: [0,0,0,0],
  \ line: &lines,
  \ col: 0,
  \ minheight: 5,
  \ maxheight: 5,
  \ scrollbar: 1,
  \ minwidth: &columns,
  \ maxwidth: &columns,
  \ close: 'none',
  \ wrap: 'FALSE',
  \ })
  let s:runinpopupjob = job_start(l:programargs,l:joboptions)
  let s:popupoutputtext = []
endfunction

function! MakeExitFunction(job,status) abort
  if bufexists("makeoutput")
    if s:makewarningcount > 0 ||  s:makeerrorcount > 0
      silent execute "bwipeout! makeoutput" 
      silent execute "copen " s:quickfixsize
      execute "wincmd p"
    endif
  endif
  let s:makewarningcount = 0
  let s:makeerrorcount = 0
endfunction

function! MakeJobFunction(channel,msg) abort
  if a:msg =~ " warning: "
    caddexpr a:msg
    let s:makewarningcount = s:makewarningcount + 1
  endif
  if a:msg =~ " error: "
    caddexpr a:msg
    let s:makeerrorcount = s:makeerrorcount + 1
  endif
endfunction

" Run make (or makeprg) in the current directory
function! Make() abort
  silent wall
  " Close any existing quickfix and make buffers
  call KillOutputWindows()
  let l:joboptions = {}
  let l:joboptions["out_msg"] = "0"
  let l:joboptions["err_msg"] = "0"
  let l:joboptions["out_io"] = "buffer"
  let l:joboptions["err_io"] = "buffer"
  let l:joboptions["out_name"] = "makeoutput"
  let l:joboptions["err_name"] = "makeoutput"
  let l:joboptions["callback"] = function('MakeJobFunction')
  let l:joboptions["exit_cb"] = function('MakeExitFunction')
  let s:makejob = job_start(&makeprg,l:joboptions)
  " Clear the quickfix window
  cexpr ""
  " Create the scrolling output buffer
  execute "botright 5split makeoutput" 
  " Switch back to previous workspace
  exe "wincmd p"
endfunction

function! AssemblyOutput()
  silent wall
  " Close any existing quickfix and make buffers
  call KillOutputWindows()
  let l:sourcefile= expand('%:t')
  let l:command = [
  \ "gcc",
  \ "-S",
  \ "-O3",
  \ "-Wall",
  \ "-Wextra",
  \ "-fno-rtti",
  \ "-fverbose-asm",
  \ "-fno-exceptions",
  \ "-fno-asynchronous-unwind-tables",
  \ l:sourcefile,
  \ "-o-"
  \ ]
  let l:joboptions = {}
  let l:joboptions["out_msg"] = "0"
  let l:joboptions["err_msg"] = "0"
  let l:joboptions["out_io"] = "buffer"
  let l:joboptions["err_io"] = "null"
  let l:joboptions["out_name"] = "assemblyoutput"
  let s:assemblyjob = job_start(l:command,l:joboptions)
  let l:assemblyfile = expand('%:r') . '.s'
  execute "botright vsplit assemblyoutput"
  execute "set filetype=asm"
endfunction

function! EatSpace() abort
  let c = nr2char(getchar(0))
  return (c =~ '\s') ? '' : c
endfunction

function! Abbreviation(text) abort
  let l:line = getline('.')
  call setline('.',strpart(line,0,col('.')-1) . a:text . strpart(line,col('.') -1))
  call EatSpace()
  normal f(ll
  stopinsert
  return "" 
endfunction

function! TrimTrailingWhitespace() abort
  %s!\s\+$!!g
endfunction

function! RainingText() abort
  let l:lines = &lines
  let l:columns = &columns
  echo "RainingText called"
endfunction

function! WordUnderCursor() abort
  return expand("<cword>")
endfunction

function! TransformNumber(radix) abort
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


function! TextfileToHex() abort
  :%!xxd
endfunction

function! HexfileToText() abort
  :%!xxd -r
endfunction

function! TabsToTwoSpaces() abort
  :%s/\t/  /g
endfunction

command! TabsToTwoSpaces call TabsToTwoSpaces()

function! AVXmm256setepi8(word)
  " Put a string in a 256 bit register variable
  let l:output = "_mm256_set_epi8("
  let l:wordlength = len(a:word)
  for index in range(0,32)
    if index < l:wordlength
      let l:output = l:output . "'" . a:word[index] . "'"  
    else
      let l:output = l:output . "'" . "\\0" . "'"
    endif
    if index < 32
      let l:output = l:output . ","
    endif
  endfor
  let l:output = l:output . ");"
  exe "normal i" . l:output
endfunction

function! s:EchoWarningMessage(msg) abort
  echohl WarningMsg
  echo a:msg
  echohl None
endfunction

function! s:EchoErrorMessage(msg) abort
  echohl ErrorMsg
  echo a:msg
  echohl None 
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

function! BufferMenuSelect(id,result) abort
  if(a:result < 0)
    return
  endif
  " Menu selection result is 1 based.
  " vim lists are zero based.
  exec "buffer " . s:listedbuffers[a:result - 1]
  unlet s:listedbuffers
endfunction

function! BufferMenu() abort
  let s:listedbuffers = []
  for l:buffer in getbufinfo()
    if l:buffer.listed
      call add(s:listedbuffers,l:buffer.name)
    endif
  endfor
  call popup_menu(s:listedbuffers, #{callback: 'BufferMenuSelect'})
endfunction

function! DialogAtCursor(message) abort
  let l:dialogoptions = {}
  let l:dialogoptions["moved"] = "any"
  call popup_atcursor(a:message,l:dialogoptions) 
endfunction

function! DialogCentered(message) abort
  let l:dialogoptions = {}
  let l:dialogoptions["moved"] = "any"
  call popup_dialog(a:message,l:dialogoptions)
endfunction

function! EvaluateLine() abort
  let l:result = eval(getline("."))
  let l:message = getline(".") . " = " . l:result
  let l:message = trim(l:message)
  call DialogAtCursor(l:message)
endfunction

" Virtual console cursor block
let &t_ve= "\e[?25h\e[?16;143;255c"
