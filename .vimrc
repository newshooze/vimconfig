" Cycle forward and backward through open files
nnoremap <silent> <S-Y> :bnext!<CR>
nnoremap <silent> <S-T> :bprevious!<CR>
" These are annoying
nnoremap <buffer> ( <NOP>
nnoremap <buffer> ) <NOP>
" Control q begins a macro
nnoremap <C-q> q
" Show a file menu
nnoremap <silent> <leader>f :silent! call FileMenu(getcwd())<CR>
" Show a buffer menu
nnoremap <silent> <leader>b :silent! call BufferMenu()<CR>
" Toggle line numbers
nnoremap <leader>n :set number!<CR>
" edit .vimrc
nnoremap <leader>e :edit ~/.vimrc<CR>
" Evaluate a buffer line 
" Example: Hit <leader>= on a line that contains '2+2'
nnoremap <leader>= :silent! call EvaluateLine()<CR>
" (vin)grep word under cursor (v:count1 sets search depth to 1)
" Precede command with a number for further search depth (subdirectories)
" Example: Typing '3<leader>g will search the current dir and 2 below it
nnoremap <silent> <leader>g :call Grep(WordUnderCursor(),getcwd(),v:count1)<CR>
" (vin)grep word under cursor ( All files recursivly (-1 means recursive ))
nnoremap <leader>gr :call Grep(WordUnderCursor(),getcwd(),-1)<CR>
" (vin)grep visual selection (current directory)
vnoremap <silent> <leader>g :<C-U>call Grep(trim(GetVisualText()),getcwd(),v:count1)<CR>
" (vin)grep visual selection (recursive)
vnoremap <silent> <leader>gr :<C-U>call Grep(trim(GetVisualText()),getcwd(),-1)<CR>
" Edit makefile
nnoremap <leader>m :edit makefile<CR>
" Launch terminal with \t ( <leader>t )
nnoremap <leader>t :tab term<CR>
" Start python3
nnoremap <leader>p :!python3<CR>
" Do a REPL on current line (shell command)
nnoremap <leader>R :call RunAsync(getline('.'),{"windowheight":"5"})<CR>
" Do a REPL on visual selection (shell command)
vnoremap <leader>R :<C-U>call RunAsync(trim(GetVisualText()),{"windowheight":"5"})<CR>
" Do a REPL on current line (full screen shell command)
nnoremap <leader>Ro :call RunAsync(getline('.'),{"only":"1"})<CR>
" Do a REPL on visual selection (full screen shell command)
vnoremap <leader>Ro :<C-U>call RunAsync(trim(GetVisualText()),{"only":"1"})<CR>
" Execute vimscript REPL on a line
nnoremap <leader>repl :exe getline(".")<CR>
" Select line
nnoremap vv 0v$o
" Open the Quickfix List
nnoremap q :call ToggleQuickFix()<CR>
" Open the location list
nnoremap <leader>l :lopen 5<CR>:echo<CR>
" Open command line window
nnoremap <leader>c :<C-F>
" Show the current time
nnoremap <leader>C :call Notify(strftime("%c"))<CR>
" Open search history
nnoremap <leader>/ /<C-F>
" Open reverse search history
nnoremap <leader>? ?<C-F>
" Go to help for word under cursor
nnoremap <S-K> :help <C-R><C-W><CR>
" Manual (man) for word under cursor
nnoremap <C-K> :!man <C-r><C-W><CR>
" Escape removes unwanted windows
nnoremap <silent> <ESC> :silent! call KillOutputWindows()<CR>

" These default key combos do too many suprise deletes
nnoremap dn <NOP>
nnoremap cc <NOP>
" quickfix stuff 
nnoremap cn :silent cnext<CR>
nnoremap cp :silent cprevious<CR>
nnoremap cq :copen 5<CR>

tnoremap <ESC> <C-\><C-N>
" Doom style terminal
nnoremap ` :silent call ToggleTerm()<CR>
" Close terminal Doom style
tnoremap ` <C-\><C-N>:bdelete!<CR>

" Close command history window 
" This also closes search history windows
autocmd CmdWinEnter * nnoremap <buffer> <ESC> <ESC>:q<CR>
" Full screen help
autocmd BufEnter * if &bt=="help" | execute ":only" | endif
" Return to previous help topic with 'H
autocmd BufLeave * if &bt=="help" | mark H | endif

" Highlight the search term inside the quickfix window
function! SearchHighlight(color=132) abort
  let l:color = a:color
  execute "highlight SearchMatch ctermfg=" . l:color
  if len(g:grepsearchstring)
    execute "syntax match SearchMatch " . "/" . g:grepsearchstring . "/"
  endif
endfunction

