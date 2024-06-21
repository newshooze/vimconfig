" Cycle forward and backward through open files
nnoremap <silent> <S-Y> :bnext!<CR>
nnoremap <silent> <S-T> :bprevious!<CR>
" These are annoying
nnoremap <buffer> ( <NOP>
nnoremap <buffer> ) <NOP>
" Show a buffer menu
nnoremap <silent> <leader>b :silent! call BufferMenu()<CR>
" Open command line window
nnoremap <silent> <leader>c :<C-F>
" Show the current time
nnoremap <silent> <leader>C :silent! call Notify(strftime("%c"))<CR>
" edit .vimrc
nnoremap <silent> <leader>e :edit ~/.vimrc<CR>
" Show a file menu
nnoremap <silent> <leader>f :silent! call FileMenu(getcwd())<CR>
" (vin)grep word under cursor (v:count1 sets search depth to 1)
" Precede command with a number for further search depth (subdirectories)
" Example: Typing '3<leader>v will search the current dir and 2 below it
nnoremap <silent> <leader>g :call Grep(expand("<cword>"),getcwd(),v:count1)<CR>
" (vin)grep word under cursor ( All files recursivly (-1 means recursive ))
nnoremap <silent> <leader>G :call Grep(expand("<cword>"),getcwd(),-1)<CR>
" (vin)grep visual selection (current directory)
vnoremap <silent> <leader>g :<C-U>call Grep(trim(GetVisualText()),getcwd(),v:count1)<CR>
" (vin)grep visual selection (recursive)
vnoremap <silent> <leader>G :<C-U>call Grep(trim(GetVisualText()),getcwd(),-1)<CR>
" Edit makefile
nnoremap <silent> <leader>m :edit makefile<CR>
" Toggle line numbers
nnoremap <silent> <leader>n :silent! call CycleNumber()<CR>
" Start python3
nnoremap <silent> <leader>p :tab term python3<CR>
" Open the Quickfix List
nnoremap <silent> q :silent! call ToggleQuickFix()<CR>
" Control q begins a macro
nnoremap <silent> <C-q> q
" Do a REPL on current line (shell command)
nnoremap <silent> <leader>R :silent! call RunAsync(getline('.'),{"windowheight":"5"})<CR>
" Do a REPL on visual selection (shell command)
vnoremap <silent> <leader>R :<C-U>call RunAsync(trim(GetVisualText()),{"windowheight":"5"})<CR>
" Do a REPL on current line (full screen shell command)
nnoremap <silent> <leader>Ro :silent! call RunAsync(getline('.'),{"only":"1"})<CR>
" Do a REPL on visual selection (full screen shell command)
vnoremap <silent> <leader>Ro :<C-U>call RunAsync(trim(GetVisualText()),{"only":"1"})<CR>
" Execute vimscript REPL on a line
nnoremap <silent> <leader>repl :execute getline(".")<CR>
" Select line
nnoremap vv 0v$o
" Open search history
nnoremap <silent> <leader>/ /<C-F>
" Open reverse search history
nnoremap <silent> <leader>? ?<C-F>
" Go to help for word under cursor
nnoremap <silent> <S-K> :help <C-R><C-W><CR>
" Manual (man) for word under cursor
nnoremap <silent> <C-K> :!man <C-r><C-W><CR>
" Escape removes unwanted windows
nnoremap <silent> <ESC> :silent! call KillOutputWindows()<CR>
" Evaluate a buffer line 
" Example: Hit <leader>= on a line that contains '2+2'
nnoremap <silent> <leader>= :silent! call EvaluateLine()<CR>
nnoremap <silent> <C-UP> :resize +1<CR>
nnoremap <silent> <C-DOWN> :resize -1<CR>
nnoremap <silent> <C-LEFT> :vertical resize -1<CR>
nnoremap <silent> <C-RIGHT> :vertical resize +1<CR>

" These default key combos do too many suprise deletes
nnoremap dn <NOP>
nnoremap cc <NOP>
" quickfix stuff 
nnoremap <silent> cn :silent! cnext<CR>
nnoremap <silent> cp :silent! cprevious<CR>
nnoremap <silent> cq :silent! call GoToQuickfix()<CR>

