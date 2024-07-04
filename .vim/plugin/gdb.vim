let s:DEBUGGERNAME = "gdb"
let s:DEBUGGERARGS = " -f --quiet --readnow "
let s:EXECUTABLE = "" 
let s:EXECUTABLEARGS = ""
let s:CHANNELTIMEOUT = 10
let s:STARTIMMEDIATLY = 1
let s:variablesid = 0
let s:variablesbufnr = 0
let s:variablesbufname = 0
let s:assemblyid = 0
let s:assemblybufnr = 0
let s:assemblybufname = 0
let s:gdbjob = 0
let s:gdbchannel = 0
let s:gdbinputid = 0
let s:gdboutputid = 0
let s:gdboutputbufnr = 0
let s:gdbinputbufnr = 0
let s:gdbinputbufname = ''
let s:gdboutputbufname = ''
let s:parsinginfolocals = 0
let s:parsingptype = 0
let s:parsemode = 0
let s:commandhistory= []
let s:commandhistoryindex = 0
let s:lastcommand = ""
let s:pythondefs = []

function! ClearGDBOutput()
  call win_gotoid(s:gdboutputid)
  call win_execute(s:gdboutputid,"normal ggdG")
  call win_gotoid(s:gdbinputid)
endfunction

function! ConsumeChannelMessages()
  let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  while len(l:message)
    let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  endwhile
endfunction

function! AddToHistory(command)
  for cmd in s:commandhistory 
    if cmd == a:command
      return
    endif
  endfor
  call add(s:commandhistory,a:command)
endfunction

" this is broken
function! RecallHistory()
  let l:line = getbufline(s:gdbinputbufname,1)
  call setbufline(s:gdbinputbufname,1,"")
  try
    call setbufline(s:gdbinputbufname,1,s:gdbinputhistory[s:gdbinputhistoryindex]) 
    let s:gdbinputhistoryindex = s:gdbinputhistoryindex - 1
  catch "/.*/"
    call setbufline(s:gdbinputbufname,1,l:line)
  endtry
  normal a
endfunction

function! InputSent()
  let l:line = getline(expand('.'))
  if !len(l:line)
    if len(s:lastcommand)
      let l:line = s:lastcommand
    endif
  endif
  call ch_sendraw(s:gdbjob,l:line . "\n")
  call ConsumeChannelMessages()
  call UpdatePC()
  call AddToHistory(l:line)
  call setbufline(s:gdbinputbufname,1,"")
endfunction

function! CloseAll()
  silent! call timer_stopall()
  silent! call job_stop(s:gdbjob,"kill")
  call win_gotoid(s:assemblyid)
  bd!
  call win_gotoid(s:variablesid)
  bd!
  call win_gotoid(s:gdbinputid)
  bd!
  call win_gotoid(s:gdboutputid)
  bd!
  call win_gotoid(s:sourceid)
  set nocursorline
endfunction

function! GetFileName()
  let l:filename = ""
  call ch_sendraw(s:gdbjob,"info source" .. "\n")
  let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  while len(l:message)
    if l:message =~ "Located in "
      let l:filename = substitute(l:message,"Located in ","","")
      if filereadable(l:filename)
      else
        let l:filename = ""
      endif
    endif
    let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  endwhile
  return l:filename
endfunction

function! GetLineNumber()
  let l:linenumber = ""
  call ch_sendraw(s:gdbjob,"info line" .. "\n")
  let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  while len(l:message)
    if l:message =~ "Line "
      let l:message = substitute(l:message,"(gdb) ","","")
      let l:message = substitute(l:message,"Line ","","")
      let l:message = substitute(l:message,"\(^\[0-9\]*\).*","\1","")
      if l:message
        let l:linenumber = l:message
      endif
    endif
    " consume remaining messages
    let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  endwhile
  return l:linenumber
endfunction

function! UpdatePC()
  call ConsumeChannelMessages()
  let l:linenumber = GetLineNumber()
  let l:filename = GetFileName()
  if len(l:linenumber) && len(l:filename)
    call UpdateSourceLine(l:filename,l:linenumber)
    call InfoLocals()
  endif
  call Disassemble()
endfunction

function! Next() " next line
  call ch_sendraw(s:gdbjob,"next" .. "\n")
  call UpdatePC()
endfunction

function! StepInto() " step into
  call ch_sendraw(s:gdbjob,"step" .. "\n")
  call UpdatePC()
endfunction

function! StepOut()
  call ch_sendraw(s:gdbjob,"finish" .. "\n")
  call UpdatePC()
endfunction

function! Continue()
  call ch_sendraw(s:gdbjob,"continue" .. "\n")
  call UpdatePC()
endfunction

function! UpdateSourceLine(filename,linenumber)
  call win_gotoid(s:sourceid)
  execute "edit " . a:filename
  setlocal cursorline
  highlight default CursorLine cterm=reverse ctermbg=darkblue
  call setpos(".",[bufnr(0),a:linenumber,1,1,1])
  normal zz
  call win_gotoid(s:gdbinputid)
endfunction