autocmd BufWinEnter quickfix call SearchHighlight()
" Makefile help gcc.txt
autocmd BufRead ~/.vim/dict/gcc.txt setlocal nomodifiable
autocmd BufRead ~/.vim/dict/gcc.txt setlocal filetype=help

" Zighelp zighelp
autocmd BufRead ~/.vim/doc/zig/**/*.zig setlocal nomodifiable
autocmd BufRead ~/.vim/doc/zig/**/*.zig setlocal filetype=zighelp
autocmd BufRead ~/.vim/doc/zig/**/*.zig setlocal syntax=zig

" Zig System libraries 
autocmd BufRead /usr/lib/zig/**/*.zig setlocal nomodifiable
autocmd BufRead /usr/lib/zig/**/*.zig setlocal filetype=zighelp
autocmd BufRead ~/.vim/doc/zig/**/*.zig setlocal syntax=zig

" Zig manual
autocmd BufRead ~/.vim/doc/zig/zigmanual.txt setlocal nomodifiable
autocmd BufRead ~/.vim/doc/zig/zigmanual.txt setlocal filetype=help
autocmd BufRead  ~/.vim/doc/zig/zigmanual.txt setlocal iskeyword+=-

autocmd BufRead ~/.vim/doc/**/*.txt setlocal nomodifiable
autocmd BufRead ~/.vim/doc/**/*.txt setlocal filetype=help