tnoremap <ESC> <C-\><C-N>
" Doom style terminal
nnoremap <silent> ` :silent call ToggleTerminal()<CR>
" Close terminal Doom style
tnoremap <silent> ` <C-\><C-N>:bdelete!<CR>


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
" This fixes a bug/feature in quickfix placemant
autocmd BufWinEnter quickfix resize+1 | resize-1

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
cabbrev az a-zA-Z0-9_-

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
set switchbuf=useopen
" Make escape work instantly
set ttimeoutlen=10

filetype plugin on

let g:loaded_matchparen=1
let s:quickfixsize = 5
let s:locationlistsize = 5
let s:runpopup = 0
let s:runoutputtext = []
let s:popupoutputtext = []
let s:grepjob = 0
let s:grepresults = 0
let g:grepsearchstring = ""

function! CycleNumber() abort
  if !&number && !&relativenumber
    set number
  elseif !&relativenumber
    set relativenumber
  else
    set nonumber
    set norelativenumber
  endif
endfunction

function! ToggleTerminal() abort
  if &buftype == "terminal"
    bdelete!
  else
    tab terminal
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
  call KillQuickfix()
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
  let l:joboptions["out_msg"] = get(a:optionsdictionary,"out_msg","0")
  let l:joboptions["err_msg"] = get(a:optionsdictionary,"err_msg","0")
  let l:joboptions["out_io"] = get(a:optionsdictionary,"out_io","buffer")
  let l:joboptions["err_io"] = get(a:optionsdictionary,"err_io","buffer")
  let l:joboptions["out_name"] = get(a:optionsdictionary,"out_name","runoutput")
  let l:joboptions["err_name"] = get(a:optionsdictionary,"err_name","runoutput")
  let l:joboptions["callback"] = get(a:optionsdictionary,"callback",function("RunAsyncJobFunction"))
  let l:joboptions["exit_cb"] = get(a:optionsdictionary,"exit_cp",function("RunAsyncExitFunction"))
  let s:runasyncjob = job_start(l:programargs,l:joboptions)
  let l:filetype = get(a:optionsdictionary,"filetype","")
  let l:syntax = get(a:optionsdictionary,"syntax","text")
  let l:position = get(a:optionsdictionary,"position","botright")
  let l:windowheight =  get(a:optionsdictionary,"windowheight","5")
  let l:only = get(a:optionsdictionary,"only","0")
  execute l:position . " " . l:windowheight . "split runoutput"
  if len(l:filetype)
    execute "set filetype=" . l:filetype
  endif
  execute "setlocal syntax=" . l:syntax
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

function! RunAsyncInPopup(arglist,optionsdictionary={}) abort
  call KillOutputWindows()
  let l:programargs = a:arglist
  let l:joboptions = {}
  let l:joboptions["out_msg"] = get(a:optionsdictionary,"out_msg","0")
  let l:joboptions["err_msg"] = get(a:optionsdictionary,"err_msg","0")
  let l:joboptions["callback"] = get(a:optionsdictionary,"callback",function("RunAsyncInPopupFunction"))
  let s:runpopup = popup_create('', #{
  \ pos: get(a:optionsdictionary,"pos","botleft"),
  \ title: get(a:optionsdictionary,"title",""),
  \ border: get(a:optionsdictionary,"border",[0,0,0,0]),
  \ padding: get(a:optionsdictionary,"padding",[0,0,0,0]),
  \ line: get(a:optionsdictionary,"line",&lines),
  \ col: get(a:optionsdictionary,"col",0),
  \ minheight: get(a:optionsdictionary,"minheight",5),
  \ maxheight: get(a:optionsdictionary,"maxheight",5),
  \ scrollbar: get(a:optionsdictionary,"scrollbar",1),
  \ minwidth: get(a:optionsdictionary,"minwidth",&columns),
  \ maxwidth: get(a:optionsdictionary,"maxwidth",&columns),
  \ close: get(a:optionsdictionary,"close","none"),
  \ wrap: get(a:optionsdictionary,"wrap","FALSE")
  \ })
  let s:runinpopupjob = job_start(l:programargs,l:joboptions)
  let s:popupoutputtext = []
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
  if executable("vingrep3")
    set errorformat=%f:%l:%c:%m
    let l:command = ["vingrep3",a:pattern,a:directory,a:depth]
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
  set filetype=asm
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