function! SetBreakpointInFile(file,line)
  call ch_sendraw(s:gdbchannel,"break " . a:file . ":" . a:line
endfunction

function! GDBCloseCallback(channel)
endfunction

function! GDBExitCallback(job,exitstatus)
  " TODO: close all windows here
endfunction

function! GDBCallback(channel,msg)
  " TODO Use this callback only for breakpoints
  call AppendGDBOutput(a:channel,a:msg)
endfunction

function! AppendGDBOutput(channel,msg)
  if !bufexists("GDBOutput")
    return
  endif
  let l:msg = substitute(a:msg,'(gdb) ','','')
  call appendbufline(s:gdboutputbufname,"$",l:msg)
  call win_execute(s:gdboutputid,"normal G")
endfunction

function! ChannelSendRaw(string)
  if ch_status(s:gdbjob) == "fail" || ch_status(s:gdbjob) == "close"
    return
  endif
  call ch_sendraw(s:gdbjob,a:string .. "\n")
endfunction

function! GetType(varname)
  call ch_sendraw(s:gdbjob,"ptype " . a:varname)
  let l:message = ch_read(s:gdbjob,{"timeout":0})
endfunction

function! InfoLocals()
  if ch_status(s:gdbjob) == "fail" || ch_status(s:gdbjob) == "close"
    return
  endif
  call ch_sendraw(s:gdbjob,"python print(Locals())" .. "\n")
  let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  if len(l:message)
    call win_execute(s:variablesid,"normal ggdG")
  else
    return
  endif
  while len(l:message)
    let l:message = substitute(l:message,"(gdb) ","","g")
    call appendbufline(s:variablesbufname,"$",l:message)
    let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  endwhile
  call win_gotoid(s:gdbinputid)
endfunction

function! InfoLocalsDepricated()
  if ch_status(s:gdbjob) == "fail" || ch_status(s:gdbjob) == "close"
    return
  endif
  let l:vars = []
  let l:vals = []
  call ch_sendraw(s:gdbjob, "info locals" .. "\n")
  let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  if len(l:message)
    call win_execute(s:variablesid,"normal ggdG")
  else
    return
  endif
  let l:message = substitute(l:message,"(gdb) ","","g")
  while len(l:message)
    if l:message =~ ".*=.*"
      call add(l:vars,substitute(l:message," =.*","",""))
      call add(l:vals,substitute(l:message,".*=","",""))
    endif
    let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  endwhile
  let l:index = 0
  for var in l:vars
    call ch_sendraw(s:gdbjob,"ptype " . trim(var) .. "\n")
    let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
    let l:message = substitute(l:message,"(gdb) ","","g")
    let l:type = substitute(l:message,"type =\\(.*\\).*$","\\1","")
    let l:type = trim(l:type)
    " parse complex type
    if l:type =~ "{"
      let l:type = substitute(l:type," {","","")
      while len(l:message)
        if l:type =~ "}"
          break
        endif
        "call appendbufline(s:variablesbufname,"$",l:type)
        let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
      endwhile
    " simple value
    else
      call appendbufline(s:variablesbufname,"$",l:type . "  " . trim(var) . " = " . l:vals[l:index]) 
    endif
    let l:index = l:index + 1
  endfor
  call win_execute(s:variablesid,"normal G")
endfunction

function! Disassemble()
  let l:functionname = ""
  let l:functionmatch = "Dump of assembler code for function "
  let l:endmatch = "End of.*"
  call win_execute(s:assemblyid,"normal ggdG")
  call ch_sendraw(s:gdbjob,"disassemble" .. "\n")
  let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  while len(l:message)
    let l:message = substitute(l:message,"(gdb) ","","")
    if len(l:message)
      if l:message =~ l:functionmatch
        let l:functionname = substitute(l:message,l:functionmatch,"","")
        let l:functionname = substitute(l:functionname,":","","g")
        call win_gotoid(s:assemblyid)
        silent! call execute("setlocal statusline=Disassembly\\ of\\ function:\\ " . l:functionname,"silent!")
        let s:assemblybufname = bufname(winbufnr(0))
      else
        if l:message !~# l:endmatch
          if len(l:message)
            call appendbufline(s:assemblybufname,"$",l:message)
          endif
        endif
      endif
    endif
    let l:message = ch_read(s:gdbjob,{"timeout":s:CHANNELTIMEOUT})
  endwhile
  silent! call win_execute(s:assemblyid,"normal /^=>\<CR>","silent!")
  call win_gotoid(s:gdbinputid)
endfunction

function CreateWindows()
  let s:sourceid = win_getid()
  let s:sourcenr = winbufnr(0)
  let s:sourcebufname = bufname(winbufnr(0))
  call win_gotoid(s:sourceid)
  setlocal cursorline
  highlight default CursorLine cterm=reverse ctermbg=darkblue

  botright vsplit Variables
  let s:variablesid = win_getid()
  let s:variablesbufnr = winbufnr(0)
  let s:variablesbufname = bufname(winbufnr(0))
  setlocal nomodified
  setlocal nobuflisted

  split Disassembly
  let s:assemblyid = win_getid()
  let s:assemblybufnr = winbufnr(0)
  let s:assemblybufname = bufname(winbufnr(0))
  setlocal nomodified
  setlocal nobuflisted
  setlocal filetype=asm

  call win_gotoid(s:sourceid)

  botright 2new GDBOutput
  let s:gdboutputid = win_getid()
  let s:gdboutputbufnr = winbufnr(0)
  let s:gdboutputbufname = bufname()
  setlocal nomodified
  setlocal nobuflisted

  vsplit GDBInput
  let s:gdbinputid = win_getid()
  let s:gdbinputbufnr = winbufnr(0)
  let s:gdbinputbufname = bufname()
  set nomodified
  set dictionary=gdb.vim
  set complete+=k
  nnoremap <buffer> n in
  nnoremap <buffer> s is
  call win_gotoid(s:gdbinputid)
  normal dd
  startinsert

  for l:window in [s:sourceid,s:gdbinputid,s:assemblyid,s:variablesid,s:gdboutputid]
    call win_gotoid(l:window)
    inoremap <buffer> <F5> <ESC>:call Continue()<CR>
    nnoremap <buffer> <F5> <ESC>:call Continue()<CR>
    inoremap <silent> <buffer> <S-F5> <ESC>:silent! call CloseAll()<CR>
    nnoremap <silent> <buffer> <S-F5> :silent! call CloseAll()<CR>
    inoremap <buffer> <F7> <ESC>:call StepInto()<CR>
    nnoremap <buffer> <F7> <ESC>:call StepInto()<CR>
    inoremap <buffer> <S-F7> <ESC>:call StepOut()<CR>
    nnoremap <buffer> <S-F7> <ESC>:call StepOut()<CR>
    inoremap <buffer> <F8> <ESC>:call Next()<CR>
    nnoremap <buffer> <F8> <ESC>:call Next()<CR>
    inoremap <buffer> <F9> <ESC>:call ToggleBreakpoint()<CR>
    nnoremap <buffer> <F9> <ESC>:call ToggleBreakpoint()<CR>
    inoremap <buffer> <F12> <ESC>:call Disassemble()<CR>
    inoremap <buffer> <UP> <ESC>:call RecallHistory()<CR>
    inoremap <buffer> <CR> <ESC>:call InputSent()<CR>
    nnoremap <buffer> n in
    nnoremap <buffer> s is
  endfor

endfunction

function StartGDBJob()
  let s:debuggername = s:DEBUGGERNAME
  let s:debuggerargs = s:DEBUGGERARGS
  let s:programname = s:EXECUTABLE
  let s:programargs = s:EXECUTABLEARGS
  let s:jobcommand = [s:debuggername,s:debuggerargs,'--args',s:programname,s:programargs]
  let s:joboptions = {}
  let s:joboptions['exit_cb'] = function('GDBExitCallback')
  let s:joboptions['out_mode'] = "nl"
  let s:joboptions['close_cb'] = function('GDBCloseCallback')
  let s:joboptions['callback'] = function('GDBCallback')
  let s:gdbjob = job_start(s:jobcommand,s:joboptions)
  let s:gdbchannel = job_getchannel(s:gdbjob)
endfunction


function! LoadPythonCode()
let s:pythondefs =<< PYCODE
python

def GetBasicType(value):
    basictype = gdb.types.get_basic_type(value.type)
    if basictype.code == gdb.TYPE_CODE_PTR:
        basictype = gdb.types.get_basic_type(basictype.target())
    return basictype

def Locals():
  try:
    frame = gdb.selected_frame()
    block = frame.block()
  except:
    return ''
  result = ''
  while block and not (block.is_global or block.is_static):
    for symbol in block:
      if (symbol.is_argument or symbol.is_variable or symbol.is_constant):
        symbolvalue = gdb.parse_and_eval(symbol.name)
        symboltype = gdb.types.get_basic_type(symbolvalue.type)
        result = result + symbol.name 
        result = result + ' = ' 
        result = result + "" + symbolvalue.format_string() + "\n" 
    block = block.superblock
  return result
end
PYCODE

for s:pythonline in s:pythondefs
  call ch_sendraw(s:gdbjob,s:pythonline .. "\n")
endfor

endfunction


function! Init()
  call CreateWindows()
  call StartGDBJob()
  call LoadPythonCode()
  call ch_sendraw(s:gdbjob,"start" .. "\n")
  let s:canread = ch_canread(s:gdbjob)
  let s:counter = 0
  while !s:canread && s:counter < 100
    sleep 50m
    let s:counter = s:counter + 1
    let s:canread = ch_canread(s:gdbjob)
  endwhile
  call ConsumeChannelMessages()
  call ClearGDBOutput()
  let l:linenumber = GetLineNumber()
  let l:filename = GetFileName()
  if len(l:linenumber) && len(l:filename)
    call UpdateSourceLine(l:filename,l:linenumber)
  endif
endfunction

" TODO Fix this
if s:STARTIMMEDIATLY == 1
  call Init()
endif