autocmd BufEnter /usr/include/* nnoremap <buffer> <ESC> :bwipeout!<CR>

autocmd BufEnter * if(exists("b:winview")) | call winrestview(b:winview) | endif 
autocmd BufLeave * let b:winview = winsaveview() 

" Move through command line history
cnoremap <C-N> <Up>
cnoremap <C-P> <Down>

syntax on
colorscheme pastel256

let loaded_matchparen=1
set errorformat=%f:%l:%c:%m
set shortmess+=I
set ruler
set nobackup
set noswapfile
set autochdir
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
let s:grepjob = 0
let s:grepresults = 0
let g:grepsearchstring = ""

function! ToggleTerm() abort
  if &buftype == "terminal"
    bdelete!
  else
    tab term 
  endif
endfunction

function! GetVisualText()
  " Enter normal mode
  " Go to the previous selection
  " Paste the selection into register 'v'
  " Go to the previous selection
  " This clobbers the 'v' register
  normal! gv"vygv
  return @v
endfunction

function! KillOutputWindows()
  silent lclose " Close location list
  silent cclose " Close quickfix window
  call popup_close(s:runpopup)
  " Close ALL popups (popup_clear)
  call popup_clear(1)
  silent! execute "bwipeout! makeoutput"
  silent! execute "bwipeout! runoutput"
  silent! execute "bwipeout! assemblyoutput"
  silent! execute "bwipeout! grepoutput"
  silent! execute "KillGrepJob()"
endfunction

function! RunAsyncJobFunction(channel,msg) abort
  if bufexists("runoutput")
    let l:runwindownumber = bufwinnr("runoutput")
    let l:runwindowid = win_getid(l:runwindownumber)
  endif
endfunction

function! RunAsyncExitFunction(job,status) abort
endfunction

function! RunAsync(arglist,optionsdictionary={}) abort
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
  let l:joboptions["callback"] = function("RunAsyncJobFunction")
  let l:joboptions["exit_cb"] = function("RunAsyncExitFunction")
  let s:runasyncjob = job_start(l:programargs,l:joboptions)
  let l:position = get(a:optionsdictionary,"position","botright")
  let l:windowheight =  get(a:optionsdictionary,"windowheight","5")
  let l:only = get(a:optionsdictionary,"only","0")
  execute l:position . " " . l:windowheight . "split runoutput"
  if l:only
    execute "only"
  else
    execute "wincmd p"
  endif
endfunction

function! RunAsyncInPopupFunction(channel,msg) abort
  call add(s:popupoutputtext,a:msg)
  call popup_settext(s:runpopup,s:popupoutputtext)
  silent call win_execute(s:runpopup,"normal G0")
endfunction

" TODO - Implement command! -range for popup height
function! RunAsyncInPopup(arglist,optionsdictionary={}) abort
  call KillOutputWindows()
  let l:programargs = a:arglist
  let l:joboptions = {}
  let l:joboptions["out_msg"] = "0"
  let l:joboptions["err_msg"] = "0"
  let l:joboptions["callback"] = function("RunAsyncInPopupFunction")
  let s:runpopup = popup_create('', #{
  \ pos: "botleft",
  \ title: "",
  \ border: [0,0,0,0],
  \ padding: [0,0,0,0],
  \ line: &lines,
  \ col: 0,
  \ minheight: 5,
  \ maxheight: 5,
  \ scrollbar: 1,
  \ minwidth: &columns,
  \ maxwidth: &columns,
  \ close: "none",
  \ wrap: "FALSE",
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
" TODO: add options dictionary
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
  execute "wincmd p"
endfunction

" This doesn't work
function! KillGrepJob() abort
  if job_status(s:grepjob) == "run"
    call job_stop(s:grepjob,"kill")
  endif
  unlet s:grepjob
endfunction

function! GrepExitFunction(job,status) abort
endfunction

function! GrepJobFunction(channel,msg) abort
  let s:grepresults = s:grepresults + 1
  caddexpr a:msg
  cbottom
endfunction

" Default parameters in Vim 8xx only
function! Grep(pattern,directory=".",depth=1) abort
  silent wall
  call KillOutputWindows()
  let l:joboptions = {}
  let l:joboptions["out_msg"] = "0"
  let l:joboptions["err_msg"] = "0"
  let l:joboptions["callback"] = function("GrepJobFunction")
  let l:joboptions["exit_cb"] = function("GrepExitFunction")
  cexpr ""
  silent execute "copen " s:quickfixsize
  wincmd p
  if executable("vingrep")
    set errorformat=%f:%l:%c:%m
    let l:command = ["vingrep",a:pattern,a:directory,a:depth]
  else
    set errorformat=%f:%l:%m
    " This is slow
    let l:command = ["find",a:directory,"-type","f","-maxdepth",a:depth,"-exec","grep","-niIHF",a:pattern,"{}","\;"]
    "let l:command = 'bash -c "for FILE in $(ls -a); do grep ' . '-niIsHRF' . ' ' . a:pattern . ' ' . '"$FILE";done"'
  endif
  let g:grepsearchstring = a:pattern
  let s:grepjob = job_start(l:command,l:joboptions)
endfunction

function! ObjDump(objectfile) abort
  enew
  execute "read !objdump -d " . a:objectfile
  set ft=asm
endfunction

function! AssemblyOutput() abort
  silent wall
  " Close any existing quickfix and make buffers
  call KillOutputWindows()
  let l:sourcefile = expand("%:t")
  let l:sourcefileextension = expand("%:e")
  let l:compiler = "gcc"
  if l:sourcefileextension == "cpp"
    let l:compiler = "g++"
  endif
  let l:command = [
  \ l:compiler,
  \ "-S",
  \ "-O3",
  \ "-Wall",
  \ "-mavx",
  \ "-Wextra",
  \ "-fno-rtti",
  \ "-march=native",
  \ "-mtune=native",
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
  execute "vsplit assemblyoutput"
  execute "only"
  execute "set filetype=asm"
endfunction

function! EatSpace() abort
  let c = nr2char(getchar(0))
  return (c =~ "\s") ? "" : c
endfunction

" Used for completion in c/c++ files
function! Abbreviation(text) abort
  let l:line = getline(".")
  call setline(".",strpart(line,0,col(".")-1) . a:text . strpart(line,col(".") -1))
  call EatSpace()
  normal f(ll
  stopinsert
  return "" 
endfunction

function! TrimTrailingWhitespace() abort
  %s!\s\+$!!g
endfunction

function! WordUnderCursor() abort
  return expand("<cword>")
endfunction

function! BinaryToDecimal(word)
  return str2nr(a:word,2)
endfunction

function! OctalToDecimal(word)
  return str2nr(a:word,8)
endfunction

function! HexToDecimal(word)
  return str2nr(a:word,16)
endfunction

function! DecimalToBinary(word)
  return printf("%08b",a:word)
endfunction
function! DecimalToOctal(word)
  return printf("%o",a:word)
endfunction
function! DecimalToHex(word)
  return printf("0x%x",a:word)
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

function! EchoWarningMessage(msg) abort
  echohl WarningMsg
  echo a:msg
  echohl None
endfunction

function! EchoErrorMessage(msg) abort
  echohl ErrorMsg
  echo a:msg
  echohl None 
endfunction

function! ColorDemo() abort
  for n in range(0,255)
    execute "hi ColorDemo ctermfg=".n." ctermbg=".n
    echon printf("%3d",n)
    echohl ColorDemo
    echon "XXX"
    echohl NONE
    if (n+1) % 16 == 0
      echo ""
    endif
  endfor
endfunction

function! FileMenuCD(newroot="..") abort
  let l:cwd = getcwd()
  call chdir(s:filemenuroot)
  call chdir(a:newroot)
  let s:filemenuroot = getcwd()
  call chdir(l:cwd)
endfunction

function! FileMenuSelect(id,result) abort
  if a:result < 1
    return
  endif
  " Menu selection result is ONE based
  let l:file = "" . s:filemenufiles[a:result - 1]
  if isdirectory(l:file)
    if l:file == ".."
      " Go up one directory (..)
      call FileMenuCD()
    else
      " Go down one directory (l:file)
      call FileMenuCD(l:file)
    endif
    call FileMenu(s:filemenuroot)
    return
  endif
  execute "edit " . l:file
  unlet s:filemenufiles
endfunction

function! FileMenuKeyInputFilter(windowid,keystring) abort
  "echo a:keystring
  if a:keystring == "\<ESC>"
    call popup_close(a:windowid,-1)
  endif
  if a:keystring == "\<CR>"
    call popup_close(a:windowid,line('.',a:windowid))
  endif
  if a:keystring == "\<BS>"
    call popup_close(a:windowid,-1)
    call FileMenuCD()
    call FileMenu(s:filemenuroot)
  endif
  let l:validkeys = ["j","k","\<UP>","\<DOWN>","\<C-N>","\<C-P>"]
  for l:validkey in l:validkeys
    if a:keystring == l:validkey
      let l:normalcommand = "normal! " . a:keystring
      call win_execute(a:windowid,l:normalcommand)
    endif
  endfor
  return 1 
endfunction

function! FileMenu(directory,menuoptions={}) abort
  let s:filemenuroot = a:directory
  let l:command = "find " . a:directory . " -maxdepth 1"
  let s:filemenufiles= systemlist(l:command)
  call insert(s:filemenufiles,"..")
  let l:index = 0
  for s:filemenufile in s:filemenufiles
    if s:filemenufile == s:filemenuroot
      call remove(s:filemenufiles,l:index)
    endif
    let l:index = l:index + 1
  endfor
  let l:maxfilepathlength = 0
  for l:file in s:filemenufiles
    let l:filepathlength = strlen(l:file) 
    if l:filepathlength > l:maxfilepathlength
      let l:maxfilepathlength = l:filepathlength
    endif
  endfor
  let l:menuoptions = {}
  let l:menuoptions["callback"] = function("FileMenuSelect")
  let l:menuoptions["maxheight"] = &lines - 4 
  let l:menuoptions["minheight"] = 1
  let l:menuoptions["minwidth"] = l:maxfilepathlength + 4
  let l:menuoptions["title"] = s:filemenuroot
  let l:menuoptions["filtermode"] = "a"
  let l:menuoptions["filter"] = function("FileMenuKeyInputFilter")
  let l:menuoptions["mapping"] = 0
  if len(s:filemenufiles)
    call sort(s:filemenufiles)
    call popup_menu(s:filemenufiles,l:menuoptions)
  endif
endfunction

function! BufferMenuSelect(id,result) abort
  if a:result < 1
    return
  endif
  " Menu selection result is ONE based.
  " Remove any space or asterisks at the beginning of buffer name
  let l:buffername = trim(s:listedbuffers[a:result -1],"* ",1)
  execute "buffer! " . l:buffername
  unlet s:listedbuffers
endfunction

function! BufferMenu() abort
  let s:listedbuffers = []
  let l:maxbufferstringlength = 0
  call KillOutputWindows()
  for l:buffer in getbufinfo()
    if l:buffer.listed
      let l:bufferstringlength = strlen(l:buffer.name)
      if l:bufferstringlength > l:maxbufferstringlength
        let l:maxbufferstringlength = l:bufferstringlength
      endif
      if l:buffer.bufnr == bufnr()
        " Put an asterisk next to the current buffer
        call add(s:listedbuffers,"* " . l:buffer.name)
      else
        call add(s:listedbuffers,"  " . l:buffer.name)
      endif
    endif
  endfor
  let l:menuoptions = {}
  let l:menuoptions["callback"] = function('BufferMenuSelect')
  let l:menuoptions["maxheight"] = &lines - 4
  let l:menuoptions["minheight"] = 1
  let l:menuoptions["minwidth"] = l:maxbufferstringlength + 2
  call popup_menu(s:listedbuffers,l:menuoptions)
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

function! Notify(message,notifyoptions={}) abort
  let l:messagewidth = len(a:message)
  let l:notifyoptions = {}
  let l:notifyoptions["time"] = 4000
  let l:notifyoptions["minwidth"] = l:messagewidth
  let l:notifyoptions["col"] = &columns - l:messagewidth - 20
  let l:notifyoptions["line"] = 8
  call popup_notification(a:message,l:notifyoptions)
endfunction

function! EvaluateLine() abort
  let l:result = eval(getline("."))
  let l:message = getline(".") . " = " . l:result
  let l:message = trim(l:message)
  call DialogAtCursor(l:message)
endfunction

function! QuickFixVisible() abort
  let wins = filter(getwininfo(), "v:val.quickfix && !v:val.loclist")
  return empty(wins) ? 0 : 1
endfunction

function! ToggleQuickFix() abort
  if QuickFixVisible()
    cclose
  else
    execute "copen " . s:quickfixsize
  endif
endfunction