function! FileMenu(directory,optionsdictionary={}) abort
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
  let l:menuoptions["callback"] = get(a:optionsdictionary,"callback",function("FileMenuSelect"))
  let l:menuoptions["maxheight"] = get(a:optionsdictionary,"maxheight",&lines - 4)
  let l:menuoptions["minheight"] = get(a:optionsdictionary,"minheight",1)
  let l:menuoptions["minwidth"] = get(a:optionsdictionary,"minwidth",l:maxfilepathlength + 4)
  let l:menuoptions["title"] = get(a:optionsdictionary,"title",s:filemenuroot)
  let l:menuoptions["filtermode"] = get(a:optionsdictionary,"filtermode","a")
  let l:menuoptions["filter"] = get(a:optionsdictionary,"filter",function("FileMenuKeyInputFilter"))
  let l:menuoptions["mapping"] = get(a:optionsdictionary,"mapping",0)
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

function! DialogAtCursor(message,dialogoptions={}) abort
  let l:dialogoptions = {}
  let l:dialogoptions["moved"] = "any"
  call popup_atcursor(a:message,l:dialogoptions) 
endfunction

function! DialogCentered(message,dialogoptions={}) abort
  let l:dialogoptions = {}
  let l:dialogoptions["moved"] = "any"
  call popup_dialog(a:message,l:dialogoptions)
endfunction

function! Notify(message,notifyoptions={}) abort
  let l:messagewidth = len(a:message)
  let l:notifyoptions = {}
  let l:notifyoptions["time"] = get(a:notifyoptions,"time",4000)
  let l:notifyoptions["minwidth"] = get(a:notifyoptions,"minwidth",l:messagewidth)
  let l:notifyoptions["col"] = get(a:notifyoptions,"col",&columns - l:messagewidth - 20)
  let l:notifyoptions["line"] = get(a:notifyoptions,"line",2)
  call popup_notification(a:message,l:notifyoptions)
endfunction

function! EvaluateLine() abort
  let l:result = eval(getline("."))
  let l:message = getline(".") . " = " . l:result
  let l:message = trim(l:message)
  call DialogAtCursor(l:message)
endfunction

function! KillQuickfix() abort
  if &buftype ==# "quickfix"
    if winnr("$") < 2
      quit!
    endif
  else
    silent cclose
  endif
endfunction

function! QuickFixVisible() abort
  let wins = filter(getwininfo(), "v:val.quickfix && !v:val.loclist")
  return empty(wins) ? 0 : 1
endfunction

function! ToggleQuickFix() abort
  if QuickFixVisible()
    call KillQuickfix()
  else
    execute "copen " . s:quickfixsize
  endif
endfunction

function! GoToQuickfix() abort
  if QuickFixVisible()
    call KillQuickfix()
    call ToggleQuickFix()
  else
    call ToggleQuickFix()
  endif
endfunction

function! CenterBuffer() abort
  let l:linelist = []
  let l:linelist = GetBufferAsList()
  call CenterListText(l:linelist)
  call SetBufferWithList(l:linelist)
endfunction

function! SetBufferWithList(linelist=[]) abort
  let l:index = 1
  for l:line in a:linelist
    call setline(l:index,l:line)
    let l:index = l:index + 1
  endfor
endfunction

function! GetBufferAsList() abort
  let l:index = 1
  let l:linelist = getline(1,&lines)
  return l:linelist
endfunction

" Center a list of strings based on the longest line
function! CenterListText(lines=[''],columns=&columns) abort
  let l:maxline = 0
  let l:columns = a:columns
  let l:lines = []
  let l:lines = a:lines
  for l:line in a:lines
    let l:linelen = len(l:line)
    if l:linelen > l:maxline
      let l:maxline = l:linelen
      if l:maxline > l:columns
        return a:lines
      endif
    endif
  endfor
  let l:indent = (l:columns / 2) - (l:maxline / 2)
  let l:index = 0
  for l:line in a:lines
    let l:line = repeat(' ',l:indent) . l:line
    let l:lines[l:index] = l:line
    let l:index = l:index + 1
  endfor
  return l:lines
endfunction
