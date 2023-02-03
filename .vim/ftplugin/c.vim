if exists("b:did_ftplugin")
  finish
endif

set errorformat=%f:%l:%c:%m

set tags=~/.vim/doc/c/**/tags
set complete+=k/~/.vim/ftplugin/c.vim,k~/.vim/doc/c/mantovimhelp/tags

let maplocalleader = ","
map <buffer> ( <Nop>
map <buffer> ) <Nop>

" Edit this file
nnoremap <silent> <buffer> <localleader>e :edit ~/.vim/ftplugin/c.vim<CR>
" Browse Xlib source
nnoremap <silent> <buffer> <localleader>x :view /usr/include/X11/Xlib.h<CR>
" Edit makefile in ./
nnoremap <silent> <buffer> <localleader>m :e makefile<CR>
" Execute a REPL on the current line
nnoremap <silent> <buffer> <localleader>r :.w !sh<CR>
" Vimgrep word under cursor
nnoremap <buffer> <localleader>g :vimgrep /<C-R><C-W>/ ./* <CR>
" Open quickfix list
nnoremap <silent> <buffer> <localleader>q :copen 5<CR>
" Open location list
nnoremap <silent> <buffer> <localleader>l :lopen 5<CR>
" Open command line history
nnoremap <silent> <buffer> <localleader>c :<C-F>
" Open forward search history
nnoremap <silent> <buffer> <localleader>/ /<C-F>
" Open reverse search history
nnoremap <silent> <buffer> <localleader>? ?<C-F>

nnoremap <buffer> cn :cnext<CR>
nnoremap <buffer> cp :cprevious<CR>
nnoremap <buffer> <S-K> :tag <C-r><C-W><CR>
nnoremap <buffer> <C-K> :!man <C-r><C-W><CR>
" Source this file
nnoremap <buffer> <F3> <ESC>:unlet b:did_ftplugin<CR>:source ~/.vim/ftplugin/c.vim<CR>

" Switch to header or source
nnoremap <buffer> <F4> <ESC>:e %:r.h<CR>
nnoremap <buffer> <S-F4> <ESC>:e %:r.c<CR>
" Compile current filename.c and link to executable
nnoremap <buffer> <F5> <ESC>:!gcc %:t -o %:r -lm<CR>
inoremap <buffer> <F5> <ESC>:!gcc %:t -o %:r -lm<CR>
" Run
inoremap <buffer> <F6> <ESC>:MakeRun<CR>
nnoremap <buffer> <F6> <ESC>:MakeRun<CR>
" Make
inoremap <buffer> <F8> <ESC>:Make<CR>
nnoremap <buffer> <F8> <ESC>:Make<CR>
" Make Clean
inoremap <buffer> <S-F8> <ESC>:MakeClean<CR>
nnoremap <buffer> <S-F8> <ESC>:MakeClean<CR>

nnoremap <buffer> <F9> :AssemblyOutput<CR>

nnoremap <buffer> <F10> :read ~/.vim/template/SDL2.vim<CR>gg^
nnoremap <buffer> <F11> :read ~/.vim/template/x11.vim<CR>gg^
nnoremap <buffer> <F12> :read ~/.vim/template/c.vim<CR>gg^

command! -buffer TemSDL2 :read ~/.vim/template/SDL2.vim
command! -buffer Temx11 :read ~/.vim/template/x11.vim
command! -buffer Tem :read ~/.vim/template/c.vim
command! -buffer Make :call <SID>KillOutputWindows() | :call <SID>Make()
command! -buffer MakeRun :call <SID>KillOutputWindows() | :call <SID>RunAsync(["make","run"],"")
command! -buffer MakeClean :call <SID>KillOutputWindows() | :call <SID>RunAsync(["make","clean"],"")
command! -buffer -nargs=+ Run :call <SID>KillOutputWindows() | :call <SID>RunAsync([<f-args>],"")
command! -buffer -nargs=+ RunPop :call <SID>KillOutputWindows() | :call <SID>RunAsyncInPopup([<f-args>],"")
command! -buffer AssemblyOutput :call <SID>KillOutputWindows() | :call <SID>AssemblyOutput()

nnoremap <silent> <buffer> <ESC> :silent call <SID>KillOutputWindows()<CR>
nnoremap <silent> <buffer> q <ESC> :silent call <SID>KillOutputWindows()<CR>
autocmd! BufEnter runoutput nnoremap <silent> <buffer> <ESC> :silent call <SID>KillOutputWindows()<CR>
autocmd BufEnter runoutput nnoremap <silent> <buffer> q :silent call <SID>KillOutputWindows()<CR>
execute "autocmd! BufEnter " &makeprg " nnoremap <silent> <buffer> <ESC> :silent call <SID>KillOutputWindows()<CR>"
execute "autocmd BufEnter " &makeprg " nnoremap <silent> <buffer> q :silent call <SID>KillOutputWindows()<CR>"

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

function! s:KillOutputWindows() abort
  silent! execute "bwipeout! " &makeprg
  silent! execute "bwipeout! runoutput"
  silent cclose
  call popup_close(s:runpopup)
endfunction

let s:quickfixsize = 5
let s:runpopup = 0
let s:runoutputtext = []
let s:popupoutputtext = []

function! s:RunAsyncInPopupFunction(channel,msg) abort
  call add(s:popupoutputtext,a:msg)
  call popup_settext(s:runpopup,s:popupoutputtext)
  silent call win_execute(s:runpopup,'normal G0')
endfunction

function! s:RunAsyncInPopup(arglist,optionsdictionary)
  let l:programargs = a:arglist
  let l:joboptions = {}
  let l:joboptions["out_msg"] = "0"
  let l:joboptions["err_msg"] = "0"
  let l:joboptions["callback"] = function('<SID>RunAsyncInPopupFunction')
  let s:runpopup = popup_create('', #{
  \ pos: 'botleft',
  \ title: '',
  \ border: [0,0,0,0],
  \ padding: [0,0,0,0],
  \ line: &lines,
  \ col: 0,
  \ minheight: 5,
  \ maxheight: 5,
  \ minwidth: &columns,
  \ maxwidth: &columns,
  \ close: 'none',
  \ wrap: 'FALSE',
  \ })
  let s:runinpopupjob = job_start(l:programargs,l:joboptions)
  let s:popupoutputtext = []
endfunction

function! s:RunAsyncJobFunction(channel,msg) abort
  if bufexists("runoutput")
    let l:runwindownumber = bufwinnr("runoutput")
    let l:runwindowid = win_getid(l:runwindownumber)
    "Scroll the make window
    "call append(s:runoutputtext,a:msg)
    "call setbufline("runoutput",0,s:runoutputtext)
    "silent call win_execute(l:runwindowid,"normal G0")
  endif
endfunction

function! s:RunAsyncExitFunction(job,status) abort
endfunction

function! s:RunAsync(arglist,optionsdictionary) abort
  let l:programargs = a:arglist 
  let l:joboptions = {}
  let l:joboptions["out_msg"] = "0"
  let l:joboptions["err_msg"] = "0"
  let l:joboptions["out_io"] = "buffer"
  let l:joboptions["err_io"] = "buffer"
  let l:joboptions["out_name"] = "runoutput"
  let l:joboptions["err_name"] = "runoutput"
  let l:joboptions["callback"] = function('<SID>RunAsyncJobFunction')
  let l:joboptions["exit_cb"] = function('<SID>RunAsyncExitFunction')
  let s:runasyncjob = job_start(l:programargs,l:joboptions)
  botright 5split runoutput
  execute "wincmd p"
endfunction

let s:makewarningcount = 0
let s:makeerrorcount = 0

" The status in these callbacks is the return
" value for the executed program. It is NOT
" the status of the vim job from job_status()
"
function! s:MakeExitWithErrorsFunction(job,status)
  let l:joblist = job_info(a:job)["cmd"]
  let l:jobcmd = join(l:joblist," ")
  let l:joberror = job_info(a:job)["stoponexit"]
  let l:errormessage = "Error " . l:jobcmd . " returned " . a:status . ": " . l:joberror
  call <SID>EchoErrorMessage(l:errormessage)
endfunction

function! s:MakeExitFunction(job,status) abort
  if bufexists(&makeprg)
    silent execute "bwipeout! " &makeprg
    silent execute "copen " s:quickfixsize
  endif
  execute "wincmd p"
  if s:makewarningcount + s:makeerrorcount == 0
    caddexpr "No warnings or errors."
  endif
  let s:makewarningcount = 0
  let s:makeerrorcount = 0
endfunction

function! s:MakeJobFunction(channel,msg) abort
  if bufexists(&makeprg)
    let l:makewindownumber = bufwinnr(&makeprg)
    let l:makewindowid = win_getid(l:makewindownumber)
    call appendbufline(&makeprg,"$",a:msg)
    " Scroll the make window
    silent call win_execute(l:makewindowid,"normal G0")
    if a:msg =~ " no makefile found"
      let l:joboptions = {}
      let l:joboptions["exit_cb"] = function('<SID>MakeExitWithErrorsFunction')
      " This alters a value in the job_info dictionary
      " to pass an error message to the exit function
      let l:joboptions["stoponexit"] = "No makefile found"
      call job_setoptions(s:makejob,l:joboptions)
      call job_stop(s:makejob)
    endif
  endif
  " Add warnings and errors to the quickfix buffer
  if a:msg =~ " warning: "
    caddexpr a:msg
    let s:makewarningcount = s:makewarningcount + 1
  endif
  if a:msg =~ " error: "
    caddexpr a:msg
    let s:makeerrorcount = s:makeerrorcount + 1
  endif
endfunction

function! s:Make() abort
    silent wall
    " Close any existing quickfix and make buffers
    cclose
    if bufexists(&makeprg)
      silent execute "bwipeout! " &makeprg
    endif
    let l:joboptions = {}
    let l:joboptions["out_msg"] = "0"
    let l:joboptions["err_msg"] = "0"
    let l:joboptions["out_io"] = "pipe"
    let l:joboptions["err_io"] = "pipe"
    let l:joboptions["out_mode"] = "nl"
    let l:joboptions["err_mode"] = "nl"
    let l:joboptions["callback"] = function('<SID>MakeJobFunction')
    let l:joboptions["exit_cb"] = function('<SID>MakeExitFunction')
    let s:makejob = job_start(&makeprg,l:joboptions)
    " Clear the quickfix window
    cexpr ""
    " Create the scrolling output buffer
    execute "botright 5split " &makeprg
    " Switch back to previous workspace
    exe "wincmd p"
endfunction

function! s:AssemblyOutputExitFunction(job,status)
  let l:assemblyfile = expand('%:r') . '.s'
  if !filereadable(l:assemblyfile)
    echo "File " . l:assemblyfile . " could not be read."
    return
  endif 
  execute "botright vsplit " l:assemblyfile
  execute "set filetype=asm"
endfunction

function! s:AssemblyOutput()
  silent wall
  " Close any existing quickfix and make buffers
  cclose
  let l:assemblyfile = expand('%:t')
  let l:command = ["gcc","-S"] + [l:assemblyfile]
"  let l:command += [l:assemblyfile]
  let l:joboptions = {}
  let l:joboptions["out_msg"] = "0"
  let l:joboptions["err_msg"] = "0"
  let l:joboptions["out_io"] = "null"
  let l:joboptions["err_io"] = "null"
  let l:joboptions["exit_cb"] = function('<SID>AssemblyOutputExitFunction')
  let s:assemblyjob = job_start(l:command,l:joboptions)
endfunction

function s:AVX() abort
  source ~/.vim/ftplugin/simd/xmmabbreviations.vim
  set dict+=~/.vim/ftplugin/simd/xmmabbreviations.vim
endfunction

command! -buffer AVX :call <SID>AVX()

function! s:EatSpace() abort
  let c = nr2char(getchar(0))
  return (c =~ '\s') ? '' : c
endfunction

function! s:Abbreviation(text) abort
  let l:line = getline('.')
  call setline('.',strpart(line,0,col('.')-1) . a:text . strpart(line,col('.') -1))
  call <SID>EatSpace()
  normal f(ll
  stopinsert
  return "" 
endfunction

" stdio.h
inoreabbrev <silent> <buffer> fgets <C-r>=<SID>Abbreviation("fgets(char*,size,FILE);")<CR>
inoreabbrev <silent> <buffer> fgetc <C-R>=<SID>Abbreviation("fgetc(FILE); /* int */")<CR>
inoreabbrev <silent> <buffer> fopen <C-R>=<SID>Abbreviation("fopen(\"filename\",\"r\"); /* FILE* */")<CR>
inoreabbrev <silent> <buffer> fread <C-R>=<SID>Abbreviation("fread(buffer,size,n,FILE); /* size_t */")<CR>
inoreabbrev <silent> <buffer> fwrite <C-R>=<SID>Abbreviation("fwrite(buffer,size,n,FILE); /* size_t */")<CR>
inoreabbrev <silent> <buffer> fclose <C-R>=<SID>Abbreviation("fclose(FILE); /* int */")<CR>
inoreabbrev <silent> <buffer> fseek <C-R>=<SID>Abbreviation("fseek(FILE,offset,wence); /* int - wence is SEEK_SET,SEEK_CUR,SEEK_END */")<CR>
inoreabbrev <silent> <buffer> ftell <C-R>=<SID>Abbreviation("ftell(FILE); /* long */")<CR>
inoreabbrev <silent> <buffer> rewind <C-R>=<SID>Abbreviation("rewind(FILE); /* void */")<CR>
inoreabbrev <silent> <buffer> popen <C-R>=<SID>Abbreviation("popen(\"command --args\",\"r\"); /* FILE* */")<CR>
inoreabbrev <silent> <buffer> pclose <C-R>=<SID>Abbreviation("pclose(FILE); /* int */")<CR>
inoreabbrev <silent> <buffer> rewind <C-R>=<SID>Abbreviation("rewind(FILE); /* void */")<CR>
inoreabbrev <silent> <buffer> printf <C-R>=<SID>Abbreviation("printf(\"\"); /* int */ ")<CR>
inoreabbrev <silent> <buffer> fprintf <C-R>=<SID>Abbreviation("fprintf(FILE,format); /* int */")<CR>
inoreabbrev <silent> <buffer> sprintf <C-R>=<SID>Abbreviation("sprintf(buffer,format); /* int */")<CR>
inoreabbrev <silent> <buffer> snprintf <C-R>=<SID>Abbreviation("snprintf(buffer,size_t,format); /* int */")<CR>

" string.h
inoreabbrev <silent> <buffer> memcpy <C-R>=<SID>Abbreviation("memcpy(dest,src,n); /* void */")<CR>
inoreabbrev <silent> <buffer> memmove <C-R>=<SID>Abbreviation("memmove(dest,src,n); /* void */")<CR>
inoreabbrev <silent> <buffer> memccpy <C-R>=<SID>Abbreviation("memccpy(dest,src,c,n); /* void */")<CR>
inoreabbrev <silent> <buffer> memset <C-R>=<SID>Abbreviation("memset(dest,c,n); /* void */")<CR>
inoreabbrev <silent> <buffer> memcmp <C-R>=<SID>Abbreviation("memcmp(s1,s2,n); /* int */")<CR>
inoreabbrev <silent> <buffer> memchr <C-R>=<SID>Abbreviation("memchr(s,c,n); /* void* - Search N bytes of S for C. */")<CR>
inoreabbrev <silent> <buffer> rawmemchr <C-R>=<SID>Abbreviation("rawmemchr(void*,c); /* void* */")<CR>
inoreabbrev <silent> <buffer> memrchr <C-R>=<SID>Abbreviation("memrchr(s,c,n); /* void* - Search N bytes of S for the final occurrence of C. */")<CR>
inoreabbrev <silent> <buffer> strcpy <C-R>=<SID>Abbreviation("strcpy(dest,src); /* char* */")<CR>
inoreabbrev <silent> <buffer> strncpy <C-R>=<SID>Abbreviation("strncpy(dest,src,n); /* char* */")<CR>
inoreabbrev <silent> <buffer> strcat <C-R>=<SID>Abbreviation("strcat(dest,src); /* char* */")<CR>
inoreabbrev <silent> <buffer> strncat <C-R>=<SID>Abbreviation("strncat(dest,src,n); /* char* */")<CR>
inoreabbrev <silent> <buffer> strcmp <C-R>=<SID>Abbreviation("strcmp(s1,s2); /* int */")<CR>
inoreabbrev <silent> <buffer> strncmp <C-R>=<SID>Abbreviation("strncmp(s1,s2,n); /* int */")<CR>
inoreabbrev <silent> <buffer> strcoll <C-R>=<SID>Abbreviation("strcoll(s1,s2); /* int - Compare the collated forms of S1 and S2. */")<CR>
inoreabbrev <silent> <buffer> strdup <C-R>=<SID>Abbreviation("strdup(s); /* char* - Duplicate S, returning an identical mallocd s */")<CR>
inoreabbrev <silent> <buffer> strndup <C-R>=<SID>Abbreviation("strndup(s,n); /* char* - Return a mallocd copy of at most N bytes of S. */")<CR>
inoreabbrev <silent> <buffer> strchr <C-R>=<SID>Abbreviation("strchr(s,c); /* char* */")<CR>
inoreabbrev <silent> <buffer> strchrnul <C-R>=<SID>Abbreviation("strchrnul(s,c); /* char* */")<CR>
inoreabbrev <silent> <buffer> strcspn <C-R>=<SID>Abbreviation("strcspn(s,c); /* size_t */")<CR>
inoreabbrev <silent> <buffer> strspn <C-R>=<SID>Abbreviation("strspn(s,c); /* size_t */")<CR>
inoreabbrev <silent> <buffer> strpbrk <C-R>=<SID>Abbreviation("strpbrk(s,c); /* char* - Find the first occurrence in S of any character in C. */")<CR>
inoreabbrev <silent> <buffer> strstr <C-R>=<SID>Abbreviation("strstr(haystack,needle); /* char* */")<CR>
inoreabbrev <silent> <buffer> strtok <C-R>=<SID>Abbreviation("strtok(s,delim); /* char* */")<CR>
inoreabbrev <silent> <buffer> strlen <C-R>=<SID>Abbreviation("strlen(s); /* size_t */")<CR>
inoreabbrev <silent> <buffer> strerror <C-R>=<SID>Abbreviation("strerror(int); /* char* */")<CR>
inoreabbrev <silent> <buffer> basename <C-R>=<SID>Abbreviation("basename(filename); /* char* */")<CR>

" stdlib.h
inoreabbrev <silent> <buffer> _Exit <C-R>=<SID>Abbreviation("_Exit(int); /* void */")<CR>
inoreabbrev <silent> <buffer> a64l <C-R>=<SID>Abbreviation("a64l(char*); /* long */")<CR>
inoreabbrev <silent> <buffer> abort <C-R>=<SID>Abbreviation("abort(void); /* void */")<CR>
inoreabbrev <silent> <buffer> abs <C-R>=<SID>Abbreviation("abs(int); /* int */")<CR>
inoreabbrev <silent> <buffer> atexit <C-R>=<SID>Abbreviation("atexit(void (*)(void)); /* int */")<CR>
inoreabbrev <silent> <buffer> atof <C-R>=<SID>Abbreviation("atof(char*); /* double */")<CR>
inoreabbrev <silent> <buffer> atoi <C-R>=<SID>Abbreviation("atoi(char*); /* int */")<CR>
inoreabbrev <silent> <buffer> atol <C-R>=<SID>Abbreviation("atol(char*); /* long */")<CR>
inoreabbrev <silent> <buffer> atoll <C-R>=<SID>Abbreviation("atoll(char*); /* long long */")<CR>
inoreabbrev <silent> <buffer> bsearch <C-R>=<SID>Abbreviation("bsearch(void *,void *,size_t,size_t,int (*)(void *,void *)); /* void* */")<CR>
inoreabbrev <silent> <buffer> calloc <C-R>=<SID>Abbreviation("calloc(size_t,size_t); /* void* */")<CR>
inoreabbrev <silent> <buffer> div <C-R>=<SID>Abbreviation("div(int,int); /* div_t */")<CR>
inoreabbrev <silent> <buffer> drand48 <C-R>=<SID>Abbreviation("drand48(void); /* double */")<CR>
inoreabbrev <silent> <buffer> erand48 <C-R>=<SID>Abbreviation("erand48(unsigned short [3]); /* double */")<CR>
inoreabbrev <silent> <buffer> exit <C-R>=<SID>Abbreviation("exit(int); /* void */")<CR>
inoreabbrev <silent> <buffer> free <C-R>=<SID>Abbreviation("free(void *); /* void */")<CR>
inoreabbrev <silent> <buffer> getenv <C-R>=<SID>Abbreviation("getenv(char *); /* char* */")<CR>
inoreabbrev <silent> <buffer> getsubopt <C-R>=<SID>Abbreviation("getsubopt(char **,char **,char **); /* int */")<CR>
inoreabbrev <silent> <buffer> grantpt <C-R>=<SID>Abbreviation("grantpt(int); /* int */")<CR>
inoreabbrev <silent> <buffer> initstate <C-R>=<SID>Abbreviation("initstate(unsigned,char *,size_t); /* char* */")<CR>
inoreabbrev <silent> <buffer> jrand48 <C-R>=<SID>Abbreviation("jrand48(unsigned short [3]); /* long */")<CR>
inoreabbrev <silent> <buffer> labs <C-R>=<SID>Abbreviation("labs(long); /* long */")<CR>
inoreabbrev <silent> <buffer> lcong48 <C-R>=<SID>Abbreviation("lcong48(unsigned short [7]); /* void */")<CR>
inoreabbrev <silent> <buffer> ldiv <C-R>=<SID>Abbreviation("ldiv(long,long); /* ldiv_t */")<CR>
inoreabbrev <silent> <buffer> llabs <C-R>=<SID>Abbreviation("llabs(long long); /* long long */")<CR>
inoreabbrev <silent> <buffer> lldiv <C-R>=<SID>Abbreviation("lldiv(long long,long long); /* lldiv_t */")<CR>
inoreabbrev <silent> <buffer> lrand48 <C-R>=<SID>Abbreviation("lrand48(void); /* long */")<CR>
inoreabbrev <silent> <buffer> malloc <C-R>=<SID>Abbreviation("malloc(size_t); /* void* */")<CR>
inoreabbrev <silent> <buffer> mblen <C-R>=<SID>Abbreviation("mblen(char *,size_t); /* int */")<CR>
inoreabbrev <silent> <buffer> mbstowcs <C-R>=<SID>Abbreviation("mbstowcs(wchar_t*,char*,size_t); /* size_t */")<CR>
inoreabbrev <silent> <buffer> mbtowc <C-R>=<SID>Abbreviation("mbtowc(wchar_t*,char*,size_t); /* int */")<CR>
inoreabbrev <silent> <buffer> mkdtemp <C-R>=<SID>Abbreviation("mkdtemp(char *); /* char* */")<CR>
inoreabbrev <silent> <buffer> mkstemp <C-R>=<SID>Abbreviation("mkstemp(char *); /* int */")<CR>
inoreabbrev <silent> <buffer> mrand48 <C-R>=<SID>Abbreviation("mrand48(void); /* long */")<CR>
inoreabbrev <silent> <buffer> nrand48 <C-R>=<SID>Abbreviation("nrand48(unsigned short [3]); /* long */")<CR>
inoreabbrev <silent> <buffer> posix_memalign <C-R>=<SID>Abbreviation("posix_memalign(void **,size_t,size_t); /* int */")<CR>
inoreabbrev <silent> <buffer> posix_openpt <C-R>=<SID>Abbreviation("posix_openpt(int); /* int */")<CR>
inoreabbrev <silent> <buffer> ptsname <C-R>=<SID>Abbreviation("ptsname(int); /* char* */")<CR>
inoreabbrev <silent> <buffer> putenv <C-R>=<SID>Abbreviation("putenv(char *); /* int */")<CR>
inoreabbrev <silent> <buffer> qsort <C-R>=<SID>Abbreviation("qsort(void *,size_t,size_t,int (*)(void *,void *)); /* void */")<CR>
inoreabbrev <silent> <buffer> rand <C-R>=<SID>Abbreviation("rand(void); /* int */")<CR>
inoreabbrev <silent> <buffer> rand_r <C-R>=<SID>Abbreviation("rand_r(unsigned *); /* int */")<CR>
inoreabbrev <silent> <buffer> random <C-R>=<SID>Abbreviation("random(void); /* long */")<CR>
inoreabbrev <silent> <buffer> realloc <C-R>=<SID>Abbreviation("realloc(void *,size_t); /* void* */")<CR>
inoreabbrev <silent> <buffer> realpath <C-R>=<SID>Abbreviation("realpath(char*,char*); /* char* */")<CR>
inoreabbrev <silent> <buffer> seed48 <C-R>=<SID>Abbreviation("seed48(unsigned short [3]); /* unsigned short* */")<CR>
inoreabbrev <silent> <buffer> setenv <C-R>=<SID>Abbreviation("setenv(char *,char *,int); /* int */")<CR>
inoreabbrev <silent> <buffer> setkey <C-R>=<SID>Abbreviation("setkey(char *); /* void */")<CR>
inoreabbrev <silent> <buffer> setstate <C-R>=<SID>Abbreviation("setstate(char *); /* char* */")<CR>
inoreabbrev <silent> <buffer> srand <C-R>=<SID>Abbreviation("srand(unsigned); /* void */")<CR>
inoreabbrev <silent> <buffer> srand48 <C-R>=<SID>Abbreviation("srand48(long); /* void */")<CR>
inoreabbrev <silent> <buffer> srandom <C-R>=<SID>Abbreviation("srandom(unsigned); /* void */")<CR>
inoreabbrev <silent> <buffer> strtod <C-R>=<SID>Abbreviation("strtod(char*,char**); /* double */")<CR>
inoreabbrev <silent> <buffer> strtof <C-R>=<SID>Abbreviation("strtof(char*,char**); /* float */")<CR>
inoreabbrev <silent> <buffer> strtol <C-R>=<SID>Abbreviation("strtol(char*,char**,int); /* long */")<CR>
inoreabbrev <silent> <buffer> strtold <C-R>=<SID>Abbreviation("strtold(char*,char**); /* long double */")<CR>
inoreabbrev <silent> <buffer> strtoll <C-R>=<SID>Abbreviation("strtoll(char*,char**,int); /* long long */")<CR>
inoreabbrev <silent> <buffer> strtoul <C-R>=<SID>Abbreviation("strtoul(char*,char**,int); /* unsigned long */")<CR>
inoreabbrev <silent> <buffer> strtoull <C-R>=<SID>Abbreviation("strtoull(char*,char**,int); /* unsigned long long */")<CR>
inoreabbrev <silent> <buffer> system <C-R>=<SID>Abbreviation("system(char *); /* int */")<CR>
inoreabbrev <silent> <buffer> unlockpt <C-R>=<SID>Abbreviation("unlockpt(int); /* int */")<CR>
inoreabbrev <silent> <buffer> unsetenv <C-R>=<SID>Abbreviation("unsetenv(char *); /* int */")<CR>
inoreabbrev <silent> <buffer> wcstombs <C-R>=<SID>Abbreviation("wcstombs(char*,wchar_t*,size_t); /* size_t */")<CR>
inoreabbrev <silent> <buffer> wctomb <C-R>=<SID>Abbreviation("wctomb(char *,wchar_t); /* int */")<CR>

" pthread.h
inoreabbrev <silent> <buffer> pthread_attr_destroy <C-R>=<SID>Abbreviation("pthread_attr_destroy(pthread_attr_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_getdetachstate <C-R>=<SID>Abbreviation("pthread_attr_getdetachstate(const pthread_attr_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_getguardsize <C-R>=<SID>Abbreviation("pthread_attr_getguardsize(const pthread_attr_t *, size_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_getinheritsched <C-R>=<SID>Abbreviation("pthread_attr_getinheritsched(const pthread_attr_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_getschedparam <C-R>=<SID>Abbreviation("pthread_attr_getschedparam(const pthread_attr_t *, struct sched_param *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_getschedpolicy <C-R>=<SID>Abbreviation("pthread_attr_getschedpolicy(const pthread_attr_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_getscope <C-R>=<SID>Abbreviation("pthread_attr_getscope(const pthread_attr_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_getstackaddr <C-R>=<SID>Abbreviation("pthread_attr_getstackaddr(const pthread_attr_t *, void **); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_getstacksize <C-R>=<SID>Abbreviation("pthread_attr_getstacksize(const pthread_attr_t *, size_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_init <C-R>=<SID>Abbreviation("pthread_attr_init(pthread_attr_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_setdetachstate <C-R>=<SID>Abbreviation("pthread_attr_setdetachstate(pthread_attr_t *, int); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_setguardsize <C-R>=<SID>Abbreviation("pthread_attr_setguardsize(pthread_attr_t *, size_t); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_setinheritsched <C-R>=<SID>Abbreviation("pthread_attr_setinheritsched(pthread_attr_t *, int); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_setschedparam <C-R>=<SID>Abbreviation("pthread_attr_setschedparam(pthread_attr_t *, const struct sched_param *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_setschedpolicy <C-R>=<SID>Abbreviation("pthread_attr_setschedpolicy(pthread_attr_t *, int); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_setscope <C-R>=<SID>Abbreviation("pthread_attr_setscope(pthread_attr_t *, int); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_setstackaddr <C-R>=<SID>Abbreviation("pthread_attr_setstackaddr(pthread_attr_t *, void *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_attr_setstacksize <C-R>=<SID>Abbreviation("pthread_attr_setstacksize(pthread_attr_t *, size_t); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_cancel <C-R>=<SID>Abbreviation("pthread_cancel(pthread_t); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_cleanup_push <C-R>=<SID>Abbreviation("pthread_cleanup_push(void (*routine)(void *), void *arg); /* void */")<CR>
inoreabbrev <silent> <buffer> pthread_cleanup_pop <C-R>=<SID>Abbreviation("pthread_cleanup_pop(int); /* void */")<CR>
inoreabbrev <silent> <buffer> pthread_cond_broadcast <C-R>=<SID>Abbreviation("pthread_cond_broadcast(pthread_cond_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_cond_destroy <C-R>=<SID>Abbreviation("pthread_cond_destroy(pthread_cond_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_cond_init <C-R>=<SID>Abbreviation("pthread_cond_init(pthread_cond_t *, const pthread_condattr_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_cond_signal <C-R>=<SID>Abbreviation("pthread_cond_signal(pthread_cond_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_cond_timedwait <C-R>=<SID>Abbreviation("pthread_cond_timedwait(pthread_cond_t *, pthread_mutex_t *, const struct timespec *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_cond_wait <C-R>=<SID>Abbreviation("pthread_cond_wait(pthread_cond_t *, pthread_mutex_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_condattr_destroy <C-R>=<SID>Abbreviation("pthread_condattr_destroy(pthread_condattr_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_condattr_getpshared <C-R>=<SID>Abbreviation("pthread_condattr_getpshared(const pthread_condattr_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_condattr_init <C-R>=<SID>Abbreviation("pthread_condattr_init(pthread_condattr_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_condattr_setpshared <C-R>=<SID>Abbreviation("pthread_condattr_setpshared(pthread_condattr_t *, int); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_create <C-R>=<SID>Abbreviation("pthread_create(pthread_t *, const pthread_attr_t *, void *(*)(void *), void *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_detach <C-R>=<SID>Abbreviation("pthread_detach(pthread_t); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_equal <C-R>=<SID>Abbreviation("pthread_equal(pthread_t, pthread_t); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_exit <C-R>=<SID>Abbreviation("pthread_exit(void *); /* void */")<CR>
inoreabbrev <silent> <buffer> pthread_getconcurrency <C-R>=<SID>Abbreviation("pthread_getconcurrency(void); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_getschedparam <C-R>=<SID>Abbreviation("pthread_getschedparam(pthread_t, int *, struct sched_param *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_getspecific(pthread_key_t); /* void* */
inoreabbrev <silent> <buffer> pthread_join <C-R>=<SID>Abbreviation("pthread_join(pthread_t, void **); /* int */")<CR> inoreabbrev <silent> <buffer> pthread_key_create <C-R>=<SID>Abbreviation("pthread_key_create(pthread_key_t *, void (*)(void *)); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_key_delete <C-R>=<SID>Abbreviation("pthread_key_delete(pthread_key_t); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutex_destroy <C-R>=<SID>Abbreviation("pthread_mutex_destroy(pthread_mutex_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutex_getprioceiling <C-R>=<SID>Abbreviation("pthread_mutex_getprioceiling(const pthread_mutex_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutex_init <C-R>=<SID>Abbreviation("pthread_mutex_init(pthread_mutex_t *, const pthread_mutexattr_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutex_lock <C-R>=<SID>Abbreviation("pthread_mutex_lock(pthread_mutex_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutex_setprioceiling <C-R>=<SID>Abbreviation("pthread_mutex_setprioceiling(pthread_mutex_t *, int, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutex_trylock <C-R>=<SID>Abbreviation("pthread_mutex_trylock(pthread_mutex_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutex_unlock <C-R>=<SID>Abbreviation("pthread_mutex_unlock(pthread_mutex_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutexattr_destroy <C-R>=<SID>Abbreviation("pthread_mutexattr_destroy(pthread_mutexattr_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutexattr_getprioceiling <C-R>=<SID>Abbreviation("pthread_mutexattr_getprioceiling(const pthread_mutexattr_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutexattr_getprotocol <C-R>=<SID>Abbreviation("pthread_mutexattr_getprotocol(const pthread_mutexattr_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutexattr_getpshared <C-R>=<SID>Abbreviation("pthread_mutexattr_getpshared(const pthread_mutexattr_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutexattr_gettype <C-R>=<SID>Abbreviation("pthread_mutexattr_gettype(const pthread_mutexattr_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutexattr_init <C-R>=<SID>Abbreviation("pthread_mutexattr_init(pthread_mutexattr_t *); /* int */")<CR> inoreabbrev <silent> <buffer> pthread_mutexattr_setprioceiling <C-R>=<SID>Abbreviation("pthread_mutexattr_setprioceiling(pthread_mutexattr_t *, int); /* int */")<CR> inoreabbrev <silent> <buffer> pthread_mutexattr_setprotocol <C-R>=<SID>Abbreviation("pthread_mutexattr_setprotocol(pthread_mutexattr_t *, int); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutexattr_setpshared <C-R>=<SID>Abbreviation("pthread_mutexattr_setpshared(pthread_mutexattr_t *, int); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_mutexattr_settype <C-R>=<SID>Abbreviation("pthread_mutexattr_settype(pthread_mutexattr_t *, int); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_once <C-R>=<SID>Abbreviation("pthread_once(pthread_once_t *, void (*)(void)); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlock_destroy <C-R>=<SID>Abbreviation("pthread_rwlock_destroy(pthread_rwlock_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlock_init <C-R>=<SID>Abbreviation("pthread_rwlock_init(pthread_rwlock_t *, const pthread_rwlockattr_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlock_rdlock <C-R>=<SID>Abbreviation("pthread_rwlock_rdlock(pthread_rwlock_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlock_tryrdlock <C-R>=<SID>Abbreviation("pthread_rwlock_tryrdlock(pthread_rwlock_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlock_trywrlock <C-R>=<SID>Abbreviation("pthread_rwlock_trywrlock(pthread_rwlock_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlock_unlock <C-R>=<SID>Abbreviation("pthread_rwlock_unlock(pthread_rwlock_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlock_wrlock <C-R>=<SID>Abbreviation("pthread_rwlock_wrlock(pthread_rwlock_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlockattr_destroy <C-R>=<SID>Abbreviation("pthread_rwlockattr_destroy(pthread_rwlockattr_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlockattr_getpshared <C-R>=<SID>Abbreviation("pthread_rwlockattr_getpshared(const pthread_rwlockattr_t *, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlockattr_init <C-R>=<SID>Abbreviation("pthread_rwlockattr_init(pthread_rwlockattr_t *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_rwlockattr_setpshared <C-R>=<SID>Abbreviation("pthread_rwlockattr_setpshared(pthread_rwlockattr_t *, int); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_self <C-R>=<SID>Abbreviation("pthread_self(void); /* pthread_t */")<CR>
inoreabbrev <silent> <buffer> pthread_setcancelstate <C-R>=<SID>Abbreviation("pthread_setcancelstate(int, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_setcanceltype <C-R>=<SID>Abbreviation("pthread_setcanceltype(int, int *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_setconcurrency <C-R>=<SID>Abbreviation("pthread_setconcurrency(int); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_setschedparam <C-R>=<SID>Abbreviation("pthread_setschedparam(pthread_t,int,const struct sched_param *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_setspecific <C-R>=<SID>Abbreviation("pthread_setspecific(pthread_key_t, const void *); /* int */")<CR>
inoreabbrev <silent> <buffer> pthread_testcancel <C-R>=<SID>Abbreviation("pthread_testcancel(void); /* void */")<CR>

" time.h
inoreabbrev <silent> <buffer> clock <C-R>=<SID>Abbreviation("clock(); /* clock_t */")<CR>
inoreabbrev <silent> <buffer> time <C-R>=<SID>Abbreviation("time(time_t*) /* time_t */")<CR>
inoreabbrev <silent> <buffer> difftime <C-R>=<SID>Abbreviation("difftime(time_t,time_t) /* double */")<CR>
inoreabbrev <silent> <buffer> mktime <C-R>=<SID>Abbreviation("mktime(struct tm *tp) /* time_t */")<CR>
inoreabbrev <silent> <buffer> strftime <C-R>=<SID>Abbreviation("strftime(char*,size_t,format,struct *tm); /* size_t */")<CR>
inoreabbrev <silent> <buffer> asctime <C-R>=<SID>Abbreviation("asctime(struct tm*); /* char* */")<CR>
inoreabbrev <silent> <buffer> timer_create <C-R>=<SID>Abbreviation("timer_create(colckid_t,struct sigevent*,timer_t*); /* int */")<CR>
inoreabbrev <silent> <buffer> timer_delete <C-R>=<SID>Abbreviation("timer_delete(timer_t); /* int */")<CR>
inoreabbrev <silent> <buffer> timer_gettime <C-R>=<SID>Abbreviation("timer_gettime(timer_t,struct itimerspec*); /* int */")<CR>

" unistd.h
inoreabbrev <silent> <buffer> access <C-R>=<SID>Abbreviation("access(char*,int); /* int */")<CR>
inoreabbrev <silent> <buffer> alarm <C-R>=<SID>Abbreviation("alarm(unsigned int); /* unsigned int */")<CR>
inoreabbrev <silent> <buffer> brk <C-R>=<SID>Abbreviation("brk(void*); /* int */")<CR>
inoreabbrev <silent> <buffer> chdir <C-R>=<SID>Abbreviation("chdir(char*); /* int */")<CR>
inoreabbrev <silent> <buffer> chroot <C-R>=<SID>Abbreviation("chroot(char*); /* int */")<CR>
inoreabbrev <silent> <buffer> chown <C-R>=<SID>Abbreviation("chown(char*,uid_t,gid_t); /* int */")<CR>
inoreabbrev <silent> <buffer> close <C-R>=<SID>Abbreviation("close(int); /* int */")<CR>
inoreabbrev <silent> <buffer> confstr <C-R>=<SID>Abbreviation("confstr(int,char*,size_t); /* size_t */")<CR>
inoreabbrev <silent> <buffer> crypt <C-R>=<SID>Abbreviation("crypt(char*, char*); /* char* */")<CR>
inoreabbrev <silent> <buffer> ctermid <C-R>=<SID>Abbreviation("ctermid(char*); /* char* */")<CR>
inoreabbrev <silent> <buffer> cuserid <C-R>=<SID>Abbreviation("cuserid(char*s); /* char* */")<CR>
inoreabbrev <silent> <buffer> dup <C-R>=<SID>Abbreviation("dup(int); /* int */")<CR>
inoreabbrev <silent> <buffer> dup2 <C-R>=<SID>Abbreviation("dup2(int,int); /* int */")<CR>
inoreabbrev <silent> <buffer> encrypt <C-R>=<SID>Abbreviation("encrypt(char[64],int); /* void */")<CR>
inoreabbrev <silent> <buffer> execl <C-R>=<SID>Abbreviation("execl(char*, char*,...); /* int */")<CR>
inoreabbrev <silent> <buffer> execle <C-R>=<SID>Abbreviation("execle(char*, char*,...); /* int */")<CR>
inoreabbrev <silent> <buffer> execlp <C-R>=<SID>Abbreviation("execlp(char*, char*,...); /* int */")<CR>
inoreabbrev <silent> <buffer> execv <C-R>=<SID>Abbreviation("execv(char*,char* []); /* int */")<CR>
inoreabbrev <silent> <buffer> execve <C-R>=<SID>Abbreviation("execve(char*,char* [],char* []); /* int */")<CR>
inoreabbrev <silent> <buffer> execvp <C-R>=<SID>Abbreviation("execvp(char*,char* []); /* int */")<CR>
inoreabbrev <silent> <buffer> _exit <C-R>=<SID>Abbreviation("_exit(int); /* void */")<CR>
inoreabbrev <silent> <buffer> fchown <C-R>=<SID>Abbreviation("fchown(int,uid_t,gid_t); /* int */")<CR>
inoreabbrev <silent> <buffer> fchdir <C-R>=<SID>Abbreviation("fchdir(int); /* int */")<CR>
inoreabbrev <silent> <buffer> fdatasync <C-R>=<SID>Abbreviation("fdatasync(int); /* int */")<CR>
inoreabbrev <silent> <buffer> fork <C-R>=<SID>Abbreviation("fork(void); /* pid_t */")<CR>
inoreabbrev <silent> <buffer> fpathconf <C-R>=<SID>Abbreviation("fpathconf(int,int); long /* int */")<CR>
inoreabbrev <silent> <buffer> fsync <C-R>=<SID>Abbreviation("fsync(int); /* int */")<CR>
inoreabbrev <silent> <buffer> ftruncate <C-R>=<SID>Abbreviation("ftruncate(int,off_t); /* int */")<CR>
inoreabbrev <silent> <buffer> getcwd <C-R>=<SID>Abbreviation("getcwd(char*,size_t ); /* char* */")<CR>
inoreabbrev <silent> <buffer> getdtablesize <C-R>=<SID>Abbreviation("getdtablesize(void); /* int */")<CR>
inoreabbrev <silent> <buffer> getegid <C-R>=<SID>Abbreviation("getegid(void); /* gid_t */")<CR>
inoreabbrev <silent> <buffer> geteuid <C-R>=<SID>Abbreviation("geteuid(void); /* uid_t */")<CR>
inoreabbrev <silent> <buffer> getgid <C-R>=<SID>Abbreviation("getgid(void); /* gid_t */")<CR>
inoreabbrev <silent> <buffer> getgroups <C-R>=<SID>Abbreviation("getgroups(int,gid_t []); /* int */")<CR>
inoreabbrev <silent> <buffer> gethostid <C-R>=<SID>Abbreviation("gethostid(void); /* long */")<CR>
inoreabbrev <silent> <buffer> getlogin <C-R>=<SID>Abbreviation("getlogin(void); /* char* */")<CR>
inoreabbrev <silent> <buffer> getlogin_r <C-R>=<SID>Abbreviation("getlogin_r(char*,size_t); /* int */")<CR>
inoreabbrev <silent> <buffer> getopt <C-R>=<SID>Abbreviation("getopt(int,char*  [], char*); /* int */")<CR>
inoreabbrev <silent> <buffer> getpagesize <C-R>=<SID>Abbreviation("getpagesize(void); /* int */")<CR>
inoreabbrev <silent> <buffer> getpass <C-R>=<SID>Abbreviation("getpass(char*); /* char* */")<CR>
inoreabbrev <silent> <buffer> getpgid <C-R>=<SID>Abbreviation("getpgid(pid_t); /* pid_t */")<CR>
inoreabbrev <silent> <buffer> getpgrp <C-R>=<SID>Abbreviation("getpgrp(void); /* pid_t */")<CR>
inoreabbrev <silent> <buffer> getpid <C-R>=<SID>Abbreviation("getpid(void); /* pid_t */")<CR>
inoreabbrev <silent> <buffer> getppid <C-R>=<SID>Abbreviation("getppid(void); /* pid_t */")<CR>
inoreabbrev <silent> <buffer> getsid <C-R>=<SID>Abbreviation("getsid(pid_t); /* pid_t */")<CR>
inoreabbrev <silent> <buffer> getuid <C-R>=<SID>Abbreviation("getuid(void); /* uid_t */")<CR>
inoreabbrev <silent> <buffer> getwd <C-R>=<SID>Abbreviation("getwd(char*); cha /* * */r")<CR>
inoreabbrev <silent> <buffer> isatty <C-R>=<SID>Abbreviation("isatty(int); /* int */")<CR>
inoreabbrev <silent> <buffer> lchown <C-R>=<SID>Abbreviation("lchown(char*,uid_t,gid_t); /* int */")<CR>
inoreabbrev <silent> <buffer> link <C-R>=<SID>Abbreviation("link(char*, char*); /* int */")<CR>
inoreabbrev <silent> <buffer> lockf <C-R>=<SID>Abbreviation("lockf(int,int,off_t); /* int */")<CR>
inoreabbrev <silent> <buffer> lseek <C-R>=<SID>Abbreviation("lseek(int,off_t,int); /* off_t */")<CR>
inoreabbrev <silent> <buffer> nice <C-R>=<SID>Abbreviation("nice(int); /* int */")<CR>
inoreabbrev <silent> <buffer> pathconf <C-R>=<SID>Abbreviation("pathconf(char*,int); long /* int */")<CR>
inoreabbrev <silent> <buffer> pause <C-R>=<SID>Abbreviation("pause(void); /* int */")<CR>
inoreabbrev <silent> <buffer> pipe <C-R>=<SID>Abbreviation("pipe(int [2]); /* int */")<CR>
inoreabbrev <silent> <buffer> pread <C-R>=<SID>Abbreviation("pread(int,void*,size_t,off_t); /* ssize_t */")<CR>
inoreabbrev <silent> <buffer> pthread_atfork <C-R>=<SID>Abbreviation("pthread_atfork(void(*)(void),void(*)(void),void(*)(void)); /* int */")<CR>
inoreabbrev <silent> <buffer> pwrite <C-R>=<SID>Abbreviation("pwrite(int, void*,size_t,off_t); /* ssize_t */")<CR>
inoreabbrev <silent> <buffer> read <C-R>=<SID>Abbreviation("read(int,void*,size_t); /* ssize_t */")<CR>
inoreabbrev <silent> <buffer> readlink <C-R>=<SID>Abbreviation("readlink(char*,char*,size_t); /* int */")<CR>
inoreabbrev <silent> <buffer> rmdir <C-R>=<SID>Abbreviation("rmdir(char*); /* int */")<CR>
inoreabbrev <silent> <buffer> sbrk <C-R>=<SID>Abbreviation("sbrk(intptr_t); voi /* * */d")<CR>
inoreabbrev <silent> <buffer> setgid <C-R>=<SID>Abbreviation("setgid(gid_t); /* int */")<CR>
inoreabbrev <silent> <buffer> setpgid <C-R>=<SID>Abbreviation("setpgid(pid_t,pid_t); /* int */")<CR>
inoreabbrev <silent> <buffer> setpgrp <C-R>=<SID>Abbreviation("setpgrp(void); /* pid_t */")<CR>
inoreabbrev <silent> <buffer> setregid <C-R>=<SID>Abbreviation("setregid(gid_t,gid_t); /* int */")<CR>
inoreabbrev <silent> <buffer> setreuid <C-R>=<SID>Abbreviation("setreuid(uid_t,uid_t); /* int */")<CR>
inoreabbrev <silent> <buffer> setsid <C-R>=<SID>Abbreviation("setsid(void); /* pid_t */")<CR>
inoreabbrev <silent> <buffer> setuid <C-R>=<SID>Abbreviation("setuid(uid_t); /* int */")<CR>
inoreabbrev <silent> <buffer> sleep <C-R>=<SID>Abbreviation("sleep(unsigned int); /* unsigned int */")<CR>
inoreabbrev <silent> <buffer> swab <C-R>=<SID>Abbreviation("swab(void*,void*,ssize_t); /* void */")<CR>
inoreabbrev <silent> <buffer> symlink <C-R>=<SID>Abbreviation("symlink(char*, char*); /* int */")<CR>
inoreabbrev <silent> <buffer> sync <C-R>=<SID>Abbreviation("sync(void); /* void */")<CR>
inoreabbrev <silent> <buffer> sysconf <C-R>=<SID>Abbreviation("sysconf(int); long /* int */")<CR>
inoreabbrev <silent> <buffer> tcgetpgrp <C-R>=<SID>Abbreviation("tcgetpgrp(int); /* pid_t */")<CR>
inoreabbrev <silent> <buffer> tcsetpgrp <C-R>=<SID>Abbreviation("tcsetpgrp(int,pid_t); /* int */")<CR>
inoreabbrev <silent> <buffer> truncate <C-R>=<SID>Abbreviation("truncate(char*,off_t); /* int */")<CR>
inoreabbrev <silent> <buffer> ttyname <C-R>=<SID>Abbreviation("ttyname(int); cha /* * */r")<CR>
inoreabbrev <silent> <buffer> ttyname_r <C-R>=<SID>Abbreviation("ttyname_r(int,char*,size_t); /* int */")<CR>
inoreabbrev <silent> <buffer> ualarm <C-R>=<SID>Abbreviation("ualarm(useconds_t,useconds_t); /* useconds_t */")<CR>
inoreabbrev <silent> <buffer> unlink <C-R>=<SID>Abbreviation("unlink(char*); /* int */")<CR>
inoreabbrev <silent> <buffer> usleep <C-R>=<SID>Abbreviation("usleep(useconds_t); /* int */")<CR>
inoreabbrev <silent> <buffer> vfork <C-R>=<SID>Abbreviation("vfork(void); /* pid_t */")<CR>
inoreabbrev <silent> <buffer> write <C-R>=<SID>Abbreviation("write(int, void*,size_t); /* ssize_t */")<CR>

" sys/mman.h memory mapping mmap
inoreabbrev <silent> <buffer> mmap <C-R>=<SID>Abbreviation("mmap(void *addr,size_t len,int prot,int flags,int fd,off_t offset); /* void* */")<CR>
inoreabbrev <silent> <buffer> mmap64 mmap64(void *addr,size_t len,int prot,int flags,int fd,off64_t offset); /* void* */
inoreabbrev <silent> <buffer> munmap <C-R>=<SID>Abbreviation("munmap(void *addr,size_t len); /* 0(success) -1(error) */")<CR>
inoreabbrev <silent> <buffer> mlock <C-R>=<SID>Abbreviation("mlock(const void *addr,size_t len); /* int */")<CR>
inoreabbrev <silent> <buffer> mprotect <C-R>=<SID>Abbreviation("mprotect(void *addr,size_t len,int prot); /* 0(success) -1(error) */")<CR>
inoreabbrev <silent> <buffer> msync <C-R>=<SID>Abbreviation("msync(void *addr,size_t len,int flags); /* int */")<CR>
inoreabbrev <silent> <buffer> madvise <C-R>=<SID>Abbreviation("madvise(void *addr,size_t len,int advice); /* int */")<CR>
inoreabbrev <silent> <buffer> posix_madvise <C-R>=<SID>Abbreviation("posix_madvise(void *addr,size_t len,int advice); /* int */")<CR>
inoreabbrev <silent> <buffer> munlock <C-R>=<SID>Abbreviation("munlock(const void *addr,size_t len); /* int */")<CR>
inoreabbrev <silent> <buffer> mlockall <C-R>=<SID>Abbreviation("mlockall(int flags); /* int */")<CR>
inoreabbrev <silent> <buffer> munlockall <C-R>=<SID>Abbreviation("munlockall(); /* int */")<CR>
inoreabbrev <silent> <buffer> mincore <C-R>=<SID>Abbreviation("mincore(void *start,size_t len,unsigned char *vec); /* int */")<CR>
inoreabbrev <silent> <buffer> mremap <C-R>=<SID>Abbreviation("mremap (void *addr,size_t old_len,size_t new_len,int flags, ...); /* int */ ")<CR>
inoreabbrev <silent> <buffer> shm_open <C-R>=<SID>Abbreviation("shm_open (const char *name,int oflag,mode_t mode); /* int */")<CR>
inoreabbrev <silent> <buffer> shm_unlink <C-R>=<SID>Abbreviation("shm_unlink(const char *name); /* int */")<CR>

" sys/ioctl.h
inoreabbrev <silent> <buffer> ioctl <C-R>=<SID>Abbreviation("ioctl(int fd,unsigned long int request, void *data); /* int */")<CR>

" zlib.h gzip
inoreabbrev <silent> <buffer> zlibVersion <C-R>=<SID>Abbreviation("zlibVersion(void); /* const char* */")<CR>
inoreabbrev <silent> <buffer> deflateInit <C-R>=<SID>Abbreviation("deflateInit(z_streamp strm,int level); /* int */")<CR>
inoreabbrev <silent> <buffer> deflate <C-R>=<SID>Abbreviation("deflate(z_streamp strm,int flush); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateEnd <C-R>=<SID>Abbreviation("deflateEnd(z_streamp strm); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateInit <C-R>=<SID>Abbreviation("inflateInit(z_streamp strm); /* int */")<CR>
inoreabbrev <silent> <buffer> inflate <C-R>=<SID>Abbreviation("inflate(z_streamp strm,int flush); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateEnd <C-R>=<SID>Abbreviation("inflateEnd(z_streamp strm); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateInit2 <C-R>=<SID>Abbreviation("deflateInit2(z_streamp strm,int level,int method,int windowBits,int memLevel,int strategy); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateSetDictionary <C-R>=<SID>Abbreviation("deflateSetDictionary(z_streamp strm,const Bytef *dictionary,uInt dictLength); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateGetDictionary <C-R>=<SID>Abbreviation("deflateGetDictionary(z_streamp strm,Bytef *dictionary,uInt *dictLength); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateCopy <C-R>=<SID>Abbreviation("deflateCopy(z_streamp dest,z_streamp source); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateReset <C-R>=<SID>Abbreviation("deflateReset(z_streamp strm); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateParams <C-R>=<SID>Abbreviation("deflateParams(z_streamp strm,int level,int strategy); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateTune <C-R>=<SID>Abbreviation("deflateTune(z_streamp strm,int good_length,int max_lazy,int nice_length,int max_chain); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateBound <C-R>=<SID>Abbreviation("deflateBound(z_streamp strm,uLong sourceLen); /* uLong */")<CR>
inoreabbrev <silent> <buffer> deflatePending <C-R>=<SID>Abbreviation("deflatePending(z_streamp strm,unsigned *pending,int *bits); /* int */")<CR>
inoreabbrev <silent> <buffer> deflatePrime <C-R>=<SID>Abbreviation("deflatePrime(z_streamp strm,int bits,int value); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateSetHeader <C-R>=<SID>Abbreviation("deflateSetHeader(z_streamp strm,gz_headerp head); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateInit2 <C-R>=<SID>Abbreviation("inflateInit2(z_streamp strm,int windowBits); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateSetDictionary <C-R>=<SID>Abbreviation("inflateSetDictionary(z_streamp strm,const Bytef *dictionary,uInt dictLength); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateGetDictionary <C-R>=<SID>Abbreviation("inflateGetDictionary(z_streamp strm,Bytef *dictionary,uInt *dictLength); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateSync <C-R>=<SID>Abbreviation("inflateSync(z_streamp strm); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateCopy <C-R>=<SID>Abbreviation("inflateCopy(z_streamp dest,z_streamp source); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateReset <C-R>=<SID>Abbreviation("inflateReset(z_streamp strm); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateReset2 <C-R>=<SID>Abbreviation("inflateReset2(z_streamp strm,int windowBits); /* int */")<CR>
inoreabbrev <silent> <buffer> inflatePrime <C-R>=<SID>Abbreviation("inflatePrime(z_streamp strm,int bits,int value); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateMark <C-R>=<SID>Abbreviation("inflateMark(z_streamp strm); /* long */")<CR>
inoreabbrev <silent> <buffer> inflateGetHeader <C-R>=<SID>Abbreviation("inflateGetHeader(z_streamp strm,gz_headerp head); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateBackInit <C-R>=<SID>Abbreviation("inflateBackInit(z_streamp strm,int windowBits,unsigned char FAR *window); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateBack <C-R>=<SID>Abbreviation("inflateBack(z_streamp strm,in_func in,void FAR *in_desc,out_func out,void FAR *out_desc); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateBackEnd <C-R>=<SID>Abbreviation("inflateBackEnd(z_streamp strm); /* int */")<CR>
inoreabbrev <silent> <buffer> zlibCompileFlags <C-R>=<SID>Abbreviation("zlibCompileFlags(void); /* uLong */")<CR>
inoreabbrev <silent> <buffer> compress <C-R>=<SID>Abbreviation("compress(Bytef *dest,uLongf *destLen,const Bytef *source,uLong sourceLen); /* int */")<CR>
inoreabbrev <silent> <buffer> compress2 <C-R>=<SID>Abbreviation("compress2(Bytef *dest,uLongf *destLen,const Bytef *source,uLong sourceLen,int level); /* int */")<CR>
inoreabbrev <silent> <buffer> compressBound <C-R>=<SID>Abbreviation("compressBound(uLong sourceLen); /* uLong */")<CR>
inoreabbrev <silent> <buffer> uncompress <C-R>=<SID>Abbreviation("uncompress(Bytef *dest,uLongf *destLen,const Bytef *source,uLong sourceLen); /* int */")<CR>
inoreabbrev <silent> <buffer> uncompress2 <C-R>=<SID>Abbreviation("uncompress2(Bytef *dest,uLongf *destLen,const Bytef *source,uLong *sourceLen); /* int */")<CR>
inoreabbrev <silent> <buffer> gzopen <C-R>=<SID>Abbreviation("gzopen(const char *path,const char *mode); /* gzFile */")<CR>
inoreabbrev <silent> <buffer> gzdopen <C-R>=<SID>Abbreviation("gzdopen(int fd,const char *mode); /* gzFile */")<CR>
inoreabbrev <silent> <buffer> gzbuffer <C-R>=<SID>Abbreviation("gzbuffer(gzFile file,unsigned size); /* int */")<CR>
inoreabbrev <silent> <buffer> gzsetparams <C-R>=<SID>Abbreviation("gzsetparams(gzFile file,int level,int strategy); /* int */")<CR>
inoreabbrev <silent> <buffer> gzread <C-R>=<SID>Abbreviation("gzread(gzFile file,voidp buf,unsigned len); /* int */")<CR>
inoreabbrev <silent> <buffer> gzfread <C-R>=<SID>Abbreviation("gzfread(voidp buf,z_size_t size,z_size_t nitems,gzFile file); /* z_size_t */")<CR>
inoreabbrev <silent> <buffer> gzwrite <C-R>=<SID>Abbreviation("gzwrite(gzFile file,voidpc buf,unsigned len); /* int */")<CR>
inoreabbrev <silent> <buffer> gzfwrite <C-R>=<SID>Abbreviation("gzfwrite(voidpc buf,z_size_t size,z_size_t nitems,gzFile file); /* z_size_t */")<CR>
inoreabbrev <silent> <buffer> gzprintf <C-R>=<SID>Abbreviation("gzprintf Z_ARG(gzFile file,const char *format,...); /* int */")<CR>
inoreabbrev <silent> <buffer> gzputs <C-R>=<SID>Abbreviation("gzputs(gzFile file,const char *s); /* int */")<CR>
inoreabbrev <silent> <buffer> gzgets <C-R>=<SID>Abbreviation("gzgets(gzFile file,char *buf,int len); /* char * */")<CR>
inoreabbrev <silent> <buffer> gzputc <C-R>=<SID>Abbreviation("gzputc(gzFile file,int c); /* int */")<CR>
inoreabbrev <silent> <buffer> gzgetc <C-R>=<SID>Abbreviation("gzgetc(gzFile file); /* int */")<CR>
inoreabbrev <silent> <buffer> gzungetc <C-R>=<SID>Abbreviation("gzungetc(int c,gzFile file); /* int */")<CR>
inoreabbrev <silent> <buffer> gzflush <C-R>=<SID>Abbreviation("gzflush(gzFile file,int flush); /* int */")<CR>
inoreabbrev <silent> <buffer> gzseek <C-R>=<SID>Abbreviation("gzseek(gzFile file,z_off_t offset,int whence); /* z_off_t */")<CR>
inoreabbrev <silent> <buffer> gzrewind <C-R>=<SID>Abbreviation("gzrewind(gzFile file); /* int */")<CR>
inoreabbrev <silent> <buffer> gztell <C-R>=<SID>Abbreviation("gztell(gzFile file); /* z_off_t */")<CR>
inoreabbrev <silent> <buffer> gzoffset <C-R>=<SID>Abbreviation("gzoffset(gzFile file); /* z_off_t */")<CR>
inoreabbrev <silent> <buffer> gzeof <C-R>=<SID>Abbreviation("gzeof(gzFile file); /* int */")<CR>
inoreabbrev <silent> <buffer> gzdirect <C-R>=<SID>Abbreviation("gzdirect(gzFile file); /* int */")<CR>
inoreabbrev <silent> <buffer> gzclose <C-R>=<SID>Abbreviation("gzclose(gzFile file); /* int */")<CR>
inoreabbrev <silent> <buffer> gzclose_r <C-R>=<SID>Abbreviation("gzclose_r(gzFile file); /* int */")<CR>
inoreabbrev <silent> <buffer> gzclose_w <C-R>=<SID>Abbreviation("gzclose_w(gzFile file); /* int */")<CR>
inoreabbrev <silent> <buffer> gzerror <C-R>=<SID>Abbreviation("gzerror(gzFile file,int *errnum); /* const char * */")<CR>
inoreabbrev <silent> <buffer> gzclearerr <C-R>=<SID>Abbreviation("gzclearerr(gzFile file); /* void */")<CR>
inoreabbrev <silent> <buffer> adler32 <C-R>=<SID>Abbreviation("adler32(uLong adler,const Bytef *buf,uInt len); /* uLong */")<CR>
inoreabbrev <silent> <buffer> adler32_z <C-R>=<SID>Abbreviation("adler32_z(uLong adler,const Bytef *buf,z_size_t len); /* uLong */")<CR>
inoreabbrev <silent> <buffer> adler32_combine <C-R>=<SID>Abbreviation("adler32_combine(uLong adler1,uLong adler2,z_off_t len2); /* uLong */")<CR>
inoreabbrev <silent> <buffer> crc32 <C-R>=<SID>Abbreviation("crc32(uLong crc,const Bytef *buf,uInt len); /* uLong */")<CR>
inoreabbrev <silent> <buffer> crc32_z <C-R>=<SID>Abbreviation("crc32_z(uLong crc,const Bytef *buf,z_size_t len); /* uLong */")<CR>
inoreabbrev <silent> <buffer> crc32_combine <C-R>=<SID>Abbreviation("crc32_combine(uLong crc1,uLong crc2,z_off_t len2); /* uLong */")<CR>
inoreabbrev <silent> <buffer> crc32_combine_gen <C-R>=<SID>Abbreviation("crc32_combine_gen(z_off_t len2); /* uLong */")<CR>
inoreabbrev <silent> <buffer> crc32_combine_op <C-R>=<SID>Abbreviation("crc32_combine_op(uLong crc1,uLong crc2,uLong op); /* uLong */")<CR>
inoreabbrev <silent> <buffer> deflateInit_ <C-R>=<SID>Abbreviation("deflateInit_(z_streamp strm,int level,const char *version,int stream_size); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateInit_ <C-R>=<SID>Abbreviation("inflateInit_(z_streamp strm,const char *version,int stream_size); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateInit2_ <C-R>=<SID>Abbreviation("deflateInit2_(z_streamp strm,int level,int method,int windowBits,int memLevel,int strategy,const char *version,int stream_size); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateInit2_ <C-R>=<SID>Abbreviation("inflateInit2_(z_streamp strm,int windowBits,const char *version,int stream_size); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateBackInit <C-R>=<SID>Abbreviation("inflateBackInit_(z_streamp strm,int windowBits,unsigned char FAR *window,const char *version,int stream_size); /* int */")<CR>
inoreabbrev <silent> <buffer> gzgetc_ <C-R>=<SID>Abbreviation("gzgetc_(gzFile file); /* int */")<CR>
inoreabbrev <silent> <buffer> zError <C-R>=<SID>Abbreviation("zError (int); /* const char * */")<CR>
inoreabbrev <silent> <buffer> inflateSyncPoint <C-R>=<SID>Abbreviation("inflateSyncPoint(z_streamp); /* int */")<CR>
inoreabbrev <silent> <buffer> get_crc_table <C-R>=<SID>Abbreviation("get_crc_table (void); /* const z_crc_t FAR * */")<CR>
inoreabbrev <silent> <buffer> inflateUndermine <C-R>=<SID>Abbreviation("inflateUndermine(z_streamp,int); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateValidate <C-R>=<SID>Abbreviation("inflateValidate(z_streamp,int); /* int */")<CR>
inoreabbrev <silent> <buffer> inflateCodesUsed <C-R>=<SID>Abbreviation("inflateCodesUsed(z_streamp); /* unsigned long */")<CR>
inoreabbrev <silent> <buffer> inflateResetKeep <C-R>=<SID>Abbreviation("inflateResetKeep(z_streamp); /* int */")<CR>
inoreabbrev <silent> <buffer> deflateResetKeep <C-R>=<SID>Abbreviation("deflateResetKeep(z_streamp); /* int */")<CR>
inoreabbrev <silent> <buffer> gzopen_w <C-R>=<SID>Abbreviation("gzopen_w(const wchar_t *path,const char *mode); /* gzFile */")<CR>
inoreabbrev <silent> <buffer> gzvprintf <C-R>=<SID>Abbreviation("gzvprintf Z_ARG(gzFile file,const char *format,va_list va); /* int */")<CR>

" XRender defs
inoreabbrev <silent> <buffer> XRenderAddGlyphs <C-R>=<SID>Abbreviation("XRenderAddGlyphs(display,GlyphSet  glyphset,_Xconst Glyph *gids,_Xconst XGlyphInfo  *glyphs,int nglyphs,_Xconst char*images,int nbyte_images); /* void */ ")<CR>
inoreabbrev <silent> <buffer> XRenderAddTraps <C-R>=<SID>Abbreviation("XRenderAddTraps(display,picture,xOff,yOff,XTrap*,ntrap); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderChangePicture <C-R>=<SID>Abbreviation("XRenderChangePicture(display,picture,CP,XRenderPictureAttributes*); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderCompositeDoublePoly <C-R>=<SID>Abbreviation("XRenderCompositeDoublePoly(display,PictOp,src,dst,XRenderPictFormat*,xSrc,ySrc,xDst,yDst,XPointDouble*,npoint,int winding); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderCompositeString16 XRenderCompositeString16(display,PictOp,src,dst,*maskFormat,GlyphSet glyphset,int xSrc,int ySrc,int xDst,int yDst,_Xconst unsigned short *string,int nchar); /* void */
inoreabbrev <silent> <buffer> XRenderCompositeString32 XRenderCompositeString32(display,int op,Picture src,Picture dst,*maskFormat,GlyphSet glyphset,int xSrc,int ySrc,int xDst,int yDst,_Xconst unsigned int *string,int nchar); /* void */
inoreabbrev <silent> <buffer> XRenderCompositeString8 XRenderCompositeString8(display,int op,Picture src,Picture dst,*maskFormat,GlyphSet glyphset,int xSrc,int ySrc,int xDst,int yDst,_Xconst char *string,int nchar); /* void */<ESC>175<CR> 
inoreabbrev <silent> <buffer> XRenderCompositeText16 XRenderCompositeText16(display,int op,Picture src,Picture dst,*maskFormat,int xSrc,int ySrc,int xDst,int yDst,_Xconst XGlyphElt16 *elts,int nelt); /* void */
inoreabbrev <silent> <buffer> XRenderCompositeText32 XRenderCompositeText32(display,int op,Picture src,Picture dst,*maskFormat,int xSrc,int ySrc,int xDst,int yDst,_Xconst XGlyphElt32 *elts,int nelt); /* void */
inoreabbrev <silent> <buffer> XRenderCompositeText8 XRenderCompositeText8(display,int op,Picture src,Picture dst,*maskFormat,int xSrc,int ySrc,int xDst,int yDst,_Xconst XGlyphElt8 *elts,int nelt); /* void */
inoreabbrev <silent> <buffer> XRenderCompositeTrapezoids <C-R>=<SID>Abbreviation("XRenderCompositeTrapezoids(display,PictOp,src,dst,XRenderPictFormat*,xSrc,ySrc,XTrapezoid*,ntrap); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderCompositeTriangles <C-R>=<SID>Abbreviation("XRenderCompositeTriangles(display,PictOp,src,dest,XRenderPictFormat*,xsrc,ysrc,XTriangle*,ntriangle); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderCompositeTriFan <C-R>=<SID>Abbreviation("XRenderCompositeTriFan(display,PictOp,src,dst,XRenderPictFormat*,xSrc,ySrc,XPointFixed*,npoint); /* void */ ")<CR>
inoreabbrev <silent> <buffer> XRenderCompositeTriStrip <C-R>=<SID>Abbreviation("XRenderCompositeTriStrip(display,PictOp,src,dest,XRenderPictFormat*,xSrc,ySrc,XPointFixed*,npoint); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderComposite <C-R>=<SID>Abbreviation("XRenderComposite(display,PictOp,src,mask,dst,src_x,src_y,mask_x,mask_y,dst_x,dst_y,width,height); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderCreateAnimCursor <C-R>=<SID>Abbreviation("XRenderCreateAnimCursor(display,int ncursor,XAnimCursor*cursors); /* Cursor */")<CR>
inoreabbrev <silent> <buffer> XRenderCreateConicalGradient <C-R>=<SID>Abbreviation("XRenderCreateConicalGradient(display,XConicalGradient*,XFixed *stops,XRenderColor *colors,int nstops); /* Picture */")<CR>
inoreabbrev <silent> <buffer> XRenderCreateCursor <C-R>=<SID>Abbreviation("XRenderCreateCursor(display,Picture source,unsigned int x,unsigned int y); /* Cursor */")<CR>
inoreabbrev <silent> <buffer> XRenderCreateGlyphSet <C-R>=<SID>Abbreviation("XRenderCreateGlyphSet(display,*format); /* GlyphSet */")<CR>
inoreabbrev <silent> <buffer> XRenderCreateLinearGradient <C-R>=<SID>Abbreviation("XRenderCreateLinearGradient(display,XLinearGradient*,XFixed *stops,XRenderColor* colors,int nstops); /* Picture */")<CR>
inoreabbrev <silent> <buffer> XRenderCreatePicture <C-R>=<SID>Abbreviation("XRenderCreatePicture(display,Drawable,XRenderPictFormat,valuemask,XRenderPictureAttributes*); /* Picture */")<CR>
inoreabbrev <silent> <buffer> XRenderCreateRadialGradient <C-R>=<SID>Abbreviation("XRenderCreateRadialGradient(display,XRadialGradient*,XFixed *stops,XRenderColor *colors,int nstops); /* Picture */")<CR>
inoreabbrev <silent> <buffer> XRenderCreateSolidFill <C-R>=<SID>Abbreviation("XRenderCreateSolidFill(display,XRenderColor*); /* Picture */")<CR>
inoreabbrev <silent> <buffer> XRenderFillRectangles <C-R>=<SID>Abbreviation("XRenderFillRectangles(display,PictOp,dst,XRenderColor*,XRectangle*,n_rects); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderFillRectangle <C-R>=<SID>Abbreviation("XRenderFillRectangle(display,PictOp,dst,XRenderColor*,x,y,width,height); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderFindFormat <C-R>=<SID>Abbreviation("XRenderFindFormat(display,unsigned long mask,*templ,int count); /* XRenderPictFormat* */")<CR>
inoreabbrev <silent> <buffer> XRenderFindStandardFormat <C-R>=<SID>Abbreviation("XRenderFindStandardFormat(display,PictStandardFormat); /* XRenderPictFormat* */")<CR>
inoreabbrev <silent> <buffer> XRenderFindVisualFormat <C-R>=<SID>Abbreviation("XRenderFindVisualFormat(display,Visual*); /* XRenderPictFormat* */")<CR>
inoreabbrev <silent> <buffer> XRenderFreeGlyphSet <C-R>=<SID>Abbreviation("XRenderFreeGlyphSet(display,GlyphSet glyphset); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderFreeGlyphs <C-R>=<SID>Abbreviation("XRenderFreeGlyphs(display,GlyphSet glyphset,_Xconst Glyph *gids,int nglyphs); /* void */ ")<CR>
inoreabbrev <silent> <buffer> XRenderFreePicture <C-R>=<SID>Abbreviation("XRenderFreePicture(display,picture); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderParseColor <C-R>=<SID>Abbreviation("XRenderParseColor(display,char *,XRenderColor*); /* Status */")<CR>
inoreabbrev <silent> <buffer> XRenderQueryExtension <C-R>=<SID>Abbreviation("XRenderQueryExtension(display,int *event_basep,int *error_basep); /* Bool */ ")<CR>
inoreabbrev <silent> <buffer> XRenderQueryFilters <C-R>=<SID>Abbreviation("XRenderQueryFilters(display,drawable); /* XFilters* */ ")<CR>
inoreabbrev <silent> <buffer> XRenderQueryFormats <C-R>=<SID>Abbreviation("XRenderQueryFormats(display); /* Status */")<CR>
inoreabbrev <silent> <buffer> XRenderQueryPictIndexValues <C-R>=<SID>Abbreviation("XRenderQueryPictIndexValues(display,  *format,int *num); /* XIndexValue* */")<CR>
inoreabbrev <silent> <buffer> XRenderQuerySubpixelOrder <C-R>=<SID>Abbreviation("XRenderQuerySubpixelOrder(display,int screen); /* int */")<CR>
inoreabbrev <silent> <buffer> XRenderQueryVersion <C-R>=<SID>Abbreviation("XRenderQueryVersion(display,int *major_versionp, int *minor_versionp); /* Status */")<CR>
inoreabbrev <silent> <buffer> XRenderReferenceGlyphSet <C-R>=<SID>Abbreviation("XRenderReferenceGlyphSet(display,GlyphSet existing); /* GlyphSet */")<CR>
inoreabbrev <silent> <buffer> XRenderSetPictureClipRectangles <C-R>=<SID>Abbreviation("XRenderSetPictureClipRectangles(display,Picture picture,int xOrigin,int yOrigin,_Xconst XRectangle *rects,int n); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderSetPictureClipRegion <C-R>=<SID>Abbreviation("XRenderSetPictureClipRegion(display,Picture picture,Region r); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderSetPictureFilter <C-R>=<SID>Abbreviation("XRenderSetPictureFilter(display,picture,char* filter,XFixed *params,int nparams); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderSetPictureTransform <C-R>=<SID>Abbreviation("XRenderSetPictureTransform(display,picture,XTransform*); /* void */")<CR>
inoreabbrev <silent> <buffer> XRenderSetSubpixelOrder <C-R>=<SID>Abbreviation("XRenderSetSubpixelOrder(display,screen,int subpixel); /* Bool */")<CR>

" Xft.h
inoreabbrev <silent> <buffer> XftCharExists <C-R>=<SID>Abbreviation("XftCharExists(display,XftFont*pub,FcChar32ucs4); /* FcBool  */")<CR>
inoreabbrev <silent> <buffer> XftCharFontSpecRender <C-R>=<SID>Abbreviation("XftCharFontSpecRender(display,intop,Picturesrc,Picturedst,intsrcx,intsrcy,_XconstXftCharFontSpec*chars,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftCharSpecRender <C-R>=<SID>Abbreviation("XftCharSpecRender(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,_XconstXftCharSpec*chars,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftColorAllocName <C-R>=<SID>Abbreviation("XftColorAllocName(display,_XconstVisual*visual,Colormapcmap,_Xconstchar*name,XftColor*result); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XftColorAllocValue <C-R>=<SID>Abbreviation("XftColorAllocValue(display,Visual*visual,Colormapcmap,_XconstXRenderColor*color,XftColor*result); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XftColorFree <C-R>=<SID>Abbreviation("XftColorFree(display,Visual*visual,Colormapcmap,XftColor*color); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDefaultHasRender <C-R>=<SID>Abbreviation("XftDefaultHasRender(display); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XftDefaultSet <C-R>=<SID>Abbreviation("XftDefaultSet(display,FcPattern*defaults); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XftDefaultSubstitute <C-R>=<SID>Abbreviation("XftDefaultSubstitute(display,intscreen,FcPattern*pattern); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDirSave <C-R>=<SID>Abbreviation("XftDirSave(FcFontSet*set,_Xconstchar*dir); /* FcBool  */")<CR>
inoreabbrev <silent> <buffer> XftDirScan <C-R>=<SID>Abbreviation("XftDirScan(FcFontSet*set,_Xconstchar*dir,FcBoolforce); /* FcBool  */")<CR>
inoreabbrev <silent> <buffer> XftDrawChange <C-R>=<SID>Abbreviation("XftDrawChange(XftDraw*draw,Drawable drawable); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDrawCharFontSpec <C-R>=<SID>Abbreviation("XftDrawCharFontSpec(XftDraw*draw,_XconstXftColor*color,_XconstXftCharFontSpec*chars,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDrawCharSpec <C-R>=<SID>Abbreviation("XftDrawCharSpec(XftDraw*draw,_XconstXftColor*color,XftFont*pub,_XconstXftCharSpec*chars,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDrawColormap <C-R>=<SID>Abbreviation("XftDrawColormap(XftDraw*draw); /* Colormap  */")<CR>
inoreabbrev <silent> <buffer> XftDrawCreateAlpha <C-R>=<SID>Abbreviation("XftDrawCreateAlpha(display,Pixmappixmap,intdepth); /* XftDraw *  */")<CR>
inoreabbrev <silent> <buffer> XftDrawCreateBitmap <C-R>=<SID>Abbreviation("XftDrawCreateBitmap(display,Pixmapbitmap); /* XftDraw *  */")<CR>
inoreabbrev <silent> <buffer> XftDrawCreate <C-R>=<SID>Abbreviation("XftDrawCreate(display,Drawabledrawable,Visual*visual,Colormapcolormap); /* XftDraw *  */")<CR>
inoreabbrev <silent> <buffer> XftDrawDestroy <C-R>=<SID>Abbreviation("XftDrawDestroy(XftDraw*draw); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDrawDisplay <C-R>=<SID>Abbreviation("XftDrawDisplay(XftDraw*draw); /* Display *  */")<CR>
inoreabbrev <silent> <buffer> XftDrawDrawable <C-R>=<SID>Abbreviation("XftDrawDrawable(XftDraw*draw); /* Drawable  */")<CR>
inoreabbrev <silent> <buffer> XftDrawGlyphFontSpec <C-R>=<SID>Abbreviation("XftDrawGlyphFontSpec(XftDraw*draw,_XconstXftColor*color,_XconstXftGlyphFontSpec*glyphs,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDrawGlyphSpec <C-R>=<SID>Abbreviation("XftDrawGlyphSpec(XftDraw*draw,_XconstXftColor*color,XftFont*pub,_XconstXftGlyphSpec*glyphs,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDrawGlyphs <C-R>=<SID>Abbreviation("XftDrawGlyphs(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFT_UInt*glyphs,intnglyphs); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDrawPicture <C-R>=<SID>Abbreviation("XftDrawPicture(XftDraw*draw); /* Picture  */")<CR>
inoreabbrev <silent> <buffer> XftDrawRect <C-R>=<SID>Abbreviation("XftDrawRect(XftDraw*draw,_XconstXftColor*color,intx,inty,unsignedintwidth,unsignedintheight); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDrawSetClipRectangles <C-R>=<SID>Abbreviation("XftDrawSetClipRectangles(XftDraw*draw,intxOrigin,intyOrigin,_XconstXRectangle*rects,intn); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XftDrawSetClip <C-R>=<SID>Abbreviation("XftDrawSetClip(XftDraw*draw,Regionr); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XftDrawSetSubwindowMode <C-R>=<SID>Abbreviation("XftDrawSetSubwindowMode(XftDraw*draw,intmode); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftDrawSrcPicture <C-R>=<SID>Abbreviation("XftDrawSrcPicture(XftDraw*draw,_XconstXftColor*color); /* Picture  */")<CR>
inoreabbrev <silent> <buffer> XftDrawString16 XftDrawString16(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar16*string,intlen); /* void  */
inoreabbrev <silent> <buffer> XftDrawString32 XftDrawString32(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar32*string,intlen); /* void  */
inoreabbrev <silent> <buffer> XftDrawString8 XftDrawString8(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar8*string,intlen); /* void  */
inoreabbrev <silent> <buffer> XftDrawStringUtf16 XftDrawStringUtf16(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar8*string,FcEndianendian,intlen); /* void  */
inoreabbrev <silent> <buffer> XftDrawStringUtf8 XftDrawStringUtf8(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar8*string,intlen); /* void  */
inoreabbrev <silent> <buffer> XftDrawVisual <C-R>=<SID>Abbreviation("XftDrawVisual(XftDraw*draw); /* Visual *  */")<CR>
inoreabbrev <silent> <buffer> XftFontCheckGlyph <C-R>=<SID>Abbreviation("XftFontCheckGlyph(display,XftFont*pub,FcBoolneed_bitmaps,FT_UIntglyph,FT_UInt*missing,int*nmissing); /* FcBool  */")<CR>
inoreabbrev <silent> <buffer> XftFontClose <C-R>=<SID>Abbreviation("XftFontClose(display,XftFont*pub); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftFontCopy <C-R>=<SID>Abbreviation("XftFontCopy(display,XftFont*pub); /* XftFont *  */")<CR>
inoreabbrev <silent> <buffer> XftFontInfoCreate <C-R>=<SID>Abbreviation("XftFontInfoCreate(display,_XconstFcPattern*pattern); /* XftFontInfo *  */")<CR>
inoreabbrev <silent> <buffer> XftFontInfoDestroy <C-R>=<SID>Abbreviation("XftFontInfoDestroy(display,XftFontInfo*fi); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftFontInfoEqual <C-R>=<SID>Abbreviation("XftFontInfoEqual(_XconstXftFontInfo*a,_XconstXftFontInfo*b); /* FcBool  */")<CR>
inoreabbrev <silent> <buffer> XftFontInfoHash <C-R>=<SID>Abbreviation("XftFontInfoHash(_XconstXftFontInfo*fi); /* FcChar32  */")<CR>
inoreabbrev <silent> <buffer> XftFontLoadGlyphs <C-R>=<SID>Abbreviation("XftFontLoadGlyphs(display,XftFont*pub,FcBoolneed_bitmaps,_XconstFT_UInt*glyphs,intnglyph); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftFontMatch <C-R>=<SID>Abbreviation("XftFontMatch(display,intscreen,_XconstFcPattern*pattern,FcResult*result); /* FcPattern *  */")<CR>
inoreabbrev <silent> <buffer> XftFontOpenInfo <C-R>=<SID>Abbreviation("XftFontOpenInfo(display,FcPattern*pattern,XftFontInfo*fi); /* XftFont *  */")<CR>
inoreabbrev <silent> <buffer> XftFontOpenName <C-R>=<SID>Abbreviation("XftFontOpenName(display,intscreen,_Xconstchar*name); /* XftFont *  */")<CR>
inoreabbrev <silent> <buffer> XftFontOpenPattern <C-R>=<SID>Abbreviation("XftFontOpenPattern(display,FcPattern*pattern); /* XftFont *  */")<CR>
inoreabbrev <silent> <buffer> XftFontOpen <C-R>=<SID>Abbreviation("XftFontOpen(display,intscreen,...)_X_SENTINEL(0); /* XftFont *  */")<CR>
inoreabbrev <silent> <buffer> XftFontOpenXlfd <C-R>=<SID>Abbreviation("XftFontOpenXlfd(display,intscreen,_Xconstchar*xlfd); /* XftFont *  */")<CR>
inoreabbrev <silent> <buffer> XftFontUnloadGlyphs <C-R>=<SID>Abbreviation("XftFontUnloadGlyphs(display,XftFont*pub,_XconstFT_UInt*glyphs,intnglyph); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftGlyphExtents <C-R>=<SID>Abbreviation("XftGlyphExtents(display,XftFont*pub,_XconstFT_UInt*glyphs,intnglyphs,XGlyphInfo*extents); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftGlyphFontSpecRender <C-R>=<SID>Abbreviation("XftGlyphFontSpecRender(display,intop,Picturesrc,Picturedst,intsrcx,intsrcy,_XconstXftGlyphFontSpec*glyphs,intnglyphs); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftGlyphRender <C-R>=<SID>Abbreviation("XftGlyphRender(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFT_UInt*glyphs,intnglyphs); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftGlyphSpecRender <C-R>=<SID>Abbreviation("XftGlyphSpecRender(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,_XconstXftGlyphSpec*glyphs,intnglyphs); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftInitFtLibrary <C-R>=<SID>Abbreviation("XftInitFtLibrary(); /* FcBool  */")<CR>
inoreabbrev <silent> <buffer> XftInit <C-R>=<SID>Abbreviation("XftInit(_Xconstchar*config); /* FcBool  */")<CR>
inoreabbrev <silent> <buffer> XftListFonts <C-R>=<SID>Abbreviation("XftListFonts(display,intscreen,...)_X_SENTINEL(0); /* FcFontSet *  */")<CR>
inoreabbrev <silent> <buffer> XftLockFace <C-R>=<SID>Abbreviation("XftLockFace(XftFont*pub); /* FT_Face  */")<CR>
inoreabbrev <silent> <buffer> XftTextExtents16 <C-R>=<SID>Abbreviation("XftTextExtents16(display,XftFont*pub,_XconstFcChar16*string,intlen,XGlyphInfo*extents); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextExtents32 <C-R>=<SID>Abbreviation("XftTextExtents32(display,XftFont*pub,_XconstFcChar32*string,intlen,XGlyphInfo*extents); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextExtents8 <C-R>=<SID>Abbreviation("XftTextExtents8(display,XftFont*pub,_XconstFcChar8*string,intlen,XGlyphInfo*extents); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextExtentsUtf16 <C-R>=<SID>Abbreviation("XftTextExtentsUtf16(display,XftFont*pub,_XconstFcChar8*string,FcEndianendian,intlen,XGlyphInfo*extents); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextExtentsUtf8 <C-R>=<SID>Abbreviation("XftTextExtentsUtf8(display,XftFont*pub,_XconstFcChar8*string,intlen,XGlyphInfo*extents); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextRender16BE <C-R>=<SID>Abbreviation("XftTextRender16BE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextRender16LE <C-R>=<SID>Abbreviation("XftTextRender16LE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextRender16 <C-R>=<SID>Abbreviation("XftTextRender16(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar16*string,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextRender32BE <C-R>=<SID>Abbreviation("XftTextRender32BE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextRender32LE <C-R>=<SID>Abbreviation("XftTextRender32LE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextRender32 <C-R>=<SID>Abbreviation("XftTextRender32(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar32*string,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextRender8 <C-R>=<SID>Abbreviation("XftTextRender8(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextRenderUtf16 <C-R>=<SID>Abbreviation("XftTextRenderUtf16(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,FcEndianendian,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftTextRenderUtf8 <C-R>=<SID>Abbreviation("XftTextRenderUtf8(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftUnlockFace <C-R>=<SID>Abbreviation("XftUnlockFace(XftFont*pub); /* void  */")<CR>
inoreabbrev <silent> <buffer> XftXlfdParse <C-R>=<SID>Abbreviation("XftXlfdParse(_Xconstchar*xlfd_orig,Boolignore_scalable,Boolcomplete); /* FcPattern *  */")<CR>

" Xlib defs X11 x11 xlib
inoreabbrev <silent> <buffer> XActivateScreenSaver <C-R>=<SID>Abbreviation("XActivateScreenSaver(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XAddConnectionWatch <C-R>=<SID>Abbreviation("XAddConnectionWatch(Display*,XConnectionWatchProc,XPointer); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XAddExtension <C-R>=<SID>Abbreviation("XAddExtension(Display*); /* XExtCodes * */")<CR>
inoreabbrev <silent> <buffer> XAddHost <C-R>=<SID>Abbreviation("XAddHost(Display*,XHostAddress*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XAddHosts <C-R>=<SID>Abbreviation("XAddHosts(Display*,XHostAddress*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XAddToExtensionList <C-R>=<SID>Abbreviation("XAddToExtensionList(struct _XExtData**,XExtData*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XAddToSaveSet <C-R>=<SID>Abbreviation("XAddToSaveSet(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XAllPlanes <C-R>=<SID>Abbreviation("XAllPlanes(); /* unsigned long  */")<CR>
inoreabbrev <silent> <buffer> XAllocColor <C-R>=<SID>Abbreviation("XAllocColor(Display*,Colormap,XColor*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XAllocColorCells <C-R>=<SID>Abbreviation("XAllocColorCells(Display*,Colormap,Bool ,unsigned long*,unsigned int,unsigned long*,unsigned int); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XAllocColorPlanes <C-R>=<SID>Abbreviation("XAllocColorPlanes(Display*,Colormap,Bool,unsigned long*,int,int,int,int,unsigned long*,unsigned long*,unsigned long*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XAllocNamedColor <C-R>=<SID>Abbreviation("XAllocNamedColor(Display*,Colormap,_Xconst char*,XColor*,XColor*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XAllowEvents <C-R>=<SID>Abbreviation("XAllowEvents(Display*,int,Time); /* int  */")<CR>
inoreabbrev <silent> <buffer> XAutoRepeatOff <C-R>=<SID>Abbreviation("XAutoRepeatOff(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XAutoRepeatOn <C-R>=<SID>Abbreviation("XAutoRepeatOn(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XBaseFontNameListOfFontSet <C-R>=<SID>Abbreviation("XBaseFontNameListOfFontSet(XFontSet); /* char * */")<CR>
inoreabbrev <silent> <buffer> XBell <C-R>=<SID>Abbreviation("XBell(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XBitmapBitOrder <C-R>=<SID>Abbreviation("XBitmapBitOrder(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XBitmapPad <C-R>=<SID>Abbreviation("XBitmapPad(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XBitmapUnit <C-R>=<SID>Abbreviation("XBitmapUnit(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XBlackPixel <C-R>=<SID>Abbreviation("XBlackPixel(Display*,int); /* unsigned long  */")<CR>
inoreabbrev <silent> <buffer> XBlackPixelOfScreen <C-R>=<SID>Abbreviation("XBlackPixelOfScreen(Screen*); /* unsigned long  */")<CR>
inoreabbrev <silent> <buffer> XCellsOfScreen <C-R>=<SID>Abbreviation("XCellsOfScreen(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XChangeActivePointerGrab <C-R>=<SID>Abbreviation("XChangeActivePointerGrab(Display*,unsigned int,Cursor,Time); /* int  */")<CR>
inoreabbrev <silent> <buffer> XChangeGC <C-R>=<SID>Abbreviation("XChangeGC(Display*,GC,unsigned long,XGCValues*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XChangeKeyboardControl <C-R>=<SID>Abbreviation("XChangeKeyboardControl(Display*,unsigned long,XKeyboardControl*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XChangeKeyboardMapping <C-R>=<SID>Abbreviation("XChangeKeyboardMapping(Display*,int,int,KeySym*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XChangePointerControl <C-R>=<SID>Abbreviation("XChangePointerControl(Display*,Bool,Bool,int,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XChangeProperty <C-R>=<SID>Abbreviation("XChangeProperty(Display*,Window,Atom,Atom,int,int,_Xconst unsigned char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XChangeSaveSet <C-R>=<SID>Abbreviation("XChangeSaveSet(Display*,Window,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XChangeWindowAttributes <C-R>=<SID>Abbreviation("XChangeWindowAttributes(Display*,Window,unsigned long,XSetWindowAttributes*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XCheckIfEvent <C-R>=<SID>Abbreviation("XCheckIfEvent(Display*,XEvent*,Bool(*)(Display*,XEvent*,XPointer),XPointer); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XCheckMaskEvent <C-R>=<SID>Abbreviation("XCheckMaskEvent(Display*,long,XEvent*); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XCheckTypedEvent <C-R>=<SID>Abbreviation("XCheckTypedEvent(Display*,int,XEvent*); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XCheckTypedWindowEvent <C-R>=<SID>Abbreviation("XCheckTypedWindowEvent(Display*,Window,int,XEvent*); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XCheckWindowEvent <C-R>=<SID>Abbreviation("XCheckWindowEvent(Display*,Window,long,XEvent*); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XCirculateSubwindows <C-R>=<SID>Abbreviation("XCirculateSubwindows(Display*,Window,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XCirculateSubwindowsDown <C-R>=<SID>Abbreviation("XCirculateSubwindowsDown(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XCirculateSubwindowsUp <C-R>=<SID>Abbreviation("XCirculateSubwindowsUp(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XClearArea <C-R>=<SID>Abbreviation("XClearArea(Display*,Window,int,int,unsigned int,unsigned int,Bool); /* int  */")<CR>
inoreabbrev <silent> <buffer> XClearWindow <C-R>=<SID>Abbreviation("XClearWindow(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XCloseDisplay <C-R>=<SID>Abbreviation("XCloseDisplay(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XCloseIM <C-R>=<SID>Abbreviation("XCloseIM(XIM); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XCloseOM <C-R>=<SID>Abbreviation("XCloseOM(XOM); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XConfigureWindow <C-R>=<SID>Abbreviation("XConfigureWindow(Display*,Window,unsigned int,XWindowChanges*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XConnectionNumber <C-R>=<SID>Abbreviation("XConnectionNumber(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XContextDependentDrawing <C-R>=<SID>Abbreviation("XContextDependentDrawing(XFontSet); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XContextualDrawing <C-R>=<SID>Abbreviation("XContextualDrawing(XFontSet); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XConvertSelection <C-R>=<SID>Abbreviation("XConvertSelection(Display*,Atom,Atom ,Atom,Window,Time); /* int  */")<CR>
inoreabbrev <silent> <buffer> XCopyArea <C-R>=<SID>Abbreviation("XCopyArea(Display*,Drawable,Drawable,GC,int,int,unsigned int,unsigned int,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XCopyColormapAndFree <C-R>=<SID>Abbreviation("XCopyColormapAndFree(Display*,Colormap); /* Colormap  */")<CR>
inoreabbrev <silent> <buffer> XCopyGC <C-R>=<SID>Abbreviation("XCopyGC(Display*,GC,unsigned long,GC); /* int  */")<CR>
inoreabbrev <silent> <buffer> XCopyPlane <C-R>=<SID>Abbreviation("XCopyPlane(Display*,Drawable,Drawable,GC,int,int,unsigned int,unsigned int,int,int,unsigned long); /* int  */")<CR>
inoreabbrev <silent> <buffer> XCreateBitmapFromData <C-R>=<SID>Abbreviation("XCreateBitmapFromData(Display*,Drawable,_Xconst char*,unsigned int,unsigned int); /* Pixmap  */")<CR>
inoreabbrev <silent> <buffer> XCreateColormap <C-R>=<SID>Abbreviation("XCreateColormap(Display*,Window,Visual*,int); /* Colormap  */")<CR>
inoreabbrev <silent> <buffer> XCreateFontCursor <C-R>=<SID>Abbreviation("XCreateFontCursor(Display*,unsigned int); /* Cursor  */")<CR>
inoreabbrev <silent> <buffer> XCreateFontSet <C-R>=<SID>Abbreviation("XCreateFontSet(Display*,_Xconst char*,char***,int*,char**); /* XFontSet  */")<CR>
inoreabbrev <silent> <buffer> XCreateGC <C-R>=<SID>Abbreviation("XCreateGC(Display*,Drawable,unsigned long,XGCValues*); /* GC  */")<CR>
inoreabbrev <silent> <buffer> XCreateGlyphCursor <C-R>=<SID>Abbreviation("XCreateGlyphCursor(Display*,Font,Font,unsigned int,unsigned int,XColor _Xconst *,XColor _Xconst *); /* Cursor  */")<CR>
inoreabbrev <silent> <buffer> XCreateIC <C-R>=<SID>Abbreviation("XCreateIC(XIM ,...) _X_SENTINEL(0); /* XIC  */")<CR>
inoreabbrev <silent> <buffer> XCreateImage <C-R>=<SID>Abbreviation("XCreateImage(Display*,Visual*,unsigned int,int,int,char*,unsigned int,unsigned int,int,int); /* XImage * */")<CR>
inoreabbrev <silent> <buffer> XCreateOC <C-R>=<SID>Abbreviation("XCreateOC(XOM,...) _X_SENTINEL(0); /* XOC  */")<CR>
inoreabbrev <silent> <buffer> XCreatePixmap <C-R>=<SID>Abbreviation("XCreatePixmap(Display*,Drawable,unsigned int,unsigned int,unsigned int); /* Pixmap  */")<CR>
inoreabbrev <silent> <buffer> XCreatePixmapCursor <C-R>=<SID>Abbreviation("XCreatePixmapCursor(Display*,Pixmap,Pixmap,XColor*,XColor*,unsigned int,unsigned int); /* Cursor  */")<CR>
inoreabbrev <silent> <buffer> XCreatePixmapFromBitmapData <C-R>=<SID>Abbreviation("XCreatePixmapFromBitmapData(Display*,Drawable,char*,unsigned int,unsigned int,unsigned long,unsigned long,unsigned int); /* Pixmap  */")<CR>
inoreabbrev <silent> <buffer> XCreateSimpleWindow <C-R>=<SID>Abbreviation("XCreateSimpleWindow(Display*,Window,int,int,unsigned int,unsigned int,unsigned int,unsigned long,unsigned long); /* Window  */")<CR>
inoreabbrev <silent> <buffer> XCreateWindow <C-R>=<SID>Abbreviation("XCreateWindow(Display*,Window,int,int,unsigned int,unsigned int,unsigned int,int,unsigned int,Visual*,unsigned long,XSetWindowAttributes*); /* Window  */")<CR>
inoreabbrev <silent> <buffer> XDefaultColormap <C-R>=<SID>Abbreviation("XDefaultColormap(Display*,int); /* Colormap  */")<CR>
inoreabbrev <silent> <buffer> XDefaultColormapOfScreen <C-R>=<SID>Abbreviation("XDefaultColormapOfScreen(Screen*); /* Colormap  */")<CR>
inoreabbrev <silent> <buffer> XDefaultDepth <C-R>=<SID>Abbreviation("XDefaultDepth(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDefaultDepthOfScreen <C-R>=<SID>Abbreviation("XDefaultDepthOfScreen(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDefaultGC <C-R>=<SID>Abbreviation("XDefaultGC(Display*,int); /* GC  */")<CR>
inoreabbrev <silent> <buffer> XDefaultGCOfScreen <C-R>=<SID>Abbreviation("XDefaultGCOfScreen(Screen*); /* GC  */")<CR>
inoreabbrev <silent> <buffer> XDefaultRootWindow <C-R>=<SID>Abbreviation("XDefaultRootWindow(Display*); /* Window  */")<CR>
inoreabbrev <silent> <buffer> XDefaultScreen <C-R>=<SID>Abbreviation("XDefaultScreen(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDefaultScreenOfDisplay <C-R>=<SID>Abbreviation("XDefaultScreenOfDisplay(Display*); /* Screen * */")<CR>
inoreabbrev <silent> <buffer> XDefaultVisual <C-R>=<SID>Abbreviation("XDefaultVisual(Display*,int); /* Visual * */")<CR>
inoreabbrev <silent> <buffer> XDefaultVisualOfScreen <C-R>=<SID>Abbreviation("XDefaultVisualOfScreen(Screen*); /* Visual * */")<CR>
inoreabbrev <silent> <buffer> XDefineCursor <C-R>=<SID>Abbreviation("XDefineCursor(Display*,Window,Cursor); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDeleteModifiermapEntry <C-R>=<SID>Abbreviation("XDeleteModifiermapEntry(XModifierKeymap*,#if NeedWidePrototypes unsigned int,#else KeyCode,#endif int); /* XModifierKeymap * */")<CR>
inoreabbrev <silent> <buffer> XDeleteProperty <C-R>=<SID>Abbreviation("XDeleteProperty(Display*,Window,Atom); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDestroyIC <C-R>=<SID>Abbreviation("XDestroyIC(XIC); /* void  */")<CR>
inoreabbrev <silent> <buffer> XDestroyOC <C-R>=<SID>Abbreviation("XDestroyOC(XOC); /* void  */")<CR>
inoreabbrev <silent> <buffer> XDestroySubwindows <C-R>=<SID>Abbreviation("XDestroySubwindows(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDestroyWindow <C-R>=<SID>Abbreviation("XDestroyWindow(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDirectionalDependentDrawing <C-R>=<SID>Abbreviation("XDirectionalDependentDrawing(XFontSet); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XDisableAccessControl <C-R>=<SID>Abbreviation("XDisableAccessControl(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDisplayCells <C-R>=<SID>Abbreviation("XDisplayCells(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDisplayHeight <C-R>=<SID>Abbreviation("XDisplayHeight(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDisplayHeightMM <C-R>=<SID>Abbreviation("XDisplayHeightMM(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDisplayKeycodes <C-R>=<SID>Abbreviation("XDisplayKeycodes(Display*,int*,int*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDisplayMotionBufferSize <C-R>=<SID>Abbreviation("XDisplayMotionBufferSize(Display*); /* unsigned long  */")<CR>
inoreabbrev <silent> <buffer> XDisplayName <C-R>=<SID>Abbreviation("XDisplayName(_Xconst char*); /* char * */")<CR>
inoreabbrev <silent> <buffer> XDisplayOfIM <C-R>=<SID>Abbreviation("XDisplayOfIM(XIM); /* Display * */")<CR>
inoreabbrev <silent> <buffer> XDisplayOfOM <C-R>=<SID>Abbreviation("XDisplayOfOM(XOM); /* Display * */")<CR>
inoreabbrev <silent> <buffer> XDisplayOfScreen <C-R>=<SID>Abbreviation("XDisplayOfScreen(Screen*); /* Display * */")<CR>
inoreabbrev <silent> <buffer> XDisplayPlanes <C-R>=<SID>Abbreviation("XDisplayPlanes(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDisplayString <C-R>=<SID>Abbreviation("XDisplayString(Display*); /* char * */")<CR>
inoreabbrev <silent> <buffer> XDisplayWidth <C-R>=<SID>Abbreviation("XDisplayWidth(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDisplayWidthMM <C-R>=<SID>Abbreviation("XDisplayWidthMM(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDoesBackingStore <C-R>=<SID>Abbreviation("XDoesBackingStore(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDoesSaveUnders <C-R>=<SID>Abbreviation("XDoesSaveUnders(Screen*); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XDrawArc <C-R>=<SID>Abbreviation("XDrawArc(Display*,Drawable,GC,int,int,unsigned int,unsigned int,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawArcs <C-R>=<SID>Abbreviation("XDrawArcs(Display*,Drawable,GC,XArc*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawImageString <C-R>=<SID>Abbreviation("XDrawImageString(Display*,Drawable,GC,int,int,_Xconst char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawImageString16 XDrawImageString16(Display*,Drawable,GC,int,int,_Xconst XChar2b*,int); /* int  */
inoreabbrev <silent> <buffer> XDrawLine <C-R>=<SID>Abbreviation("XDrawLine(Display*,Drawable,GC,int,int,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawLines <C-R>=<SID>Abbreviation("XDrawLines(Display*,Drawable,GC,XPoint*,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawPoint <C-R>=<SID>Abbreviation("XDrawPoint(Display*,Drawable,GC,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawPoints <C-R>=<SID>Abbreviation("XDrawPoints(Display*,Drawable,GC,XPoint*,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawRectangle <C-R>=<SID>Abbreviation("XDrawRectangle(Display*,Drawable,GC,int,int,unsigned int,unsigned int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawRectangles <C-R>=<SID>Abbreviation("XDrawRectangles(Display*,Drawable,GC,XRectangle*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawSegments <C-R>=<SID>Abbreviation("XDrawSegments(Display*,Drawable,GC,XSegment*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawString <C-R>=<SID>Abbreviation("XDrawString(Display*,Drawable,GC,int,int,_Xconst char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawString16 XDrawString16(Display*,Drawable,GC,int,int,_Xconst XChar2b*,int); /* int  */
inoreabbrev <silent> <buffer> XDrawText <C-R>=<SID>Abbreviation("XDrawText(Display*,Drawable,GC,int,int,XTextItem*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XDrawText16 XDrawText16(Display*,Drawable,GC,int,int,XTextItem16*,int); /* int  */
inoreabbrev <silent> <buffer> XEHeadOfExtensionList <C-R>=<SID>Abbreviation("XEHeadOfExtensionList(XEDataObject); /* XExtData ** */")<CR>
inoreabbrev <silent> <buffer> XEnableAccessControl <C-R>=<SID>Abbreviation("XEnableAccessControl(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XEventMaskOfScreen <C-R>=<SID>Abbreviation("XEventMaskOfScreen(Screen*); /* long  */")<CR>
inoreabbrev <silent> <buffer> XEventsQueued <C-R>=<SID>Abbreviation("XEventsQueued(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XExtendedMaxRequestSize <C-R>=<SID>Abbreviation("XExtendedMaxRequestSize(Display*); /* long  */")<CR>
inoreabbrev <silent> <buffer> XExtentsOfFontSet <C-R>=<SID>Abbreviation("XExtentsOfFontSet(XFontSet); /* XFontSetExtents * */")<CR>
inoreabbrev <silent> <buffer> XFetchBuffer <C-R>=<SID>Abbreviation("XFetchBuffer(Display*,int*,int); /* char * */")<CR>
inoreabbrev <silent> <buffer> XFetchBytes <C-R>=<SID>Abbreviation("XFetchBytes(Display*,int*); /* char * */")<CR>
inoreabbrev <silent> <buffer> XFetchName <C-R>=<SID>Abbreviation("XFetchName(Display*,Window,char**); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XFillArc <C-R>=<SID>Abbreviation("XFillArc(Display*,Drawable,GC,int,int,unsigned int,unsigned int,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFillArcs <C-R>=<SID>Abbreviation("XFillArcs(Display*,Drawable,GC,XArc*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFillPolygon <C-R>=<SID>Abbreviation("XFillPolygon(Display*,Drawable,GC,XPoint*,int,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFillRectangle <C-R>=<SID>Abbreviation("XFillRectangle(Display*,Drawable,GC,int,int,unsigned int,unsigned int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFillRectangles <C-R>=<SID>Abbreviation("XFillRectangles(Display*,Drawable,GC,XRectangle*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFilterEvent <C-R>=<SID>Abbreviation("XFilterEvent(XEvent*,Window); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XFindOnExtensionList <C-R>=<SID>Abbreviation("XFindOnExtensionList(XExtData**,int); /* XExtData * */")<CR>
inoreabbrev <silent> <buffer> XFlush <C-R>=<SID>Abbreviation("XFlush(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFlushGC <C-R>=<SID>Abbreviation("XFlushGC(Display*,GC); /* void  */")<CR>
inoreabbrev <silent> <buffer> XFontsOfFontSet <C-R>=<SID>Abbreviation("XFontsOfFontSet(XFontSet,XFontStruct***,char***); /* int  */")<CR>
inoreabbrev <silent> <buffer> XForceScreenSaver <C-R>=<SID>Abbreviation("XForceScreenSaver(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFree <C-R>=<SID>Abbreviation("XFree(void*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeColormap <C-R>=<SID>Abbreviation("XFreeColormap(Display*,Colormap); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeColors <C-R>=<SID>Abbreviation("XFreeColors(Display*,Colormap,unsigned long*,int,unsigned long); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeCursor <C-R>=<SID>Abbreviation("XFreeCursor(Display*,Cursor); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeEventData <C-R>=<SID>Abbreviation("XFreeEventData(Display*,XGenericEventCookie*); /* void  */")<CR>
inoreabbrev <silent> <buffer> XFreeExtensionList <C-R>=<SID>Abbreviation("XFreeExtensionList(char**); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeFont <C-R>=<SID>Abbreviation("XFreeFont(Display*,XFontStruct*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeFontInfo <C-R>=<SID>Abbreviation("XFreeFontInfo(char**,XFontStruct*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeFontNames <C-R>=<SID>Abbreviation("XFreeFontNames(char**); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeFontPath <C-R>=<SID>Abbreviation("XFreeFontPath(char**); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeFontSet <C-R>=<SID>Abbreviation("XFreeFontSet(Display*,XFontSet); /* void  */")<CR>
inoreabbrev <silent> <buffer> XFreeGC <C-R>=<SID>Abbreviation("XFreeGC(Display*,GC); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeModifiermap <C-R>=<SID>Abbreviation("XFreeModifiermap(XModifierKeymap*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreePixmap <C-R>=<SID>Abbreviation("XFreePixmap(Display*,Pixmap); /* int  */")<CR>
inoreabbrev <silent> <buffer> XFreeStringList <C-R>=<SID>Abbreviation("XFreeStringList(char**); /* void  */")<CR>
inoreabbrev <silent> <buffer> XGContextFromGC <C-R>=<SID>Abbreviation("XGContextFromGC(GC); /* GContext  */")<CR>
inoreabbrev <silent> <buffer> XGeometry <C-R>=<SID>Abbreviation("XGeometry(Display*,int,_Xconst char*,_Xconst char*,unsigned int,unsigned int,unsigned int,int,int,int*,int*,int*,int*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGetAtomName <C-R>=<SID>Abbreviation("XGetAtomName(Display*,Atom); /* char * */")<CR>
inoreabbrev <silent> <buffer> XGetAtomNames <C-R>=<SID>Abbreviation("XGetAtomNames(Display*,Atom*,int,char**); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XGetCommand <C-R>=<SID>Abbreviation("XGetCommand(Display*,Window,char***,int*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XGetDefault <C-R>=<SID>Abbreviation("XGetDefault(Display*,_Xconst char*,_Xconst char*); /* char * */")<CR>
inoreabbrev <silent> <buffer> XGetErrorDatabaseText <C-R>=<SID>Abbreviation("XGetErrorDatabaseText(Display*,_Xconst char*,_Xconst char*,_Xconst char*,char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGetErrorText <C-R>=<SID>Abbreviation("XGetErrorText(Display*,int,char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGetEventData <C-R>=<SID>Abbreviation("XGetEventData(Display*,XGenericEventCookie*); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XGetFontPath <C-R>=<SID>Abbreviation("XGetFontPath(Display*,int*); /* char ** */")<CR>
inoreabbrev <silent> <buffer> XGetFontProperty <C-R>=<SID>Abbreviation("XGetFontProperty(XFontStruct*,Atom,unsigned long*); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XGetGCValues <C-R>=<SID>Abbreviation("XGetGCValues(Display*,GC,unsigned long,XGCValues*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XGetGeometry <C-R>=<SID>Abbreviation("XGetGeometry(Display*,Drawable,Window*,int*,int*,unsigned int*,unsigned int*,unsigned int*,unsigned int*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XGetICValues <C-R>=<SID>Abbreviation("XGetICValues(XIC ,...) _X_SENTINEL(0); /* char * */")<CR>
inoreabbrev <silent> <buffer> XGetIMValues <C-R>=<SID>Abbreviation("XGetIMValues(XIM ,...) _X_SENTINEL(0); /* char * */")<CR>
inoreabbrev <silent> <buffer> XGetIconName <C-R>=<SID>Abbreviation("XGetIconName(Display*,Window,char**); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XGetImage <C-R>=<SID>Abbreviation("XGetImage(Display*,Drawable,int,int,unsigned int,unsigned int,unsigned long,int); /* XImage * */")<CR>
inoreabbrev <silent> <buffer> XGetInputFocus <C-R>=<SID>Abbreviation("XGetInputFocus(Display*,Window*,int*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGetKeyboardControl <C-R>=<SID>Abbreviation("XGetKeyboardControl(Display*,XKeyboardState*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGetKeyboardMapping <C-R>=<SID>Abbreviation("XGetKeyboardMapping(Display*,#if NeedWidePrototypes unsigned int,#else KeyCode,#endif int,int*); /* KeySym * */")<CR>
inoreabbrev <silent> <buffer> XGetModifierMapping <C-R>=<SID>Abbreviation("XGetModifierMapping(Display*); /* XModifierKeymap * */")<CR>
inoreabbrev <silent> <buffer> XGetMotionEvents <C-R>=<SID>Abbreviation("XGetMotionEvents(Display*,Window,Time,Time,int*); /* XTimeCoord * */")<CR>
inoreabbrev <silent> <buffer> XGetOCValues <C-R>=<SID>Abbreviation("XGetOCValues(XOC,...) _X_SENTINEL(0); /* char * */")<CR>
inoreabbrev <silent> <buffer> XGetOMValues <C-R>=<SID>Abbreviation("XGetOMValues(XOM,...) _X_SENTINEL(0); /* char * */")<CR>
inoreabbrev <silent> <buffer> XGetPointerControl <C-R>=<SID>Abbreviation("XGetPointerControl(Display*,int*,int*,int*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGetPointerMapping <C-R>=<SID>Abbreviation("XGetPointerMapping(Display*,unsigned char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGetScreenSaver <C-R>=<SID>Abbreviation("XGetScreenSaver(Display*,int*,int*,int*,int*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGetSelectionOwner <C-R>=<SID>Abbreviation("XGetSelectionOwner(Display*,Atom); /* Window  */")<CR>
inoreabbrev <silent> <buffer> XGetSubImage <C-R>=<SID>Abbreviation("XGetSubImage(Display*,Drawable,int,int,unsigned int,unsigned int,unsigned long,int,XImage*,int,int); /* XImage * */")<CR>
inoreabbrev <silent> <buffer> XGetTransientForHint <C-R>=<SID>Abbreviation("XGetTransientForHint(Display*,Window,Window*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XGetWMColormapWindows <C-R>=<SID>Abbreviation("XGetWMColormapWindows(Display*,Window,Window**,int*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XGetWMProtocols <C-R>=<SID>Abbreviation("XGetWMProtocols(Display*,Window,Atom**,int*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XGetWindowAttributes <C-R>=<SID>Abbreviation("XGetWindowAttributes(Display*,Window,XWindowAttributes*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XGetWindowProperty <C-R>=<SID>Abbreviation("XGetWindowProperty(Display*,Window,Atom,long,long,Bool,Atom,Atom*,int*,unsigned long*,unsigned long*,unsigned char**); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGrabButton <C-R>=<SID>Abbreviation("XGrabButton(Display*,unsigned int,unsigned int,Window,Bool,unsigned int,int,int,Window,Cursor); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGrabKey <C-R>=<SID>Abbreviation("XGrabKey(Display*,int,unsigned int,Window,Bool,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGrabKeyboard <C-R>=<SID>Abbreviation("XGrabKeyboard(Display*,Window,Bool,int,int,Time); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGrabPointer <C-R>=<SID>Abbreviation("XGrabPointer(Display*,Window,Bool,unsigned int,int,int,Window,Cursor,Time); /* int  */")<CR>
inoreabbrev <silent> <buffer> XGrabServer <C-R>=<SID>Abbreviation("XGrabServer(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XHeightMMOfScreen <C-R>=<SID>Abbreviation("XHeightMMOfScreen(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XHeightOfScreen <C-R>=<SID>Abbreviation("XHeightOfScreen(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XIMOfIC <C-R>=<SID>Abbreviation("XIMOfIC(XIC); /* XIM  */")<CR>
inoreabbrev <silent> <buffer> XIconifyWindow <C-R>=<SID>Abbreviation("XIconifyWindow(Display*,Window,int); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XIfEvent <C-R>=<SID>Abbreviation("XIfEvent(Display*,XEvent*,Bool(*)(Display*,XEvent*,XPointer),XPointer); /* int  */")<CR>
inoreabbrev <silent> <buffer> XImageByteOrder <C-R>=<SID>Abbreviation("XImageByteOrder(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XInitExtension <C-R>=<SID>Abbreviation("XInitExtension(Display*,_Xconst char*); /* XExtCodes * */")<CR>
inoreabbrev <silent> <buffer> XInitImage <C-R>=<SID>Abbreviation("XInitImage(XImage*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XInitThreads <C-R>=<SID>Abbreviation("XInitThreads(); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XInsertModifiermapEntry <C-R>=<SID>Abbreviation("XInsertModifiermapEntry(XModifierKeymap*,#if NeedWidePrototypes unsigned int,#else KeyCode,#endif int); /* XModifierKeymap * */")<CR>
inoreabbrev <silent> <buffer> XInstallColormap <C-R>=<SID>Abbreviation("XInstallColormap(Display*,Colormap); /* int  */")<CR>
inoreabbrev <silent> <buffer> XInternAtom <C-R>=<SID>Abbreviation("XInternAtom(Display*,_Xconst char*,Bool); /* Atom  */")<CR>
inoreabbrev <silent> <buffer> XInternAtoms <C-R>=<SID>Abbreviation("XInternAtoms(Display*,char**,int,Bool,Atom*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XInternalConnectionNumbers <C-R>=<SID>Abbreviation("XInternalConnectionNumbers(Display*,int**,int*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XKeycodeToKeysym <C-R>=<SID>Abbreviation("XKeycodeToKeysym(Display*,#if NeedWidePrototypes unsigned int,#else KeyCode,#endif int); /* KeySym  */")<CR>
inoreabbrev <silent> <buffer> XKeysymToKeycode <C-R>=<SID>Abbreviation("XKeysymToKeycode(Display*,KeySym); /* KeyCode  */")<CR>
inoreabbrev <silent> <buffer> XKeysymToString <C-R>=<SID>Abbreviation("XKeysymToString(KeySym); /* char * */")<CR>
inoreabbrev <silent> <buffer> XKillClient <C-R>=<SID>Abbreviation("XKillClient(Display*,XID); /* int  */")<CR>
inoreabbrev <silent> <buffer> XLastKnownRequestProcessed <C-R>=<SID>Abbreviation("XLastKnownRequestProcessed(Display*); /* unsigned long  */")<CR>
inoreabbrev <silent> <buffer> XListDepths <C-R>=<SID>Abbreviation("XListDepths(Display*,int,int*); /* int * */")<CR>
inoreabbrev <silent> <buffer> XListExtensions <C-R>=<SID>Abbreviation("XListExtensions(Display*,int*); /* char ** */")<CR>
inoreabbrev <silent> <buffer> XListFonts <C-R>=<SID>Abbreviation("XListFonts(Display*,_Xconst char*,int,int*); /* char ** */")<CR>
inoreabbrev <silent> <buffer> XListFontsWithInfo <C-R>=<SID>Abbreviation("XListFontsWithInfo(Display*,_Xconst char*,int,int*,XFontStruct**); /* char ** */")<CR>
inoreabbrev <silent> <buffer> XListHosts <C-R>=<SID>Abbreviation("XListHosts(Display*,int*,Bool*); /* XHostAddress * */")<CR>
inoreabbrev <silent> <buffer> XListInstalledColormaps <C-R>=<SID>Abbreviation("XListInstalledColormaps(Display*,Window,int*); /* Colormap * */")<CR>
inoreabbrev <silent> <buffer> XListPixmapFormats <C-R>=<SID>Abbreviation("XListPixmapFormats(Display*,int*); /* XPixmapFormatValues * */")<CR>
inoreabbrev <silent> <buffer> XListProperties <C-R>=<SID>Abbreviation("XListProperties(Display*,Window,int*); /* Atom * */")<CR>
inoreabbrev <silent> <buffer> XLoadFont <C-R>=<SID>Abbreviation("XLoadFont(Display*,_Xconst char*); /* Font  */")<CR>
inoreabbrev <silent> <buffer> XLoadQueryFont <C-R>=<SID>Abbreviation("XLoadQueryFont(Display*,_Xconst char*); /* XFontStruct * */")<CR>
inoreabbrev <silent> <buffer> XLocaleOfFontSet <C-R>=<SID>Abbreviation("XLocaleOfFontSet(XFontSet); /* char * */")<CR>
inoreabbrev <silent> <buffer> XLocaleOfIM <C-R>=<SID>Abbreviation("XLocaleOfIM(XIM); /* char * */")<CR>
inoreabbrev <silent> <buffer> XLocaleOfOM <C-R>=<SID>Abbreviation("XLocaleOfOM(XOM); /* char * */")<CR>
inoreabbrev <silent> <buffer> XLockDisplay <C-R>=<SID>Abbreviation("XLockDisplay(Display*); /* void  */")<CR>
inoreabbrev <silent> <buffer> XLookupColor <C-R>=<SID>Abbreviation("XLookupColor(Display*,Colormap,_Xconst char*,XColor*,XColor*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XLookupKeysym <C-R>=<SID>Abbreviation("XLookupKeysym(XKeyEvent*,int); /* KeySym  */")<CR>
inoreabbrev <silent> <buffer> XLowerWindow <C-R>=<SID>Abbreviation("XLowerWindow(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XMapRaised <C-R>=<SID>Abbreviation("XMapRaised(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XMapSubwindows <C-R>=<SID>Abbreviation("XMapSubwindows(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XMapWindow <C-R>=<SID>Abbreviation("XMapWindow(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XMaskEvent <C-R>=<SID>Abbreviation("XMaskEvent(Display*,long,XEvent*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XMaxCmapsOfScreen <C-R>=<SID>Abbreviation("XMaxCmapsOfScreen(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XMaxRequestSize <C-R>=<SID>Abbreviation("XMaxRequestSize(Display*); /* long  */")<CR>
inoreabbrev <silent> <buffer> XMinCmapsOfScreen <C-R>=<SID>Abbreviation("XMinCmapsOfScreen(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XMoveResizeWindow <C-R>=<SID>Abbreviation("XMoveResizeWindow(Display*,Window,int,int,unsigned int,unsigned int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XMoveWindow <C-R>=<SID>Abbreviation("XMoveWindow(Display*,Window,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XNewModifiermap <C-R>=<SID>Abbreviation("XNewModifiermap(int); /* XModifierKeymap * */")<CR>
inoreabbrev <silent> <buffer> XNextEvent <C-R>=<SID>Abbreviation("XNextEvent(Display*,XEvent*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XNextRequest <C-R>=<SID>Abbreviation("XNextRequest(Display*); /* unsigned long  */")<CR>
inoreabbrev <silent> <buffer> XNoOp <C-R>=<SID>Abbreviation("XNoOp(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XOMOfOC <C-R>=<SID>Abbreviation("XOMOfOC(XOC); /* XOM  */")<CR>
inoreabbrev <silent> <buffer> XOpenDisplay <C-R>=<SID>Abbreviation("XOpenDisplay(_Xconst char*); /* Display * */")<CR>
inoreabbrev <silent> <buffer> XOpenIM <C-R>=<SID>Abbreviation("XOpenIM(Display*,struct _XrmHashBucketRec*,char*,char*); /* XIM  */")<CR>
inoreabbrev <silent> <buffer> XOpenOM <C-R>=<SID>Abbreviation("XOpenOM(Display*,struct _XrmHashBucketRec*,_Xconst char*,_Xconst char*); /* XOM  */")<CR>
inoreabbrev <silent> <buffer> XParseColor <C-R>=<SID>Abbreviation("XParseColor(Display*,Colormap,_Xconst char*,XColor*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XParseGeometry <C-R>=<SID>Abbreviation("XParseGeometry(_Xconst char*,int*,int*,unsigned int*,unsigned int*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XPeekEvent <C-R>=<SID>Abbreviation("XPeekEvent(Display*,XEvent*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XPeekIfEvent <C-R>=<SID>Abbreviation("XPeekIfEvent(Display*,XEvent*,Bool(*)(Display*,XEvent*,XPointer),XPointer); /* int  */")<CR>
inoreabbrev <silent> <buffer> XPending <C-R>=<SID>Abbreviation("XPending(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XPlanesOfScreen <C-R>=<SID>Abbreviation("XPlanesOfScreen(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XProcessInternalConnection <C-R>=<SID>Abbreviation("XProcessInternalConnection(Display*,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> XProtocolRevision <C-R>=<SID>Abbreviation("XProtocolRevision(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XProtocolVersion <C-R>=<SID>Abbreviation("XProtocolVersion(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XPutBackEvent <C-R>=<SID>Abbreviation("XPutBackEvent(Display*,XEvent*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XPutImage <C-R>=<SID>Abbreviation("XPutImage(Display*,Drawable,GC,XImage*,int,int,int,int,unsigned int,unsigned int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XQLength <C-R>=<SID>Abbreviation("XQLength(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XQueryBestCursor <C-R>=<SID>Abbreviation("XQueryBestCursor(Display*,Drawable,unsigned int ,unsigned int,unsigned int*,unsigned int*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XQueryBestSize <C-R>=<SID>Abbreviation("XQueryBestSize(Display*,int,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XQueryBestStipple <C-R>=<SID>Abbreviation("XQueryBestStipple(Display*,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XQueryBestTile <C-R>=<SID>Abbreviation("XQueryBestTile(Display*,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XQueryColor <C-R>=<SID>Abbreviation("XQueryColor(Display*,Colormap,XColor*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XQueryColors <C-R>=<SID>Abbreviation("XQueryColors(Display*,Colormap,XColor*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XQueryExtension <C-R>=<SID>Abbreviation("XQueryExtension(Display*,_Xconst char*,int*,int*,int*); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XQueryFont <C-R>=<SID>Abbreviation("XQueryFont(Display*,XID); /* XFontStruct * */")<CR>
inoreabbrev <silent> <buffer> XQueryKeymap <C-R>=<SID>Abbreviation("XQueryKeymap(Display*,char [32]); /* int  */")<CR>
inoreabbrev <silent> <buffer> XQueryPointer <C-R>=<SID>Abbreviation("XQueryPointer(Display*,Window,Window*,Window*,int*,int*,int*,int*,unsigned int*); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XQueryTextExtents <C-R>=<SID>Abbreviation("XQueryTextExtents(Display*,XID,_Xconst char*,int,int*,int*,int*,XCharStruct*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XQueryTextExtents16 XQueryTextExtents16(Display*,XID,_Xconst XChar2b*,int,int*,int*,int*,XCharStruct*); /* int  */
inoreabbrev <silent> <buffer> XQueryTree <C-R>=<SID>Abbreviation("XQueryTree(Display*,Window,Window*,Window*,Window**,unsigned int*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XRaiseWindow <C-R>=<SID>Abbreviation("XRaiseWindow(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XReadBitmapFile <C-R>=<SID>Abbreviation("XReadBitmapFile(Display*,Drawable ,_Xconst char*,unsigned int*,unsigned int*,Pixmap*,int*,int*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XReadBitmapFileData <C-R>=<SID>Abbreviation("XReadBitmapFileData(_Xconst char*,unsigned int*,unsigned int*,unsigned char**,int*,int*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XRebindKeysym <C-R>=<SID>Abbreviation("XRebindKeysym(Display*,KeySym,KeySym*,int,_Xconst unsigned char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XRecolorCursor <C-R>=<SID>Abbreviation("XRecolorCursor(Display*,Cursor,XColor*,XColor*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XReconfigureWMWindow <C-R>=<SID>Abbreviation("XReconfigureWMWindow(Display*,Window,int,unsigned int,XWindowChanges*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XRefreshKeyboardMapping <C-R>=<SID>Abbreviation("XRefreshKeyboardMapping(XMappingEvent*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XRegisterIMInstantiateCallback <C-R>=<SID>Abbreviation("XRegisterIMInstantiateCallback(Display*,struct _XrmHashBucketRec*,char*,char*,XIDProc,XPointer); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XRemoveConnectionWatch <C-R>=<SID>Abbreviation("XRemoveConnectionWatch(Display*,XConnectionWatchProc,XPointer); /* void  */")<CR>
inoreabbrev <silent> <buffer> XRemoveFromSaveSet <C-R>=<SID>Abbreviation("XRemoveFromSaveSet(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XRemoveHost <C-R>=<SID>Abbreviation("XRemoveHost(Display*,XHostAddress*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XRemoveHosts <C-R>=<SID>Abbreviation("XRemoveHosts(Display*,XHostAddress*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XReparentWindow <C-R>=<SID>Abbreviation("XReparentWindow(Display*,Window,Window,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XResetScreenSaver <C-R>=<SID>Abbreviation("XResetScreenSaver(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XResizeWindow <C-R>=<SID>Abbreviation("XResizeWindow(Display*,Window,unsigned int,unsigned int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XResourceManagerString <C-R>=<SID>Abbreviation("XResourceManagerString(Display*); /* char * */")<CR>
inoreabbrev <silent> <buffer> XRestackWindows <C-R>=<SID>Abbreviation("XRestackWindows(Display*,Window*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XRootWindow <C-R>=<SID>Abbreviation("XRootWindow(Display*,int); /* Window  */")<CR>
inoreabbrev <silent> <buffer> XRootWindowOfScreen <C-R>=<SID>Abbreviation("XRootWindowOfScreen(Screen*); /* Window  */")<CR>
inoreabbrev <silent> <buffer> XRotateBuffers <C-R>=<SID>Abbreviation("XRotateBuffers(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XRotateWindowProperties <C-R>=<SID>Abbreviation("XRotateWindowProperties(Display*,Window,Atom*,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XScreenCount <C-R>=<SID>Abbreviation("XScreenCount(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XScreenNumberOfScreen <C-R>=<SID>Abbreviation("XScreenNumberOfScreen(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XScreenOfDisplay <C-R>=<SID>Abbreviation("XScreenOfDisplay(Display*,int); /* Screen * */")<CR>
inoreabbrev <silent> <buffer> XScreenResourceString <C-R>=<SID>Abbreviation("XScreenResourceString(Screen*); /* char * */")<CR>
inoreabbrev <silent> <buffer> XSelectInput <C-R>=<SID>Abbreviation("XSelectInput(Display*,Window,long); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSendEvent <C-R>=<SID>Abbreviation("XSendEvent(Display*,Window,Bool,long,XEvent*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XServerVendor <C-R>=<SID>Abbreviation("XServerVendor(Display*); /* char * */")<CR>
inoreabbrev <silent> <buffer> XSetAccessControl <C-R>=<SID>Abbreviation("XSetAccessControl(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetAfterFunction <C-R>=<SID>Abbreviation("int(*XSetAfterFunction(Display*,int(*)(Display*)))(Display*);")<CR>
inoreabbrev <silent> <buffer> XSetArcMode <C-R>=<SID>Abbreviation("XSetArcMode(Display*,GC,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetAuthorization <C-R>=<SID>Abbreviation("XSetAuthorization(char *,int,char *,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> XSetBackground <C-R>=<SID>Abbreviation("XSetBackground(Display*,GC,unsigned long); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetClipMask <C-R>=<SID>Abbreviation("XSetClipMask(Display*,GC,Pixmap); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetClipOrigin <C-R>=<SID>Abbreviation("XSetClipOrigin(Display*,GC,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetClipRectangles <C-R>=<SID>Abbreviation("XSetClipRectangles(Display*,GC,int,int,XRectangle*,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetCloseDownMode <C-R>=<SID>Abbreviation("XSetCloseDownMode(Display*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetCommand <C-R>=<SID>Abbreviation("XSetCommand(Display*,Window,char**,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetDashes <C-R>=<SID>Abbreviation("XSetDashes(Display*,GC,int,_Xconst char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetErrorHandler <C-R>=<SID>Abbreviation("XSetErrorHandler (XErrorHandler); /* XErrorHandler  */")<CR>
inoreabbrev <silent> <buffer> XSetFillRule <C-R>=<SID>Abbreviation("XSetFillRule(Display*,GC,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetFillStyle <C-R>=<SID>Abbreviation("XSetFillStyle(Display*,GC,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetFont <C-R>=<SID>Abbreviation("XSetFont(Display*,GC,Font); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetFontPath <C-R>=<SID>Abbreviation("XSetFontPath(Display*,char**,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetForeground <C-R>=<SID>Abbreviation("XSetForeground(Display*,GC,unsigned long); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetFunction <C-R>=<SID>Abbreviation("XSetFunction(Display*,GC,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetGraphicsExposures <C-R>=<SID>Abbreviation("XSetGraphicsExposures(Display*,GC,Bool); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetICFocus <C-R>=<SID>Abbreviation("XSetICFocus(XIC); /* void  */")<CR>
inoreabbrev <silent> <buffer> XSetICValues <C-R>=<SID>Abbreviation("XSetICValues(XIC ,...) _X_SENTINEL(0); /* char * */")<CR>
inoreabbrev <silent> <buffer> XSetIMValues <C-R>=<SID>Abbreviation("XSetIMValues(XIM ,...) _X_SENTINEL(0); /* char * */")<CR>
inoreabbrev <silent> <buffer> XSetIOErrorExitHandler <C-R>=<SID>Abbreviation("XSetIOErrorExitHandler (Display*,XIOErrorExitHandler,void*); /* void  */")<CR>
inoreabbrev <silent> <buffer> XSetIOErrorHandler <C-R>=<SID>Abbreviation("XSetIOErrorHandler (XIOErrorHandler); /* XIOErrorHandler  */")<CR>
inoreabbrev <silent> <buffer> XSetIconName <C-R>=<SID>Abbreviation("XSetIconName(Display*,Window,_Xconst char*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetInputFocus <C-R>=<SID>Abbreviation("XSetInputFocus(Display*,Window,int,Time); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetLineAttributes <C-R>=<SID>Abbreviation("XSetLineAttributes(Display*,GC,unsigned int,int,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetLocaleModifiers <C-R>=<SID>Abbreviation("XSetLocaleModifiers(const char*); /* char * */")<CR>
inoreabbrev <silent> <buffer> XSetModifierMapping <C-R>=<SID>Abbreviation("XSetModifierMapping(Display*,XModifierKeymap*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetOCValues <C-R>=<SID>Abbreviation("XSetOCValues(XOC,...) _X_SENTINEL(0); /* char * */")<CR>
inoreabbrev <silent> <buffer> XSetOMValues <C-R>=<SID>Abbreviation("XSetOMValues(XOM,...) _X_SENTINEL(0); /* char * */")<CR>
inoreabbrev <silent> <buffer> XSetPlaneMask <C-R>=<SID>Abbreviation("XSetPlaneMask(Display*,GC,unsigned long); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetPointerMapping <C-R>=<SID>Abbreviation("XSetPointerMapping(Display*,_Xconst unsigned char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetScreenSaver <C-R>=<SID>Abbreviation("XSetScreenSaver(Display*,int,int,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetSelectionOwner <C-R>=<SID>Abbreviation("XSetSelectionOwner(Display*,Atom ,Window,Time); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetState <C-R>=<SID>Abbreviation("XSetState(Display*,GC,unsigned long ,unsigned long,int,unsigned long); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetStipple <C-R>=<SID>Abbreviation("XSetStipple(Display*,GC,Pixmap); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetSubwindowMode <C-R>=<SID>Abbreviation("XSetSubwindowMode(Display*,GC,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetTSOrigin <C-R>=<SID>Abbreviation("XSetTSOrigin(Display*,GC,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetTile <C-R>=<SID>Abbreviation("XSetTile(Display*,GC,Pixmap); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetTransientForHint <C-R>=<SID>Abbreviation("XSetTransientForHint(Display*,Window,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetWMColormapWindows <C-R>=<SID>Abbreviation("XSetWMColormapWindows(Display*,Window,Window*,int); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XSetWMProtocols <C-R>=<SID>Abbreviation("XSetWMProtocols(Display*,Window,Atom*,int); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XSetWindowBackground <C-R>=<SID>Abbreviation("XSetWindowBackground(Display*,Window,unsigned long); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetWindowBackgroundPixmap <C-R>=<SID>Abbreviation("XSetWindowBackgroundPixmap(Display*,Window,Pixmap); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetWindowBorder <C-R>=<SID>Abbreviation("XSetWindowBorder(Display*,Window,unsigned long); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetWindowBorderPixmap <C-R>=<SID>Abbreviation("XSetWindowBorderPixmap(Display*,Window,Pixmap); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetWindowBorderWidth <C-R>=<SID>Abbreviation("XSetWindowBorderWidth(Display*,Window,unsigned int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSetWindowColormap <C-R>=<SID>Abbreviation("XSetWindowColormap(Display*,Window,Colormap); /* int  */")<CR>
inoreabbrev <silent> <buffer> XStoreBuffer <C-R>=<SID>Abbreviation("XStoreBuffer(Display*,_Xconst char*,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XStoreBytes <C-R>=<SID>Abbreviation("XStoreBytes(Display*,_Xconst char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XStoreColor <C-R>=<SID>Abbreviation("XStoreColor(Display*,Colormap,XColor*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XStoreColors <C-R>=<SID>Abbreviation("XStoreColors(Display*,Colormap,XColor*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XStoreName <C-R>=<SID>Abbreviation("XStoreName(Display*,Window,_Xconst char*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XStoreNamedColor <C-R>=<SID>Abbreviation("XStoreNamedColor(Display*,Colormap,_Xconst char*,unsigned long,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XStringToKeysym <C-R>=<SID>Abbreviation("XStringToKeysym(_Xconst char*); /* KeySym  */")<CR>
inoreabbrev <silent> <buffer> XSupportsLocale <C-R>=<SID>Abbreviation("XSupportsLocale (); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XSync <C-R>=<SID>Abbreviation("XSync(Display*,Bool); /* int  */")<CR>
inoreabbrev <silent> <buffer> XSynchronize <C-R>=<SID>Abbreviation("int(*XSynchronize(Display*,Bool))(Display*);")<CR>
inoreabbrev <silent> <buffer> XTextExtents <C-R>=<SID>Abbreviation("XTextExtents(XFontStruct*,_Xconst char*,int,int*,int*,int*,XCharStruct*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XTextExtents16 XTextExtents16(XFontStruct*,_Xconst XChar2b*,int,int*,int*,int*,XCharStruct*); /* int  */
inoreabbrev <silent> <buffer> XTextWidth <C-R>=<SID>Abbreviation("XTextWidth(XFontStruct*,_Xconst char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XTextWidth16 XTextWidth16(XFontStruct*,_Xconst XChar2b*,int); /* int  */
inoreabbrev <silent> <buffer> XTranslateCoordinates <C-R>=<SID>Abbreviation("XTranslateCoordinates(Display*,Window,Window,int,int,int*,int*,Window*); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XUndefineCursor <C-R>=<SID>Abbreviation("XUndefineCursor(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XUngrabButton <C-R>=<SID>Abbreviation("XUngrabButton(Display*,unsigned int,unsigned int,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XUngrabKey <C-R>=<SID>Abbreviation("XUngrabKey(Display*,int,unsigned int,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XUngrabKeyboard <C-R>=<SID>Abbreviation("XUngrabKeyboard(Display*,Time); /* int  */")<CR>
inoreabbrev <silent> <buffer> XUngrabPointer <C-R>=<SID>Abbreviation("XUngrabPointer(Display*,Time); /* int  */")<CR>
inoreabbrev <silent> <buffer> XUngrabServer <C-R>=<SID>Abbreviation("XUngrabServer(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XUninstallColormap <C-R>=<SID>Abbreviation("XUninstallColormap(Display*,Colormap); /* int  */")<CR>
inoreabbrev <silent> <buffer> XUnloadFont <C-R>=<SID>Abbreviation("XUnloadFont(Display*,Font); /* int  */")<CR>
inoreabbrev <silent> <buffer> XUnlockDisplay <C-R>=<SID>Abbreviation("XUnlockDisplay(Display*); /* void  */")<CR>
inoreabbrev <silent> <buffer> XUnmapSubwindows <C-R>=<SID>Abbreviation("XUnmapSubwindows(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XUnmapWindow <C-R>=<SID>Abbreviation("XUnmapWindow(Display*,Window); /* int  */")<CR>
inoreabbrev <silent> <buffer> XUnregisterIMInstantiateCallback <C-R>=<SID>Abbreviation("XUnregisterIMInstantiateCallback(Display*,struct _XrmHashBucketRec*,char*,char*,XIDProc,XPointer); /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XUnsetICFocus <C-R>=<SID>Abbreviation("XUnsetICFocus(XIC); /* void  */")<CR>
inoreabbrev <silent> <buffer> XVaCreateNestedList <C-R>=<SID>Abbreviation("XVaCreateNestedList(int ,...) _X_SENTINEL(0); /* XVaNestedList  */")<CR>
inoreabbrev <silent> <buffer> XVendorRelease <C-R>=<SID>Abbreviation("XVendorRelease(Display*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XVisualIDFromVisual <C-R>=<SID>Abbreviation("XVisualIDFromVisual(Visual*); /* VisualID  */")<CR>
inoreabbrev <silent> <buffer> XWarpPointer <C-R>=<SID>Abbreviation("XWarpPointer(Display*,Window,Window,int,int,unsigned int,unsigned int,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XWhitePixel <C-R>=<SID>Abbreviation("XWhitePixel(Display*,int); /* unsigned long  */")<CR>
inoreabbrev <silent> <buffer> XWhitePixelOfScreen <C-R>=<SID>Abbreviation("XWhitePixelOfScreen(Screen*); /* unsigned long  */")<CR>
inoreabbrev <silent> <buffer> XWidthMMOfScreen <C-R>=<SID>Abbreviation("XWidthMMOfScreen(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XWidthOfScreen <C-R>=<SID>Abbreviation("XWidthOfScreen(Screen*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XWindowEvent <C-R>=<SID>Abbreviation("XWindowEvent(Display*,Window,long,XEvent*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XWithdrawWindow <C-R>=<SID>Abbreviation("XWithdrawWindow(Display*,Window,int); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XWriteBitmapFile <C-R>=<SID>Abbreviation("XWriteBitmapFile(Display*,_Xconst char*,Pixmap,unsigned int,unsigned int,int,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XmbDrawImageString <C-R>=<SID>Abbreviation("XmbDrawImageString(Display*,Drawable,XFontSet,GC,int,int,_Xconst char*,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> XmbDrawString <C-R>=<SID>Abbreviation("XmbDrawString(Display*,Drawable,XFontSet,GC,int,int,_Xconst char*,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> XmbDrawText <C-R>=<SID>Abbreviation("XmbDrawText(Display*,Drawable,GC,int,int,XmbTextItem*,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> XmbLookupString <C-R>=<SID>Abbreviation("XmbLookupString(XIC,XKeyPressedEvent*,char*,int,KeySym*,Status*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XmbResetIC <C-R>=<SID>Abbreviation("XmbResetIC(XIC); /* char * */")<CR>
inoreabbrev <silent> <buffer> XmbTextEscapement <C-R>=<SID>Abbreviation("XmbTextEscapement(XFontSet,_Xconst char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XmbTextExtents <C-R>=<SID>Abbreviation("XmbTextExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XmbTextPerCharExtents <C-R>=<SID>Abbreviation("XmbTextPerCharExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XrmInitialize <C-R>=<SID>Abbreviation("XrmInitialize(); /* void  */")<CR>
inoreabbrev <silent> <buffer> Xutf8DrawImageString <C-R>=<SID>Abbreviation("Xutf8DrawImageString(Display*,Drawable,XFontSet,GC,int,int,_Xconst char*,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> Xutf8DrawString <C-R>=<SID>Abbreviation("Xutf8DrawString(Display*,Drawable,XFontSet,GC,int,int,_Xconst char*,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> Xutf8DrawText <C-R>=<SID>Abbreviation("Xutf8DrawText(Display*,Drawable,GC,int,int,XmbTextItem*,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> Xutf8LookupString <C-R>=<SID>Abbreviation("Xutf8LookupString(XIC,XKeyPressedEvent*,char*,int,KeySym*,Status*); /* int  */")<CR>
inoreabbrev <silent> <buffer> Xutf8ResetIC <C-R>=<SID>Abbreviation("Xutf8ResetIC(XIC); /* char * */")<CR>
inoreabbrev <silent> <buffer> Xutf8TextEscapement <C-R>=<SID>Abbreviation("Xutf8TextEscapement(XFontSet,_Xconst char*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> Xutf8TextExtents <C-R>=<SID>Abbreviation("Xutf8TextExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*); /* int  */")<CR>
inoreabbrev <silent> <buffer> Xutf8TextPerCharExtents <C-R>=<SID>Abbreviation("Xutf8TextPerCharExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> XwcDrawImageString <C-R>=<SID>Abbreviation("XwcDrawImageString(Display*,Drawable,XFontSet,GC,int,int,_Xconst wchar_t*,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> XwcDrawString <C-R>=<SID>Abbreviation("XwcDrawString(Display*,Drawable,XFontSet,GC,int,int,_Xconst wchar_t*,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> XwcDrawText <C-R>=<SID>Abbreviation("XwcDrawText(Display*,Drawable,GC,int,int,XwcTextItem*,int); /* void  */")<CR>
inoreabbrev <silent> <buffer> XwcLookupString <C-R>=<SID>Abbreviation("XwcLookupString(XIC,XKeyPressedEvent*,wchar_t*,int,KeySym*,Status*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XwcResetIC <C-R>=<SID>Abbreviation("XwcResetIC(XIC); /* wchar_t * */")<CR>
inoreabbrev <silent> <buffer> XwcTextEscapement <C-R>=<SID>Abbreviation("XwcTextEscapement(XFontSet,_Xconst wchar_t*,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> XwcTextExtents <C-R>=<SID>Abbreviation("XwcTextExtents(XFontSet,_Xconst wchar_t*,int,XRectangle*,XRectangle*); /* int  */")<CR>
inoreabbrev <silent> <buffer> XwcTextPerCharExtents <C-R>=<SID>Abbreviation("XwcTextPerCharExtents(XFontSet,_Xconst wchar_t*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); /* Status  */")<CR>
inoreabbrev <silent> <buffer> _Xmblen <C-R>=<SID>Abbreviation("_Xmblen(char *str,int len); /* int  */")<CR>
inoreabbrev <silent> <buffer> _Xmbtowc <C-R>=<SID>Abbreviation("_Xmbtowc(wchar_t *,char *,int); /* int  */")<CR>
inoreabbrev <silent> <buffer> _Xwctomb <C-R>=<SID>Abbreviation("_Xwctomb(char *,wchar_t); /* int  */")<CR>

"XKBlib.h xkblib XKBlib
inoreabbrev <silent> <buffer> XkbTranslateKeySym <C-R>=<SID>Abbreviation("XkbTranslateKeySym(Display*,KeySym *,unsigned int,char*,int,int*) /* int  */")<CR>
inoreabbrev <silent> <buffer> XkbResizeKeyActions <C-R>=<SID>Abbreviation("XkbResizeKeyActions(XkbDescPtr,int,int) /* XkbAction * */")<CR>
inoreabbrev <silent> <buffer> XkbUpdateKeyTypeVirtualMods <C-R>=<SID>Abbreviation("XkbUpdateKeyTypeVirtualMods(XkbDescPtr,XkbKeyTypePtr,unsigned int,XkbChangesPtr) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbIgnoreExtension <C-R>=<SID>Abbreviation("XkbIgnoreExtension(Bool) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbOpenDisplay <C-R>=<SID>Abbreviation("XkbOpenDisplay(char*,int*,int*,int*,int*,int*) /* Display * */")<CR>
inoreabbrev <silent> <buffer> XkbQueryExtension <C-R>=<SID>Abbreviation("XkbQueryExtension(Display*,int*,int*,int*,int*,int*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbUseExtension <C-R>=<SID>Abbreviation("XkbUseExtension(Display*,int*,int*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbLibraryVersion <C-R>=<SID>Abbreviation("XkbLibraryVersion(int*,int*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetXlibControls <C-R>=<SID>Abbreviation("XkbSetXlibControls(Display*,unsigned int,unsigned int) /* unsigned int  */")<CR>
inoreabbrev <silent> <buffer> XkbGetXlibControls <C-R>=<SID>Abbreviation("XkbGetXlibControls(Display*) /* unsigned int  */")<CR>
inoreabbrev <silent> <buffer> XkbXlibControlsImplemented <C-R>=<SID>Abbreviation("XkbXlibControlsImplemented() /* unsigned int  */")<CR>
inoreabbrev <silent> <buffer> XkbSetAtomFuncs <C-R>=<SID>Abbreviation("XkbSetAtomFuncs(XkbInternAtomFunc,XkbGetAtomNameFunc) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbKeycodeToKeysym <C-R>=<SID>Abbreviation("XkbKeycodeToKeysym(Display *,#if NeedWidePrototypes unsigned int,#else KeyCode,#endif int,int) /* KeySym  */")<CR>
inoreabbrev <silent> <buffer> XkbKeysymToModifiers <C-R>=<SID>Abbreviation("XkbKeysymToModifiers(Display*,KeySym) /* unsigned int  */")<CR>
inoreabbrev <silent> <buffer> XkbLookupKeySym <C-R>=<SID>Abbreviation("XkbLookupKeySym(Display*,KeyCode,unsigned int,unsigned int*,KeySym *) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbLookupKeyBinding <C-R>=<SID>Abbreviation("XkbLookupKeyBinding(Display*,KeySym,unsigned int,char*,int,int*) /* int  */")<CR>
inoreabbrev <silent> <buffer> XkbTranslateKeyCode <C-R>=<SID>Abbreviation("XkbTranslateKeyCode(XkbDescPtr,KeyCode,unsigned int,unsigned int*,KeySym *) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetAutoRepeatRate <C-R>=<SID>Abbreviation("XkbSetAutoRepeatRate(Display*,unsigned int,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbGetAutoRepeatRate <C-R>=<SID>Abbreviation("XkbGetAutoRepeatRate(Display*,unsigned int,unsigned int*,unsigned int*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbChangeEnabledControls <C-R>=<SID>Abbreviation("XkbChangeEnabledControls(Display*,unsigned int,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbDeviceBell <C-R>=<SID>Abbreviation("XkbDeviceBell(Display*,Window,int,int,int,int,Atom) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbForceDeviceBell <C-R>=<SID>Abbreviation("XkbForceDeviceBell(Display*,int,int,int,int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbDeviceBellEvent <C-R>=<SID>Abbreviation("XkbDeviceBellEvent(Display*,Window,int,int,int,int,Atom) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbBell <C-R>=<SID>Abbreviation("XkbBell(Display*,Window,int,Atom) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbForceBell <C-R>=<SID>Abbreviation("XkbForceBell(Display*,int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbBellEvent <C-R>=<SID>Abbreviation("XkbBellEvent(Display*,Window,int,Atom) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSelectEvents <C-R>=<SID>Abbreviation("XkbSelectEvents(Display*,unsigned int,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSelectEventDetails <C-R>=<SID>Abbreviation("XkbSelectEventDetails(Display*,unsigned int,unsigned int,unsigned long,unsigned long) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbNoteMapChanges <C-R>=<SID>Abbreviation("XkbNoteMapChanges(XkbMapChangesPtr,XkbMapNotifyEvent *,unsigned int) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbNoteNameChanges <C-R>=<SID>Abbreviation("XkbNoteNameChanges(XkbNameChangesPtr,XkbNamesNotifyEvent *,unsigned int) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbGetIndicatorState <C-R>=<SID>Abbreviation("XkbGetIndicatorState(Display*,unsigned int,unsigned int*) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetDeviceIndicatorState <C-R>=<SID>Abbreviation("XkbGetDeviceIndicatorState(Display*,unsigned int,unsigned int,unsigned int,unsigned int*) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetIndicatorMap <C-R>=<SID>Abbreviation("XkbGetIndicatorMap(Display*,unsigned long,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbSetIndicatorMap <C-R>=<SID>Abbreviation("XkbSetIndicatorMap(Display*,unsigned long,XkbDescPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbGetNamedIndicator <C-R>=<SID>Abbreviation("XkbGetNamedIndicator(Display*,Atom,int*,Bool *,XkbIndicatorMapPtr,Bool *) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbGetNamedDeviceIndicator <C-R>=<SID>Abbreviation("XkbGetNamedDeviceIndicator(Display*,unsigned int,unsigned int,unsigned int,Atom,int*,Bool *,XkbIndicatorMapPtr,Bool *) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetNamedIndicator <C-R>=<SID>Abbreviation("XkbSetNamedIndicator(Display*,Atom,Bool,Bool,Bool,XkbIndicatorMapPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetNamedDeviceIndicator <C-R>=<SID>Abbreviation("XkbSetNamedDeviceIndicator(Display*,unsigned int,unsigned int,unsigned int,Atom,Bool,Bool,Bool,XkbIndicatorMapPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbLockModifiers <C-R>=<SID>Abbreviation("XkbLockModifiers(Display*,unsigned int,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbLatchModifiers <C-R>=<SID>Abbreviation("XkbLatchModifiers(Display*,unsigned int,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbLockGroup <C-R>=<SID>Abbreviation("XkbLockGroup(Display*,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbLatchGroup <C-R>=<SID>Abbreviation("XkbLatchGroup(Display*,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetServerInternalMods <C-R>=<SID>Abbreviation("XkbSetServerInternalMods(Display*,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetIgnoreLockMods <C-R>=<SID>Abbreviation("XkbSetIgnoreLockMods(Display*,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbVirtualModsToReal <C-R>=<SID>Abbreviation("XkbVirtualModsToReal(XkbDescPtr,unsigned int,unsigned int*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbComputeEffectiveMap <C-R>=<SID>Abbreviation("XkbComputeEffectiveMap(XkbDescPtr,XkbKeyTypePtr,unsigned char*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbInitCanonicalKeyTypes <C-R>=<SID>Abbreviation("XkbInitCanonicalKeyTypes(XkbDescPtr,unsigned int,int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbAllocKeyboard <C-R>=<SID>Abbreviation("XkbAllocKeyboard() /* XkbDescPtr  */")<CR>
inoreabbrev <silent> <buffer> XkbFreeKeyboard <C-R>=<SID>Abbreviation("XkbFreeKeyboard(XkbDescPtr,unsigned int,Bool) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbAllocClientMap <C-R>=<SID>Abbreviation("XkbAllocClientMap(XkbDescPtr,unsigned int,unsigned int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbAllocServerMap <C-R>=<SID>Abbreviation("XkbAllocServerMap(XkbDescPtr,unsigned int,unsigned int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbFreeClientMap <C-R>=<SID>Abbreviation("XkbFreeClientMap(XkbDescPtr,unsigned int,Bool) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbFreeServerMap <C-R>=<SID>Abbreviation("XkbFreeServerMap(XkbDescPtr,unsigned int,Bool) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbAddKeyType <C-R>=<SID>Abbreviation("XkbAddKeyType(XkbDescPtr,Atom,int,Bool,int) /* XkbKeyTypePtr  */")<CR>
inoreabbrev <silent> <buffer> XkbAllocIndicatorMaps <C-R>=<SID>Abbreviation("XkbAllocIndicatorMaps(XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbFreeIndicatorMaps <C-R>=<SID>Abbreviation("XkbFreeIndicatorMaps(XkbDescPtr) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbGetMap <C-R>=<SID>Abbreviation("XkbGetMap(Display*,unsigned int,unsigned int) /* XkbDescPtr  */")<CR>
inoreabbrev <silent> <buffer> XkbGetUpdatedMap <C-R>=<SID>Abbreviation("XkbGetUpdatedMap(Display*,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetMapChanges <C-R>=<SID>Abbreviation("XkbGetMapChanges(Display*,XkbDescPtr,XkbMapChangesPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbRefreshKeyboardMapping <C-R>=<SID>Abbreviation("XkbRefreshKeyboardMapping(XkbMapNotifyEvent *) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetKeyTypes <C-R>=<SID>Abbreviation("XkbGetKeyTypes(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetKeySyms <C-R>=<SID>Abbreviation("XkbGetKeySyms(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetKeyActions <C-R>=<SID>Abbreviation("XkbGetKeyActions(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetKeyBehaviors <C-R>=<SID>Abbreviation("XkbGetKeyBehaviors(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetVirtualMods <C-R>=<SID>Abbreviation("XkbGetVirtualMods(Display*,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetKeyExplicitComponents <C-R>=<SID>Abbreviation("XkbGetKeyExplicitComponents(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetKeyModifierMap <C-R>=<SID>Abbreviation("XkbGetKeyModifierMap(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetKeyVirtualModMap <C-R>=<SID>Abbreviation("XkbGetKeyVirtualModMap(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbAllocControls <C-R>=<SID>Abbreviation("XkbAllocControls(XkbDescPtr,unsigned int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbFreeControls <C-R>=<SID>Abbreviation("XkbFreeControls(XkbDescPtr,unsigned int,Bool) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbGetControls <C-R>=<SID>Abbreviation("XkbGetControls(Display*,unsigned long,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbSetControls <C-R>=<SID>Abbreviation("XkbSetControls(Display*,unsigned long,XkbDescPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbNoteControlsChanges <C-R>=<SID>Abbreviation("XkbNoteControlsChanges(XkbControlsChangesPtr,XkbControlsNotifyEvent *,unsigned int) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbAllocCompatMap <C-R>=<SID>Abbreviation("XkbAllocCompatMap(XkbDescPtr,unsigned int,unsigned int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbFreeCompatMap <C-R>=<SID>Abbreviation("XkbFreeCompatMap(XkbDescPtr,unsigned int,Bool) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbGetCompatMap <C-R>=<SID>Abbreviation("XkbGetCompatMap(Display*,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbSetCompatMap <C-R>=<SID>Abbreviation("XkbSetCompatMap(Display*,unsigned int,XkbDescPtr,Bool) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbAddSymInterpret <C-R>=<SID>Abbreviation("XkbAddSymInterpret(XkbDescPtr,XkbSymInterpretPtr,Bool,XkbChangesPtr) /* XkbSymInterpretPtr  */")<CR>
inoreabbrev <silent> <buffer> XkbAllocNames <C-R>=<SID>Abbreviation("XkbAllocNames(XkbDescPtr,unsigned int,int,int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetNames <C-R>=<SID>Abbreviation("XkbGetNames(Display*,unsigned int,XkbDescPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbSetNames <C-R>=<SID>Abbreviation("XkbSetNames(Display*,unsigned int,unsigned int,unsigned int,XkbDescPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbChangeNames <C-R>=<SID>Abbreviation("XkbChangeNames(Display*,XkbDescPtr,XkbNameChangesPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbFreeNames <C-R>=<SID>Abbreviation("XkbFreeNames(XkbDescPtr,unsigned int,Bool) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbGetState <C-R>=<SID>Abbreviation("XkbGetState(Display*,unsigned int,XkbStatePtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbSetMap <C-R>=<SID>Abbreviation("XkbSetMap(Display*,unsigned int,XkbDescPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbChangeMap <C-R>=<SID>Abbreviation("XkbChangeMap(Display*,XkbDescPtr,XkbMapChangesPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetDetectableAutoRepeat <C-R>=<SID>Abbreviation("XkbSetDetectableAutoRepeat(Display*,Bool,Bool *) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbGetDetectableAutoRepeat <C-R>=<SID>Abbreviation("XkbGetDetectableAutoRepeat(Display*,Bool *) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetAutoResetControls <C-R>=<SID>Abbreviation("XkbSetAutoResetControls(Display*,unsigned int,unsigned int*,unsigned int*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbGetAutoResetControls <C-R>=<SID>Abbreviation("XkbGetAutoResetControls(Display*,unsigned int*,unsigned int*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetPerClientControls <C-R>=<SID>Abbreviation("XkbSetPerClientControls(Display*,unsigned int,unsigned int*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbGetPerClientControls <C-R>=<SID>Abbreviation("XkbGetPerClientControls(Display*,unsigned int*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbCopyKeyType <C-R>=<SID>Abbreviation("XkbCopyKeyType(XkbKeyTypePtr,XkbKeyTypePtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbCopyKeyTypes <C-R>=<SID>Abbreviation("XkbCopyKeyTypes(XkbKeyTypePtr,XkbKeyTypePtr,int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbResizeKeyType <C-R>=<SID>Abbreviation("XkbResizeKeyType(XkbDescPtr,int,int,Bool,int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbResizeKeySyms <C-R>=<SID>Abbreviation("XkbResizeKeySyms(XkbDescPtr,int,int) /* KeySym * */")<CR>
inoreabbrev <silent> <buffer> XkbChangeTypesOfKey <C-R>=<SID>Abbreviation("XkbChangeTypesOfKey(XkbDescPtr,int,int,unsigned int,int*,XkbMapChangesPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbChangeKeycodeRange <C-R>=<SID>Abbreviation("XkbChangeKeycodeRange(XkbDescPtr,int,int,XkbChangesPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbListComponents <C-R>=<SID>Abbreviation("XkbListComponents(Display*,unsigned int,XkbComponentNamesPtr,int*) /* XkbComponentListPtr  */")<CR>
inoreabbrev <silent> <buffer> XkbFreeComponentList <C-R>=<SID>Abbreviation("XkbFreeComponentList(XkbComponentListPtr) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbGetKeyboard <C-R>=<SID>Abbreviation("XkbGetKeyboard(Display*,unsigned int,unsigned int) /* XkbDescPtr  */")<CR>
inoreabbrev <silent> <buffer> XkbGetKeyboardByName <C-R>=<SID>Abbreviation("XkbGetKeyboardByName(Display*,unsigned int,XkbComponentNamesPtr,unsigned int,unsigned int,Bool) /* XkbDescPtr  */")<CR>
inoreabbrev <silent> <buffer> XkbKeyTypesForCoreSymbols <C-R>=<SID>Abbreviation("XkbKeyTypesForCoreSymbols( XkbDescPtr,int,KeySym *,unsigned int,int*,KeySym *) /* int  */")<CR>
inoreabbrev <silent> <buffer> XkbApplyCompatMapToKey <C-R>=<SID>Abbreviation("XkbApplyCompatMapToKey( XkbDescPtr,KeyCode,XkbChangesPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbUpdateMapFromCore <C-R>=<SID>Abbreviation("XkbUpdateMapFromCore( XkbDescPtr,KeyCode,int,int,KeySym *,XkbChangesPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbAddDeviceLedInfo <C-R>=<SID>Abbreviation("XkbAddDeviceLedInfo(XkbDeviceInfoPtr,unsigned int,unsigned int) /* XkbDeviceLedInfoPtr  */")<CR>
inoreabbrev <silent> <buffer> XkbResizeDeviceButtonActions <C-R>=<SID>Abbreviation("XkbResizeDeviceButtonActions(XkbDeviceInfoPtr,unsigned int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbAllocDeviceInfo <C-R>=<SID>Abbreviation("XkbAllocDeviceInfo(unsigned int,unsigned int,unsigned int) /* XkbDeviceInfoPtr  */")<CR>
inoreabbrev <silent> <buffer> XkbFreeDeviceInfo <C-R>=<SID>Abbreviation("XkbFreeDeviceInfo(XkbDeviceInfoPtr,unsigned int,Bool) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbNoteDeviceChanges <C-R>=<SID>Abbreviation("XkbNoteDeviceChanges(XkbDeviceChangesPtr,XkbExtensionDeviceNotifyEvent *,unsigned int) /* void  */")<CR>
inoreabbrev <silent> <buffer> XkbGetDeviceInfo <C-R>=<SID>Abbreviation("XkbGetDeviceInfo(Display*,unsigned int,unsigned int,unsigned int,unsigned int) /* XkbDeviceInfoPtr  */")<CR>
inoreabbrev <silent> <buffer> XkbGetDeviceInfoChanges <C-R>=<SID>Abbreviation("XkbGetDeviceInfoChanges(Display*,XkbDeviceInfoPtr,XkbDeviceChangesPtr) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetDeviceButtonActions <C-R>=<SID>Abbreviation("XkbGetDeviceButtonActions(Display*,XkbDeviceInfoPtr,Bool,unsigned int,unsigned int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbGetDeviceLedInfo <C-R>=<SID>Abbreviation("XkbGetDeviceLedInfo(Display*,XkbDeviceInfoPtr,unsigned int,unsigned int,unsigned int) /* Status  */")<CR>
inoreabbrev <silent> <buffer> XkbSetDeviceInfo <C-R>=<SID>Abbreviation("XkbSetDeviceInfo(Display*,unsigned int,XkbDeviceInfoPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbChangeDeviceInfo <C-R>=<SID>Abbreviation("XkbChangeDeviceInfo(Display*,XkbDeviceInfoPtr,XkbDeviceChangesPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetDeviceLedInfo <C-R>=<SID>Abbreviation("XkbSetDeviceLedInfo(Display*,XkbDeviceInfoPtr,unsigned int,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbSetDeviceButtonActions <C-R>=<SID>Abbreviation("XkbSetDeviceButtonActions(Display*,XkbDeviceInfoPtr,unsigned int,unsigned int) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbToControl <C-R>=<SID>Abbreviation("XkbToControl(char) /* char  */")<CR>
inoreabbrev <silent> <buffer> XkbSetDebuggingFlags <C-R>=<SID>Abbreviation("XkbSetDebuggingFlags(Display*,unsigned int,unsigned int,char*,unsigned int,unsigned int,unsigned int*,unsigned int*) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbApplyVirtualModChanges <C-R>=<SID>Abbreviation("XkbApplyVirtualModChanges( XkbDescPtr,unsigned int,XkbChangesPtr) /* Bool  */")<CR>
inoreabbrev <silent> <buffer> XkbUpdateActionVirtualMods <C-R>=<SID>Abbreviation("XkbUpdateActionVirtualMods(XkbDescPtr,XkbAction *,unsigned int) /* Bool  */")<CR>

" Xpm.h defs
inoreabbrev <silent> <buffer> XpmAttributesSize <C-R>=<SID>Abbreviation("XpmAttributesSize(); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateBufferFromImage <C-R>=<SID>Abbreviation("XpmCreateBufferFromImage(Display *display,char **buffer_return,XImage *image,XImage *shapeimage,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateBufferFromPixmap <C-R>=<SID>Abbreviation("XpmCreateBufferFromPixmap(Display *display,char **buffer_return,Pixmap pixmap,Pixmap shapemask,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateBufferFromXpmImage <C-R>=<SID>Abbreviation("XpmCreateBufferFromXpmImage(char **buffer_return,XpmImage *image,XpmInfo *info); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateDataFromImage <C-R>=<SID>Abbreviation("XpmCreateDataFromImage(Display *display,char ***data_return,XImage *image,XImage *shapeimage,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateDataFromPixmap <C-R>=<SID>Abbreviation("XpmCreateDataFromPixmap(Display *display,char ***data_return,Pixmap pixmap,Pixmap shapemask,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateDataFromXpmImage <C-R>=<SID>Abbreviation("XpmCreateDataFromXpmImage(char ***data_return,XpmImage *image,XpmInfo *info); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateImageFromBuffer <C-R>=<SID>Abbreviation("XpmCreateImageFromBuffer(Display *display,char *buffer,XImage **image_return,XImage **shapemask_return,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateImageFromData <C-R>=<SID>Abbreviation("XpmCreateImageFromData(Display *display,char **data,XImage **image_return,XImage **shapemask_return,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateImageFromXpmImage <C-R>=<SID>Abbreviation("XpmCreateImageFromXpmImage(Display *display,XpmImage *image,XImage **image_return,XImage **shapeimage_return,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreatePixmapFromBuffer <C-R>=<SID>Abbreviation("XpmCreatePixmapFromBuffer(Display *display,Drawable d,char *buffer,Pixmap *pixmap_return,Pixmap *shapemask_return,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreatePixmapFromData <C-R>=<SID>Abbreviation("XpmCreatePixmapFromData(Display *display,Drawable d,char **data,Pixmap *pixmap_return,Pixmap *shapemask_return,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreatePixmapFromXpmImage <C-R>=<SID>Abbreviation("XpmCreatePixmapFromXpmImage(Display *display,Drawable d,XpmImage *image,Pixmap *pixmap_return,Pixmap *shapemask_return,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateXpmImageFromBuffer <C-R>=<SID>Abbreviation("XpmCreateXpmImageFromBuffer(char *buffer,XpmImage *image,XpmInfo *info); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateXpmImageFromData <C-R>=<SID>Abbreviation("XpmCreateXpmImageFromData(char **data,XpmImage *image,XpmInfo *info); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateXpmImageFromImage <C-R>=<SID>Abbreviation("XpmCreateXpmImageFromImage(Display *display,XImage *image,XImage *shapeimage,XpmImage *xpmimage,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmCreateXpmImageFromPixmap <C-R>=<SID>Abbreviation("XpmCreateXpmImageFromPixmap(Display *display,Pixmap pixmap,Pixmap shapemask,XpmImage *xpmimage,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmFree <C-R>=<SID>Abbreviation("XpmFree(void *ptr); /* void  */")<CR>
inoreabbrev <silent> <buffer> XpmFreeAttributes <C-R>=<SID>Abbreviation("XpmFreeAttributes(XpmAttributes *attributes); /* void  */")<CR>
inoreabbrev <silent> <buffer> XpmFreeExtensions <C-R>=<SID>Abbreviation("XpmFreeExtensions(XpmExtension *extensions,int nextensions); /* void  */")<CR>
inoreabbrev <silent> <buffer> XpmFreeXpmImage <C-R>=<SID>Abbreviation("XpmFreeXpmImage(XpmImage *image); /* void  */")<CR>
inoreabbrev <silent> <buffer> XpmFreeXpmInfo <C-R>=<SID>Abbreviation("XpmFreeXpmInfo(XpmInfo *info); /* void  */")<CR>
inoreabbrev <silent> <buffer> XpmGetErrorString <C-R>=<SID>Abbreviation("XpmGetErrorString(int errcode); /* char*  */")<CR>
inoreabbrev <silent> <buffer> XpmGetParseError <C-R>=<SID>Abbreviation("XpmGetParseError(char *filename,int *linenum_return,int *charnum_return); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmLibraryVersion <C-R>=<SID>Abbreviation("XpmLibraryVersion(); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmReadFileToBuffer <C-R>=<SID>Abbreviation("XpmReadFileToBuffer(const char *filename,char **buffer_return); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmReadFileToData <C-R>=<SID>Abbreviation("XpmReadFileToData(const char *filename,char ***data_return); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmReadFileToImage <C-R>=<SID>Abbreviation("XpmReadFileToImage(Display *display,const char *filename,XImage **image_return,XImage **shapeimage_return,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmReadFileToPixmap <C-R>=<SID>Abbreviation("XpmReadFileToPixmap(Display *display,Drawable d,const char *filename,Pixmap *pixmap_return,Pixmap *shapemask_return,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmReadFileToXpmImage <C-R>=<SID>Abbreviation("XpmReadFileToXpmImage(const char *filename,XpmImage *image,XpmInfo *info); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmWriteFileFromBuffer <C-R>=<SID>Abbreviation("XpmWriteFileFromBuffer(const char *filename,char *buffer); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmWriteFileFromData <C-R>=<SID>Abbreviation("XpmWriteFileFromData(const char *filename,char **data); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmWriteFileFromImage <C-R>=<SID>Abbreviation("XpmWriteFileFromImage(Display *display,const char *filename,XImage *image,XImage *shapeimage,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmWriteFileFromPixmap <C-R>=<SID>Abbreviation("XpmWriteFileFromPixmap(Display *display,const char *filename,Pixmap pixmap,Pixmap shapemask,XpmAttributes *attributes); /* int  */")<CR>
inoreabbrev <silent> <buffer> XpmWriteFileFromXpmImage <C-R>=<SID>Abbreviation("XpmWriteFileFromXpmImage(const char *filename,XpmImage *image,XpmInfo *info); /* int  */")<CR>

" cairo.h defs
inoreabbrev <silent> <buffer> cairo_clip <C-R>=<SID>Abbreviation("cairo_clip(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_clip_preserve <C-R>=<SID>Abbreviation("cairo_clip_preserve(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_close_path <C-R>=<SID>Abbreviation("cairo_close_path(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_copy_clip_rectangle_list <C-R>=<SID>Abbreviation("cairo_copy_clip_rectangle_list(cairo_t *cr); /*cairo_rectangle_list_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_copy_page <C-R>=<SID>Abbreviation("cairo_copy_page(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_copy_path <C-R>=<SID>Abbreviation("cairo_copy_path(cairo_t *cr); /*cairo_path_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_copy_path_flat <C-R>=<SID>Abbreviation("cairo_copy_path_flat(cairo_t *cr); /*cairo_path_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_create <C-R>=<SID>Abbreviation("cairo_create(cairo_surface_t *target); /*cairo_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_debug_reset_static_data <C-R>=<SID>Abbreviation("cairo_debug_reset_static_data(); /*void */")<CR>
inoreabbrev <silent> <buffer> cairo_destroy <C-R>=<SID>Abbreviation("cairo_destroy(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_acquire <C-R>=<SID>Abbreviation("cairo_device_acquire(cairo_device_t *device); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_destroy <C-R>=<SID>Abbreviation("cairo_device_destroy(cairo_device_t *device); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_finish <C-R>=<SID>Abbreviation("cairo_device_finish(cairo_device_t *device); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_flush <C-R>=<SID>Abbreviation("cairo_device_flush(cairo_device_t *device); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_get_reference_count <C-R>=<SID>Abbreviation("cairo_device_get_reference_count(cairo_device_t *device); /*unsigned int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_get_type <C-R>=<SID>Abbreviation("cairo_device_get_type(cairo_device_t *device); /*cairo_device_type_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_observer_elapsed <C-R>=<SID>Abbreviation("cairo_device_observer_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_observer_fill_elapsed <C-R>=<SID>Abbreviation("cairo_device_observer_fill_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_observer_glyphs_elapsed <C-R>=<SID>Abbreviation("cairo_device_observer_glyphs_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_observer_mask_elapsed <C-R>=<SID>Abbreviation("cairo_device_observer_mask_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_observer_paint_elapsed <C-R>=<SID>Abbreviation("cairo_device_observer_paint_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_observer_stroke_elapsed <C-R>=<SID>Abbreviation("cairo_device_observer_stroke_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_reference <C-R>=<SID>Abbreviation("cairo_device_reference(cairo_device_t *device); /*cairo_device_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_release <C-R>=<SID>Abbreviation("cairo_device_release(cairo_device_t *device); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_status <C-R>=<SID>Abbreviation("cairo_device_status(cairo_device_t *device); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_to_user <C-R>=<SID>Abbreviation("cairo_device_to_user(cairo_t *cr,double *x,double *y); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_device_to_user_distance <C-R>=<SID>Abbreviation("cairo_device_to_user_distance(cairo_t *cr,double *dx,double *dy); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_fill <C-R>=<SID>Abbreviation("cairo_fill(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_fill_preserve <C-R>=<SID>Abbreviation("cairo_fill_preserve(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_face_destroy <C-R>=<SID>Abbreviation("cairo_font_face_destroy(cairo_font_face_t *font_face); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_face_get_reference_count <C-R>=<SID>Abbreviation("cairo_font_face_get_reference_count(cairo_font_face_t *font_face); /*unsigned int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_face_get_type <C-R>=<SID>Abbreviation("cairo_font_face_get_type(cairo_font_face_t *font_face); /*cairo_font_type_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_face_reference <C-R>=<SID>Abbreviation("cairo_font_face_reference(cairo_font_face_t *font_face); /*cairo_font_face_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_face_status <C-R>=<SID>Abbreviation("cairo_font_face_status(cairo_font_face_t *font_face); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_options_copy <C-R>=<SID>Abbreviation("cairo_font_options_copy(const cairo_font_options_t *original); /*cairo_font_options_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_options_create <C-R>=<SID>Abbreviation("cairo_font_options_create(); /*cairo_font_options_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_options_destroy <C-R>=<SID>Abbreviation("cairo_font_options_destroy(cairo_font_options_t *options); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_options_get_antialias <C-R>=<SID>Abbreviation("cairo_font_options_get_antialias(const cairo_font_options_t *options); /*cairo_antialias_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_options_get_hint_metrics <C-R>=<SID>Abbreviation("cairo_font_options_get_hint_metrics(const cairo_font_options_t *options); /*cairo_hint_metrics_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_options_get_hint_style <C-R>=<SID>Abbreviation("cairo_font_options_get_hint_style(const cairo_font_options_t *options); /*cairo_hint_style_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_options_get_subpixel_order <C-R>=<SID>Abbreviation("cairo_font_options_get_subpixel_order(const cairo_font_options_t *options); /*cairo_subpixel_order_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_options_hash <C-R>=<SID>Abbreviation("cairo_font_options_hash(const cairo_font_options_t *options); /*unsigned long */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_font_options_status <C-R>=<SID>Abbreviation("cairo_font_options_status(cairo_font_options_t *options); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_antialias <C-R>=<SID>Abbreviation("cairo_get_antialias(cairo_t *cr); /*cairo_antialias_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_current_point <C-R>=<SID>Abbreviation("cairo_get_current_point(cairo_t *cr,double *x,double *y); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_dash <C-R>=<SID>Abbreviation("cairo_get_dash(cairo_t *cr,double *dashes,double *offset); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_dash_count <C-R>=<SID>Abbreviation("cairo_get_dash_count(cairo_t *cr); /*int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_fill_rule <C-R>=<SID>Abbreviation("cairo_get_fill_rule(cairo_t *cr); /*cairo_fill_rule_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_font_face <C-R>=<SID>Abbreviation("cairo_get_font_face(cairo_t *cr); /*cairo_font_face_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_group_target <C-R>=<SID>Abbreviation("cairo_get_group_target(cairo_t *cr); /*cairo_surface_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_line_cap <C-R>=<SID>Abbreviation("cairo_get_line_cap(cairo_t *cr); /*cairo_line_cap_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_line_join <C-R>=<SID>Abbreviation("cairo_get_line_join(cairo_t *cr); /*cairo_line_join_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_line_width <C-R>=<SID>Abbreviation("cairo_get_line_width(cairo_t *cr); /*double */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_matrix <C-R>=<SID>Abbreviation("cairo_get_matrix(cairo_t *cr,cairo_matrix_t *matrix); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_miter_limit <C-R>=<SID>Abbreviation("cairo_get_miter_limit(cairo_t *cr); /*double */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_operator <C-R>=<SID>Abbreviation("cairo_get_operator(cairo_t *cr); /*cairo_operator_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_reference_count <C-R>=<SID>Abbreviation("cairo_get_reference_count(cairo_t *cr); /*unsigned int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_scaled_font <C-R>=<SID>Abbreviation("cairo_get_scaled_font(cairo_t *cr); /*cairo_scaled_font_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_source <C-R>=<SID>Abbreviation("cairo_get_source(cairo_t *cr); /*cairo_pattern_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_target <C-R>=<SID>Abbreviation("cairo_get_target(cairo_t *cr); /*cairo_surface_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_get_tolerance <C-R>=<SID>Abbreviation("cairo_get_tolerance(cairo_t *cr); /*double */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_glyph_allocate <C-R>=<SID>Abbreviation("cairo_glyph_allocate(int num_glyphs); /*cairo_glyph_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_glyph_free <C-R>=<SID>Abbreviation("cairo_glyph_free(cairo_glyph_t *glyphs); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_glyph_path <C-R>=<SID>Abbreviation("cairo_glyph_path(cairo_t *cr,const cairo_glyph_t *glyphs,int num_glyphs); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_has_current_point <C-R>=<SID>Abbreviation("cairo_has_current_point(cairo_t *cr); /*cairo_bool_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_identity_matrix <C-R>=<SID>Abbreviation("cairo_identity_matrix(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_image_surface_create_from_png <C-R>=<SID>Abbreviation("cairo_image_surface_create_from_png(const char *filename); /*cairo_surface_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_image_surface_get_data <C-R>=<SID>Abbreviation("cairo_image_surface_get_data(cairo_surface_t *surface); /*unsigned char * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_image_surface_get_format <C-R>=<SID>Abbreviation("cairo_image_surface_get_format(cairo_surface_t *surface); /*cairo_format_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_image_surface_get_height <C-R>=<SID>Abbreviation("cairo_image_surface_get_height(cairo_surface_t *surface); /*int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_image_surface_get_stride <C-R>=<SID>Abbreviation("cairo_image_surface_get_stride(cairo_surface_t *surface); /*int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_image_surface_get_width <C-R>=<SID>Abbreviation("cairo_image_surface_get_width(cairo_surface_t *surface); /*int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_in_clip <C-R>=<SID>Abbreviation("cairo_in_clip(cairo_t *cr,double x,double y); /*cairo_bool_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_in_fill <C-R>=<SID>Abbreviation("cairo_in_fill(cairo_t *cr,double x,double y); /*cairo_bool_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_in_stroke <C-R>=<SID>Abbreviation("cairo_in_stroke(cairo_t *cr,double x,double y); /*cairo_bool_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_line_to <C-R>=<SID>Abbreviation("cairo_line_to(cairo_t *cr,double x,double y); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_matrix_init_identity <C-R>=<SID>Abbreviation("cairo_matrix_init_identity(cairo_matrix_t *matrix); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_matrix_invert <C-R>=<SID>Abbreviation("cairo_matrix_invert(cairo_matrix_t *matrix); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_matrix_rotate <C-R>=<SID>Abbreviation("cairo_matrix_rotate(cairo_matrix_t *matrix,double radians); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_matrix_scale <C-R>=<SID>Abbreviation("cairo_matrix_scale(cairo_matrix_t *matrix,double sx,double sy); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_matrix_translate <C-R>=<SID>Abbreviation("cairo_matrix_translate(cairo_matrix_t *matrix,double tx,double ty); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_mesh_pattern_begin_patch <C-R>=<SID>Abbreviation("cairo_mesh_pattern_begin_patch(cairo_pattern_t *pattern); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_mesh_pattern_end_patch <C-R>=<SID>Abbreviation("cairo_mesh_pattern_end_patch(cairo_pattern_t *pattern); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_move_to <C-R>=<SID>Abbreviation("cairo_move_to(cairo_t *cr,double x,double y); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_new_path <C-R>=<SID>Abbreviation("cairo_new_path(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_new_sub_path <C-R>=<SID>Abbreviation("cairo_new_sub_path(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_paint <C-R>=<SID>Abbreviation("cairo_paint(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_path_destroy <C-R>=<SID>Abbreviation("cairo_path_destroy(cairo_path_t *path); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_create_for_surface <C-R>=<SID>Abbreviation("cairo_pattern_create_for_surface(cairo_surface_t *surface); /*cairo_pattern_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_create_mesh <C-R>=<SID>Abbreviation("cairo_pattern_create_mesh(); /*cairo_pattern_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_create_rgb <C-R>=<SID>Abbreviation("cairo_pattern_create_rgb(double red,double green,double blue); /*cairo_pattern_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_destroy <C-R>=<SID>Abbreviation("cairo_pattern_destroy(cairo_pattern_t *pattern); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_get_extend <C-R>=<SID>Abbreviation("cairo_pattern_get_extend(cairo_pattern_t *pattern); /*cairo_extend_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_get_filter <C-R>=<SID>Abbreviation("cairo_pattern_get_filter(cairo_pattern_t *pattern); /*cairo_filter_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_get_reference_count <C-R>=<SID>Abbreviation("cairo_pattern_get_reference_count(cairo_pattern_t *pattern); /*unsigned int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_get_type <C-R>=<SID>Abbreviation("cairo_pattern_get_type(cairo_pattern_t *pattern); /*cairo_pattern_type_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_reference <C-R>=<SID>Abbreviation("cairo_pattern_reference(cairo_pattern_t *pattern); /*cairo_pattern_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_set_extend <C-R>=<SID>Abbreviation("cairo_pattern_set_extend(cairo_pattern_t *pattern,cairo_extend_t extend); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_set_filter <C-R>=<SID>Abbreviation("cairo_pattern_set_filter(cairo_pattern_t *pattern,cairo_filter_t filter); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pattern_status <C-R>=<SID>Abbreviation("cairo_pattern_status(cairo_pattern_t *pattern); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pop_group <C-R>=<SID>Abbreviation("cairo_pop_group(cairo_t *cr); /*cairo_pattern_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_pop_group_to_source <C-R>=<SID>Abbreviation("cairo_pop_group_to_source(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_push_group <C-R>=<SID>Abbreviation("cairo_push_group(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_push_group_with_content <C-R>=<SID>Abbreviation("cairo_push_group_with_content(cairo_t *cr,cairo_content_t content); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_raster_source_pattern_get_callback_data <C-R>=<SID>Abbreviation("cairo_raster_source_pattern_get_callback_data(cairo_pattern_t *pattern); /*void * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_raster_source_pattern_get_copy <C-R>=<SID>Abbreviation("cairo_raster_source_pattern_get_copy(cairo_pattern_t *pattern); /*cairo_raster_source_copy_func_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_raster_source_pattern_get_finish <C-R>=<SID>Abbreviation("cairo_raster_source_pattern_get_finish(cairo_pattern_t *pattern); /*cairo_raster_source_finish_func_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_raster_source_pattern_get_snapshot <C-R>=<SID>Abbreviation("cairo_raster_source_pattern_get_snapshot(cairo_pattern_t *pattern); /*cairo_raster_source_snapshot_func_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_rectangle_list_destroy <C-R>=<SID>Abbreviation("cairo_rectangle_list_destroy(cairo_rectangle_list_t *rectangle_list); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_reference <C-R>=<SID>Abbreviation("cairo_reference(cairo_t *cr); /*cairo_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_contains_point <C-R>=<SID>Abbreviation("cairo_region_contains_point(const cairo_region_t *region,int x,int y); /*cairo_bool_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_copy <C-R>=<SID>Abbreviation("cairo_region_copy(const cairo_region_t *original); /*cairo_region_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_create <C-R>=<SID>Abbreviation("cairo_region_create(); /*cairo_region_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_create_rectangle <C-R>=<SID>Abbreviation("cairo_region_create_rectangle(const cairo_rectangle_int_t *rectangle); /*cairo_region_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_destroy <C-R>=<SID>Abbreviation("cairo_region_destroy(cairo_region_t *region); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_equal <C-R>=<SID>Abbreviation("cairo_region_equal(const cairo_region_t *a,const cairo_region_t *b); /*cairo_bool_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_intersect <C-R>=<SID>Abbreviation("cairo_region_intersect(cairo_region_t *dst,const cairo_region_t *other); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_is_empty <C-R>=<SID>Abbreviation("cairo_region_is_empty(const cairo_region_t *region); /*cairo_bool_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_num_rectangles <C-R>=<SID>Abbreviation("cairo_region_num_rectangles(const cairo_region_t *region); /*int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_reference <C-R>=<SID>Abbreviation("cairo_region_reference(cairo_region_t *region); /*cairo_region_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_status <C-R>=<SID>Abbreviation("cairo_region_status(const cairo_region_t *region); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_subtract <C-R>=<SID>Abbreviation("cairo_region_subtract(cairo_region_t *dst,const cairo_region_t *other); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_translate <C-R>=<SID>Abbreviation("cairo_region_translate(cairo_region_t *region,int dx,int dy); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_union <C-R>=<SID>Abbreviation("cairo_region_union(cairo_region_t *dst,const cairo_region_t *other); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_region_xor <C-R>=<SID>Abbreviation("cairo_region_xor(cairo_region_t *dst,const cairo_region_t *other); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_rel_line_to <C-R>=<SID>Abbreviation("cairo_rel_line_to(cairo_t *cr,double dx,double dy); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_rel_move_to <C-R>=<SID>Abbreviation("cairo_rel_move_to(cairo_t *cr,double dx,double dy); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_reset_clip <C-R>=<SID>Abbreviation("cairo_reset_clip(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_restore <C-R>=<SID>Abbreviation("cairo_restore(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_rotate <C-R>=<SID>Abbreviation("cairo_rotate(cairo_t *cr,double angle); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_save <C-R>=<SID>Abbreviation("cairo_save(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_scale <C-R>=<SID>Abbreviation("cairo_scale(cairo_t *cr,double sx,double sy); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_scaled_font_destroy <C-R>=<SID>Abbreviation("cairo_scaled_font_destroy(cairo_scaled_font_t *scaled_font); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_scaled_font_get_font_face <C-R>=<SID>Abbreviation("cairo_scaled_font_get_font_face(cairo_scaled_font_t *scaled_font); /*cairo_font_face_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_scaled_font_get_reference_count <C-R>=<SID>Abbreviation("cairo_scaled_font_get_reference_count(cairo_scaled_font_t *scaled_font); /*unsigned int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_scaled_font_get_type <C-R>=<SID>Abbreviation("cairo_scaled_font_get_type(cairo_scaled_font_t *scaled_font); /*cairo_font_type_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_scaled_font_reference <C-R>=<SID>Abbreviation("cairo_scaled_font_reference(cairo_scaled_font_t *scaled_font); /*cairo_scaled_font_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_scaled_font_status <C-R>=<SID>Abbreviation("cairo_scaled_font_status(cairo_scaled_font_t *scaled_font); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_antialias <C-R>=<SID>Abbreviation("cairo_set_antialias(cairo_t *cr,cairo_antialias_t antialias); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_fill_rule <C-R>=<SID>Abbreviation("cairo_set_fill_rule(cairo_t *cr,cairo_fill_rule_t fill_rule); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_font_face <C-R>=<SID>Abbreviation("cairo_set_font_face(cairo_t *cr,cairo_font_face_t *font_face); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_font_size <C-R>=<SID>Abbreviation("cairo_set_font_size(cairo_t *cr,double size); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_line_cap <C-R>=<SID>Abbreviation("cairo_set_line_cap(cairo_t *cr,cairo_line_cap_t line_cap); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_line_join <C-R>=<SID>Abbreviation("cairo_set_line_join(cairo_t *cr,cairo_line_join_t line_join); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_line_width <C-R>=<SID>Abbreviation("cairo_set_line_width(cairo_t *cr,double width); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_miter_limit <C-R>=<SID>Abbreviation("cairo_set_miter_limit(cairo_t *cr,double limit); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_operator <C-R>=<SID>Abbreviation("cairo_set_operator(cairo_t *cr,cairo_operator_t op); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_source <C-R>=<SID>Abbreviation("cairo_set_source(cairo_t *cr,cairo_pattern_t *source); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_source_rgb <C-R>=<SID>Abbreviation("cairo_set_source_rgb(cairo_t *cr,double red,double green,double blue); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_set_tolerance <C-R>=<SID>Abbreviation("cairo_set_tolerance(cairo_t *cr,double tolerance); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_show_glyphs <C-R>=<SID>Abbreviation("cairo_show_glyphs(cairo_t *cr,const cairo_glyph_t *glyphs,int num_glyphs); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_show_page <C-R>=<SID>Abbreviation("cairo_show_page(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_show_text <C-R>=<SID>Abbreviation("cairo_show_text(cairo_t *cr,const char *utf8); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_status <C-R>=<SID>Abbreviation("cairo_status(cairo_t *cr); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_status_to_string <C-R>=<SID>Abbreviation("cairo_status_to_string(cairo_status_t status); /*const char * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_stroke <C-R>=<SID>Abbreviation("cairo_stroke(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_stroke_preserve <C-R>=<SID>Abbreviation("cairo_stroke_preserve(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_stroke_to_path <C-R>=<SID>Abbreviation("cairo_stroke_to_path(cairo_t *cr); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_copy_page <C-R>=<SID>Abbreviation("cairo_surface_copy_page(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_destroy <C-R>=<SID>Abbreviation("cairo_surface_destroy(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_finish <C-R>=<SID>Abbreviation("cairo_surface_finish(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_flush <C-R>=<SID>Abbreviation("cairo_surface_flush(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_get_content <C-R>=<SID>Abbreviation("cairo_surface_get_content(cairo_surface_t *surface); /*cairo_content_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_get_device <C-R>=<SID>Abbreviation("cairo_surface_get_device(cairo_surface_t *surface); /*cairo_device_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_get_reference_count <C-R>=<SID>Abbreviation("cairo_surface_get_reference_count(cairo_surface_t *surface); /*unsigned int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_get_type <C-R>=<SID>Abbreviation("cairo_surface_get_type(cairo_surface_t *surface); /*cairo_surface_type_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_has_show_text_glyphs <C-R>=<SID>Abbreviation("cairo_surface_has_show_text_glyphs(cairo_surface_t *surface); /*cairo_bool_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_mark_dirty <C-R>=<SID>Abbreviation("cairo_surface_mark_dirty(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_observer_elapsed <C-R>=<SID>Abbreviation("cairo_surface_observer_elapsed(cairo_surface_t *surface); /*double */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_reference <C-R>=<SID>Abbreviation("cairo_surface_reference(cairo_surface_t *surface); /*cairo_surface_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_show_page <C-R>=<SID>Abbreviation("cairo_surface_show_page(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_surface_status <C-R>=<SID>Abbreviation("cairo_surface_status(cairo_surface_t *surface); /*cairo_status_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_text_cluster_allocate <C-R>=<SID>Abbreviation("cairo_text_cluster_allocate(int num_clusters); /*cairo_text_cluster_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_text_cluster_free <C-R>=<SID>Abbreviation("cairo_text_cluster_free(cairo_text_cluster_t *clusters); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_text_path <C-R>=<SID>Abbreviation("cairo_text_path(cairo_t *cr,const char *utf8); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_toy_font_face_get_family <C-R>=<SID>Abbreviation("cairo_toy_font_face_get_family(cairo_font_face_t *font_face); /*const char * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_toy_font_face_get_slant <C-R>=<SID>Abbreviation("cairo_toy_font_face_get_slant(cairo_font_face_t *font_face); /*cairo_font_slant_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_toy_font_face_get_weight <C-R>=<SID>Abbreviation("cairo_toy_font_face_get_weight(cairo_font_face_t *font_face); /*cairo_font_weight_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_translate <C-R>=<SID>Abbreviation("cairo_translate(cairo_t *cr,double tx,double ty); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_user_font_face_create <C-R>=<SID>Abbreviation("cairo_user_font_face_create(); /*cairo_font_face_t * */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_user_font_face_get_init_func <C-R>=<SID>Abbreviation("cairo_user_font_face_get_init_func(cairo_font_face_t *font_face); /*cairo_user_scaled_font_init_func_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_user_font_face_get_render_glyph_func <C-R>=<SID>Abbreviation("cairo_user_font_face_get_render_glyph_func(cairo_font_face_t *font_face); /*cairo_user_scaled_font_render_glyph_func_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_user_font_face_get_text_to_glyphs_func <C-R>=<SID>Abbreviation("cairo_user_font_face_get_text_to_glyphs_func(cairo_font_face_t *font_face); /*cairo_user_scaled_font_text_to_glyphs_func_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_user_font_face_get_unicode_to_glyph_func <C-R>=<SID>Abbreviation("cairo_user_font_face_get_unicode_to_glyph_func(cairo_font_face_t *font_face); /*cairo_user_scaled_font_unicode_to_glyph_func_t */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_user_to_device <C-R>=<SID>Abbreviation("cairo_user_to_device(cairo_t *cr,double *x,double *y); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_user_to_device_distance <C-R>=<SID>Abbreviation("cairo_user_to_device_distance(cairo_t *cr,double *dx,double *dy); /*void */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_version <C-R>=<SID>Abbreviation("cairo_version(); /*int */<ESC>:normal0f(<CR>")<CR>
inoreabbrev <silent> <buffer> cairo_version_string <C-R>=<SID>Abbreviation("cairo_version_string(); /*const char* */<ESC>:normal0f(<CR>")<CR>

" cairo-xcb.h defs
inoreabbrev <silent> <buffer> cairo_xcb_device_debug_cap_xrender_version <C-R>=<SID>Abbreviation("cairo_xcb_device_debug_cap_xrender_version(cairo_device_t *device,int major_version,int minor_version); /*void */")<CR>
inoreabbrev <silent> <buffer> cairo_xcb_device_debug_cap_xshm_version <C-R>=<SID>Abbreviation("cairo_xcb_device_debug_cap_xshm_version(cairo_device_t *device,int major_version,int minor_version); /*void */")<CR>
inoreabbrev <silent> <buffer> cairo_xcb_device_debug_get_precision <C-R>=<SID>Abbreviation("cairo_xcb_device_debug_get_precision(cairo_device_t *device); /*int */")<CR>
inoreabbrev <silent> <buffer> cairo_xcb_device_debug_set_precision <C-R>=<SID>Abbreviation("cairo_xcb_device_debug_set_precision(cairo_device_t *device,int precision); /*void */")<CR>
inoreabbrev <silent> <buffer> cairo_xcb_device_get_connection <C-R>=<SID>Abbreviation("cairo_xcb_device_get_connection(cairo_device_t *device); /*xcb_connection_t * */")<CR>
inoreabbrev <silent> <buffer> cairo_xcb_surface_create <C-R>=<SID>Abbreviation("cairo_xcb_surface_create(xcb_connection_t *connection,xcb_drawable_t drawable,xcb_visualtype_t *visual,int width,int height); /*cairo_surface_t * */")<CR>
inoreabbrev <silent> <buffer> cairo_xcb_surface_create_for_bitmap <C-R>=<SID>Abbreviation("cairo_xcb_surface_create_for_bitmap(xcb_connection_t *connection,xcb_screen_t *screen,xcb_pixmap_t bitmap,int width,int height); /*cairo_surface_t * */")<CR>
inoreabbrev <silent> <buffer> cairo_xcb_surface_create_with_xrender_format <C-R>=<SID>Abbreviation("cairo_xcb_surface_create_with_xrender_format(xcb_connection_t *connection,xcb_screen_t *screen,xcb_drawable_t drawable,xcb_render_pictforminfo_t *format,int width,int height); /*cairo_surface_t *  */")<CR>
inoreabbrev <silent> <buffer> cairo_xcb_surface_set_drawable <C-R>=<SID>Abbreviation("cairo_xcb_surface_set_drawable(cairo_surface_t *surface,xcb_drawable_t drawable,int width,int height); /*void */")<CR>
inoreabbrev <silent> <buffer> cairo_xcb_surface_set_size <C-R>=<SID>Abbreviation("cairo_xcb_surface_set_size(cairo_surface_t *surface,int width,int height); /*void */")<CR>

" cairo-xlib.h defs
inoreabbrev <silent> <buffer> cairo_xlib_device_debug_cap_xrender_version <C-R>=<SID>Abbreviation("cairo_xlib_device_debug_cap_xrender_version(cairo_device_t *device,int major_version,int minor_version); /*void */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_device_debug_get_precision <C-R>=<SID>Abbreviation("cairo_xlib_device_debug_get_precision(cairo_device_t *device); /*int */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_device_debug_set_precision <C-R>=<SID>Abbreviation("cairo_xlib_device_debug_set_precision(cairo_device_t *device,int precision); /*void */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_create <C-R>=<SID>Abbreviation("cairo_xlib_surface_create(Display *dpy,Drawable drawable,Visual *visual,int width,int height); /*cairo_surface_t * */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_create_for_bitmap <C-R>=<SID>Abbreviation("cairo_xlib_surface_create_for_bitmap(Display *dpy,Pixmap bitmap,Screen *screen,int width,int height); /*cairo_surface_t * */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_get_depth <C-R>=<SID>Abbreviation("cairo_xlib_surface_get_depth(cairo_surface_t *surface); /*int */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_get_display <C-R>=<SID>Abbreviation("cairo_xlib_surface_get_display(cairo_surface_t *surface); /*Display * */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_get_drawable <C-R>=<SID>Abbreviation("cairo_xlib_surface_get_drawable(cairo_surface_t *surface); /*Drawable */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_get_height <C-R>=<SID>Abbreviation("cairo_xlib_surface_get_height(cairo_surface_t *surface); /*int */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_get_screen <C-R>=<SID>Abbreviation("cairo_xlib_surface_get_screen(cairo_surface_t *surface); /*Screen * */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_get_visual <C-R>=<SID>Abbreviation("cairo_xlib_surface_get_visual(cairo_surface_t *surface); /*Visual * */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_get_width <C-R>=<SID>Abbreviation("cairo_xlib_surface_get_width(cairo_surface_t *surface); /*int */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_set_drawable <C-R>=<SID>Abbreviation("cairo_xlib_surface_set_drawable(cairo_surface_t *surface,Drawable drawable,int width,int height); /*void */")<CR>
inoreabbrev <silent> <buffer> cairo_xlib_surface_set_size <C-R>=<SID>Abbreviation("cairo_xlib_surface_set_size(cairo_surface_t *surface,int width,int height); /*void */")<CR>

" sdl sdl2 SDL SDL2 sdl.h SDL.h defs
inoreabbrev <silent> <buffer> IMG_Init <C-R>=<SID>Abbreviation("IMG_Init(int flags); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_Linked_Version <C-R>=<SID>Abbreviation("IMG_Linked_Version(); /* const SDL_version *  */")<CR>
inoreabbrev <silent> <buffer> IMG_Load <C-R>=<SID>Abbreviation("IMG_Load(const char *file); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadBMP_RW <C-R>=<SID>Abbreviation("IMG_LoadBMP_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadCUR_RW <C-R>=<SID>Abbreviation("IMG_LoadCUR_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadGIF_RW <C-R>=<SID>Abbreviation("IMG_LoadGIF_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadICO_RW <C-R>=<SID>Abbreviation("IMG_LoadICO_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadJPG_RW <C-R>=<SID>Abbreviation("IMG_LoadJPG_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadLBM_RW <C-R>=<SID>Abbreviation("IMG_LoadLBM_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadPCX_RW <C-R>=<SID>Abbreviation("IMG_LoadPCX_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadPNG_RW <C-R>=<SID>Abbreviation("IMG_LoadPNG_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadPNM_RW <C-R>=<SID>Abbreviation("IMG_LoadPNM_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadSVG_RW <C-R>=<SID>Abbreviation("IMG_LoadSVG_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadTGA_RW <C-R>=<SID>Abbreviation("IMG_LoadTGA_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadTIF_RW <C-R>=<SID>Abbreviation("IMG_LoadTIF_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadTexture <C-R>=<SID>Abbreviation("IMG_LoadTexture(SDL_Renderer *renderer,const char *file); /* SDL_Texture *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadTextureTyped_RW <C-R>=<SID>Abbreviation("IMG_LoadTextureTyped_RW(SDL_Renderer *renderer,SDL_RWops *src,int freesrc,const char *type); /* SDL_Texture *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadTexture_RW <C-R>=<SID>Abbreviation("IMG_LoadTexture_RW(SDL_Renderer *renderer,SDL_RWops *src,int freesrc); /* SDL_Texture *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadTyped_RW <C-R>=<SID>Abbreviation("IMG_LoadTyped_RW(SDL_RWops *src,int freesrc,const char *type); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadWEBP_RW <C-R>=<SID>Abbreviation("IMG_LoadWEBP_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadXCF_RW <C-R>=<SID>Abbreviation("IMG_LoadXCF_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadXPM_RW <C-R>=<SID>Abbreviation("IMG_LoadXPM_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_LoadXV_RW <C-R>=<SID>Abbreviation("IMG_LoadXV_RW(SDL_RWops *src); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_Load_RW <C-R>=<SID>Abbreviation("IMG_Load_RW(SDL_RWops *src,int freesrc); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_Quit <C-R>=<SID>Abbreviation("IMG_Quit(); /* void  */")<CR>
inoreabbrev <silent> <buffer> IMG_ReadXPMFromArray <C-R>=<SID>Abbreviation("IMG_ReadXPMFromArray(char **xpm); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> IMG_SaveJPG <C-R>=<SID>Abbreviation("IMG_SaveJPG(SDL_Surface *surface,const char *file,int quality); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_SaveJPG_RW <C-R>=<SID>Abbreviation("IMG_SaveJPG_RW(SDL_Surface *surface,SDL_RWops *dst,int freedst,int quality); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_SavePNG <C-R>=<SID>Abbreviation("IMG_SavePNG(SDL_Surface *surface,const char *file); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_SavePNG_RW <C-R>=<SID>Abbreviation("IMG_SavePNG_RW(SDL_Surface *surface,SDL_RWops *dst,int freedst); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isBMP <C-R>=<SID>Abbreviation("IMG_isBMP(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isCUR <C-R>=<SID>Abbreviation("IMG_isCUR(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isGIF <C-R>=<SID>Abbreviation("IMG_isGIF(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isICO <C-R>=<SID>Abbreviation("IMG_isICO(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isJPG <C-R>=<SID>Abbreviation("IMG_isJPG(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isLBM <C-R>=<SID>Abbreviation("IMG_isLBM(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isPCX <C-R>=<SID>Abbreviation("IMG_isPCX(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isPNG <C-R>=<SID>Abbreviation("IMG_isPNG(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isPNM <C-R>=<SID>Abbreviation("IMG_isPNM(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isSVG <C-R>=<SID>Abbreviation("IMG_isSVG(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isTIF <C-R>=<SID>Abbreviation("IMG_isTIF(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isWEBP <C-R>=<SID>Abbreviation("IMG_isWEBP(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isXCF <C-R>=<SID>Abbreviation("IMG_isXCF(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isXPM <C-R>=<SID>Abbreviation("IMG_isXPM(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> IMG_isXV <C-R>=<SID>Abbreviation("IMG_isXV(SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_AllocateChannels <C-R>=<SID>Abbreviation("Mix_AllocateChannels(int numchans); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_CloseAudio <C-R>=<SID>Abbreviation("Mix_CloseAudio(); /* void  */")<CR>
inoreabbrev <silent> <buffer> Mix_ExpireChannel <C-R>=<SID>Abbreviation("Mix_ExpireChannel(int channel,int ticks); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_FadeInChannelTimed <C-R>=<SID>Abbreviation("Mix_FadeInChannelTimed(int channel,Mix_Chunk *chunk,int loops,int ms,int ticks); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_FadeInMusic <C-R>=<SID>Abbreviation("Mix_FadeInMusic(Mix_Music *music,int loops,int ms); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_FadeInMusicPos <C-R>=<SID>Abbreviation("Mix_FadeInMusicPos(Mix_Music *music,int loops,int ms,double position); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_FadeOutChannel <C-R>=<SID>Abbreviation("Mix_FadeOutChannel(int which,int ms); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_FadeOutGroup <C-R>=<SID>Abbreviation("Mix_FadeOutGroup(int tag,int ms); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_FadeOutMusic <C-R>=<SID>Abbreviation("Mix_FadeOutMusic(int ms); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_FadingChannel <C-R>=<SID>Abbreviation("Mix_FadingChannel(int which); /* Mix_Fading  */")<CR>
inoreabbrev <silent> <buffer> Mix_FadingMusic <C-R>=<SID>Abbreviation("Mix_FadingMusic(); /* Mix_Fading  */")<CR>
inoreabbrev <silent> <buffer> Mix_FreeChunk <C-R>=<SID>Abbreviation("Mix_FreeChunk(Mix_Chunk *chunk); /* void  */")<CR>
inoreabbrev <silent> <buffer> Mix_FreeMusic <C-R>=<SID>Abbreviation("Mix_FreeMusic(Mix_Music *music); /* void  */")<CR>
inoreabbrev <silent> <buffer> Mix_GetChunk <C-R>=<SID>Abbreviation("Mix_GetChunk(int channel); /* Mix_Chunk *  */")<CR>
inoreabbrev <silent> <buffer> Mix_GetChunkDecoder <C-R>=<SID>Abbreviation("Mix_GetChunkDecoder(int index); /* const char *  */")<CR>
inoreabbrev <silent> <buffer> Mix_GetMusicDecoder <C-R>=<SID>Abbreviation("Mix_GetMusicDecoder(int index); /* const char *  */")<CR>
inoreabbrev <silent> <buffer> Mix_GetMusicHookData <C-R>=<SID>Abbreviation("Mix_GetMusicHookData(); /* void *  */")<CR>
inoreabbrev <silent> <buffer> Mix_GetMusicType <C-R>=<SID>Abbreviation("Mix_GetMusicType(const Mix_Music *music); /* Mix_MusicType  */")<CR>
inoreabbrev <silent> <buffer> Mix_GetNumChunkDecoders <C-R>=<SID>Abbreviation("Mix_GetNumChunkDecoders(); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_GetNumMusicDecoders <C-R>=<SID>Abbreviation("Mix_GetNumMusicDecoders(); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_GetSoundFonts <C-R>=<SID>Abbreviation("Mix_GetSoundFonts(); /* const char*  */")<CR>
inoreabbrev <silent> <buffer> Mix_GetSynchroValue <C-R>=<SID>Abbreviation("Mix_GetSynchroValue(); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_GroupAvailable <C-R>=<SID>Abbreviation("Mix_GroupAvailable(int tag); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_GroupChannel <C-R>=<SID>Abbreviation("Mix_GroupChannel(int which,int tag); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_GroupChannels <C-R>=<SID>Abbreviation("Mix_GroupChannels(int from,int to,int tag); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_GroupCount <C-R>=<SID>Abbreviation("Mix_GroupCount(int tag); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_GroupNewer <C-R>=<SID>Abbreviation("Mix_GroupNewer(int tag); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_GroupOldest <C-R>=<SID>Abbreviation("Mix_GroupOldest(int tag); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_HaltChannel <C-R>=<SID>Abbreviation("Mix_HaltChannel(int channel); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_HaltGroup <C-R>=<SID>Abbreviation("Mix_HaltGroup(int tag); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_HaltMusic <C-R>=<SID>Abbreviation("Mix_HaltMusic(); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_HasChunkDecoder <C-R>=<SID>Abbreviation("Mix_HasChunkDecoder(const char *name); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> Mix_HasMusicDecoder <C-R>=<SID>Abbreviation("Mix_HasMusicDecoder(const char *name); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> Mix_Init <C-R>=<SID>Abbreviation("Mix_Init(int flags); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_Linked_Version <C-R>=<SID>Abbreviation("Mix_Linked_Version(); /* const SDL_version *  */")<CR>
inoreabbrev <silent> <buffer> Mix_LoadMUS <C-R>=<SID>Abbreviation("Mix_LoadMUS(const char *file); /* Mix_Music *  */")<CR>
inoreabbrev <silent> <buffer> Mix_LoadMUSType_RW <C-R>=<SID>Abbreviation("Mix_LoadMUSType_RW(SDL_RWops *src,Mix_MusicType type,int freesrc); /* Mix_Music *  */")<CR>
inoreabbrev <silent> <buffer> Mix_LoadMUS_RW <C-R>=<SID>Abbreviation("Mix_LoadMUS_RW(SDL_RWops *src,int freesrc); /* Mix_Music *  */")<CR>
inoreabbrev <silent> <buffer> Mix_LoadWAV_RW <C-R>=<SID>Abbreviation("Mix_LoadWAV_RW(SDL_RWops *src,int freesrc); /* Mix_Chunk *  */")<CR>
inoreabbrev <silent> <buffer> Mix_OpenAudio <C-R>=<SID>Abbreviation("Mix_OpenAudio(int frequency,Uint16 format,int channels,int chunksize); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_OpenAudioDevice <C-R>=<SID>Abbreviation("Mix_OpenAudioDevice(int frequency,Uint16 format,int channels,int chunksize,const char* device,int allowed_changes); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_Pause <C-R>=<SID>Abbreviation("Mix_Pause(int channel); /* void  */")<CR>
inoreabbrev <silent> <buffer> Mix_PauseMusic <C-R>=<SID>Abbreviation("Mix_PauseMusic(); /* void  */")<CR>
inoreabbrev <silent> <buffer> Mix_Paused <C-R>=<SID>Abbreviation("Mix_Paused(int channel); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_PausedMusic <C-R>=<SID>Abbreviation("Mix_PausedMusic(); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_PlayChannelTimed <C-R>=<SID>Abbreviation("Mix_PlayChannelTimed(int channel,Mix_Chunk *chunk,int loops,int ticks); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_PlayMusic <C-R>=<SID>Abbreviation("Mix_PlayMusic(Mix_Music *music,int loops); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_Playing <C-R>=<SID>Abbreviation("Mix_Playing(int channel); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_PlayingMusic <C-R>=<SID>Abbreviation("Mix_PlayingMusic(); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_QuerySpec <C-R>=<SID>Abbreviation("Mix_QuerySpec(int *frequency,Uint16 *format,int *channels); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_QuickLoad_RAW <C-R>=<SID>Abbreviation("Mix_QuickLoad_RAW(Uint8 *mem,Uint32 len); /* Mix_Chunk *  */")<CR>
inoreabbrev <silent> <buffer> Mix_QuickLoad_WAV <C-R>=<SID>Abbreviation("Mix_QuickLoad_WAV(Uint8 *mem); /* Mix_Chunk *  */")<CR>
inoreabbrev <silent> <buffer> Mix_Quit <C-R>=<SID>Abbreviation("Mix_Quit(); /* void  */")<CR>
inoreabbrev <silent> <buffer> Mix_RegisterEffect <C-R>=<SID>Abbreviation("Mix_RegisterEffect(int chan,Mix_EffectFunc_t f,Mix_EffectDone_t d,void *arg); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_ReserveChannels <C-R>=<SID>Abbreviation("Mix_ReserveChannels(int num); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_Resume <C-R>=<SID>Abbreviation("Mix_Resume(int channel); /* void  */")<CR>
inoreabbrev <silent> <buffer> Mix_ResumeMusic <C-R>=<SID>Abbreviation("Mix_ResumeMusic(); /* void  */")<CR>
inoreabbrev <silent> <buffer> Mix_RewindMusic <C-R>=<SID>Abbreviation("Mix_RewindMusic(); /* void  */")<CR>
inoreabbrev <silent> <buffer> Mix_SetDistance <C-R>=<SID>Abbreviation("Mix_SetDistance(int channel,Uint8 distance); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_SetMusicCMD <C-R>=<SID>Abbreviation("Mix_SetMusicCMD(const char *command); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_SetMusicPosition <C-R>=<SID>Abbreviation("Mix_SetMusicPosition(double position); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_SetPanning <C-R>=<SID>Abbreviation("Mix_SetPanning(int channel,Uint8 left,Uint8 right); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_SetPosition <C-R>=<SID>Abbreviation("Mix_SetPosition(int channel,Sint16 angle,Uint8 distance); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_SetReverseStereo <C-R>=<SID>Abbreviation("Mix_SetReverseStereo(int channel,int flip); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_SetSoundFonts <C-R>=<SID>Abbreviation("Mix_SetSoundFonts(const char *paths); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_SetSynchroValue <C-R>=<SID>Abbreviation("Mix_SetSynchroValue(int value); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_UnregisterAllEffects <C-R>=<SID>Abbreviation("Mix_UnregisterAllEffects(int channel); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_UnregisterEffect <C-R>=<SID>Abbreviation("Mix_UnregisterEffect(int channel,Mix_EffectFunc_t f); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_Volume <C-R>=<SID>Abbreviation("Mix_Volume(int channel,int volume); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_VolumeChunk <C-R>=<SID>Abbreviation("Mix_VolumeChunk(Mix_Chunk *chunk,int volume); /* int  */")<CR>
inoreabbrev <silent> <buffer> Mix_VolumeMusic <C-R>=<SID>Abbreviation("Mix_VolumeMusic(int volume); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_AddSocket <C-R>=<SID>Abbreviation("SDLNet_AddSocket(SDLNet_SocketSet set,SDLNet_GenericSocket sock); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_AllocPacket <C-R>=<SID>Abbreviation("SDLNet_AllocPacket(int size); /* UDPpacket *  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_AllocPacketV <C-R>=<SID>Abbreviation("SDLNet_AllocPacketV(int howmany,int size); /* UDPpacket **  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_AllocSocketSet <C-R>=<SID>Abbreviation("SDLNet_AllocSocketSet(int maxsockets); /* SDLNet_SocketSet  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_CheckSockets <C-R>=<SID>Abbreviation("SDLNet_CheckSockets(SDLNet_SocketSet set,Uint32 timeout); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_DelSocket <C-R>=<SID>Abbreviation("SDLNet_DelSocket(SDLNet_SocketSet set,SDLNet_GenericSocket sock); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_FreePacket <C-R>=<SID>Abbreviation("SDLNet_FreePacket(UDPpacket *packet); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_FreePacketV <C-R>=<SID>Abbreviation("SDLNet_FreePacketV(UDPpacket **packetV); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_FreeSocketSet <C-R>=<SID>Abbreviation("SDLNet_FreeSocketSet(SDLNet_SocketSet set); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_GetError <C-R>=<SID>Abbreviation("SDLNet_GetError(); /* const char *  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_GetLocalAddresses <C-R>=<SID>Abbreviation("SDLNet_GetLocalAddresses(IPaddress *addresses,int maxcount); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_Init <C-R>=<SID>Abbreviation("SDLNet_Init(); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_Linked_Version <C-R>=<SID>Abbreviation("SDLNet_Linked_Version(); /* const SDLNet_version *  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_Quit <C-R>=<SID>Abbreviation("SDLNet_Quit(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_ResizePacket <C-R>=<SID>Abbreviation("SDLNet_ResizePacket(UDPpacket *packet,int newsize); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_ResolveHost <C-R>=<SID>Abbreviation("SDLNet_ResolveHost(IPaddress *address,const char *host,Uint16 port); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_ResolveIP <C-R>=<SID>Abbreviation("SDLNet_ResolveIP(const IPaddress *ip); /* const char *  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_SetError <C-R>=<SID>Abbreviation("SDLNet_SetError(const char *fmt,...); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_TCP_Accept <C-R>=<SID>Abbreviation("SDLNet_TCP_Accept(TCPsocket server); /* TCPsocket  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_TCP_Close <C-R>=<SID>Abbreviation("SDLNet_TCP_Close(TCPsocket sock); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_TCP_GetPeerAddress <C-R>=<SID>Abbreviation("SDLNet_TCP_GetPeerAddress(TCPsocket sock); /* IPaddress *  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_TCP_Open <C-R>=<SID>Abbreviation("SDLNet_TCP_Open(IPaddress *ip); /* TCPsocket  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_TCP_Recv <C-R>=<SID>Abbreviation("SDLNet_TCP_Recv(TCPsocket sock,void *data,int maxlen); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_TCP_Send <C-R>=<SID>Abbreviation("SDLNet_TCP_Send(TCPsocket sock,const void *data,int len); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_UDP_Bind <C-R>=<SID>Abbreviation("SDLNet_UDP_Bind(UDPsocket sock,int channel,const IPaddress *address); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_UDP_Close <C-R>=<SID>Abbreviation("SDLNet_UDP_Close(UDPsocket sock); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_UDP_GetPeerAddress <C-R>=<SID>Abbreviation("SDLNet_UDP_GetPeerAddress(UDPsocket sock,int channel); /* IPaddress *  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_UDP_Open <C-R>=<SID>Abbreviation("SDLNet_UDP_Open(Uint16 port); /* UDPsocket  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_UDP_Recv <C-R>=<SID>Abbreviation("SDLNet_UDP_Recv(UDPsocket sock,UDPpacket *packet); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_UDP_RecvV <C-R>=<SID>Abbreviation("SDLNet_UDP_RecvV(UDPsocket sock,UDPpacket **packets); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_UDP_Send <C-R>=<SID>Abbreviation("SDLNet_UDP_Send(UDPsocket sock,int channel,UDPpacket *packet); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_UDP_SendV <C-R>=<SID>Abbreviation("SDLNet_UDP_SendV(UDPsocket sock,UDPpacket **packets,int npackets); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_UDP_SetPacketLoss <C-R>=<SID>Abbreviation("SDLNet_UDP_SetPacketLoss(UDPsocket sock,int percent); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDLNet_UDP_Unbind <C-R>=<SID>Abbreviation("SDLNet_UDP_Unbind(UDPsocket sock,int channel); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_AddEventWatch <C-R>=<SID>Abbreviation("SDL_AddEventWatch(SDL_EventFilter filter,void *userdata); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_AddHintCallback <C-R>=<SID>Abbreviation("SDL_AddHintCallback(const char *name,SDL_HintCallback callback,void *userdata); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_AddTimer <C-R>=<SID>Abbreviation("SDL_AddTimer(Uint32 interval,SDL_TimerCallback callback,void *param); /* SDL_TimerID  */")<CR>
inoreabbrev <silent> <buffer> SDL_AllocFormat <C-R>=<SID>Abbreviation("SDL_AllocFormat(Uint32 pixel_format); /* SDL_PixelFormat *  */")<CR>
inoreabbrev <silent> <buffer> SDL_AllocPalette <C-R>=<SID>Abbreviation("SDL_AllocPalette(int ncolors); /* SDL_Palette * */")<CR>
inoreabbrev <silent> <buffer> SDL_AllocRW <C-R>=<SID>Abbreviation("SDL_AllocRW(); /* SDL_RWops * */")<CR>
inoreabbrev <silent> <buffer> SDL_AndroidBackButton <C-R>=<SID>Abbreviation("SDL_AndroidBackButton(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_AndroidGetActivity <C-R>=<SID>Abbreviation("SDL_AndroidGetActivity(); /* void *  */")<CR>
inoreabbrev <silent> <buffer> SDL_AndroidGetExternalStoragePath <C-R>=<SID>Abbreviation("SDL_AndroidGetExternalStoragePath(); /* const char *  */")<CR>
inoreabbrev <silent> <buffer> SDL_AndroidGetExternalStorageState <C-R>=<SID>Abbreviation("SDL_AndroidGetExternalStorageState(); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_AndroidGetInternalStoragePath <C-R>=<SID>Abbreviation("SDL_AndroidGetInternalStoragePath(); /* const char *  */")<CR>
inoreabbrev <silent> <buffer> SDL_AndroidGetJNIEnv <C-R>=<SID>Abbreviation("SDL_AndroidGetJNIEnv(); /* void *  */")<CR>
inoreabbrev <silent> <buffer> SDL_AtomicAdd <C-R>=<SID>Abbreviation("SDL_AtomicAdd(SDL_atomic_t *a,int v); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_AtomicCAS <C-R>=<SID>Abbreviation("SDL_AtomicCAS(SDL_atomic_t *a,int oldval,int newval); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_AtomicCASPtr <C-R>=<SID>Abbreviation("SDL_AtomicCASPtr(void **a,void *oldval,void *newval); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_AtomicGet <C-R>=<SID>Abbreviation("SDL_AtomicGet(SDL_atomic_t *a); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_AtomicGetPtr <C-R>=<SID>Abbreviation("SDL_AtomicGetPtr(void **a); /* void*  */")<CR>
inoreabbrev <silent> <buffer> SDL_AtomicLock <C-R>=<SID>Abbreviation("SDL_AtomicLock(SDL_SpinLock *lock); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_AtomicSet <C-R>=<SID>Abbreviation("SDL_AtomicSet(SDL_atomic_t *a,int v); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_AtomicSetPtr <C-R>=<SID>Abbreviation("SDL_AtomicSetPtr(void **a,void* v); /* void*  */")<CR>
inoreabbrev <silent> <buffer> SDL_AtomicTryLock <C-R>=<SID>Abbreviation("SDL_AtomicTryLock(SDL_SpinLock *lock); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_AtomicUnlock <C-R>=<SID>Abbreviation("SDL_AtomicUnlock(SDL_SpinLock *lock); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_AudioInit <C-R>=<SID>Abbreviation("SDL_AudioInit(const char *driver_name); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_AudioQuit <C-R>=<SID>Abbreviation("SDL_AudioQuit(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_AudioStreamAvailable <C-R>=<SID>Abbreviation("SDL_AudioStreamAvailable(SDL_AudioStream *stream); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_AudioStreamClear <C-R>=<SID>Abbreviation("SDL_AudioStreamClear(SDL_AudioStream *stream); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_AudioStreamFlush <C-R>=<SID>Abbreviation("SDL_AudioStreamFlush(SDL_AudioStream *stream); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_AudioStreamGet <C-R>=<SID>Abbreviation("SDL_AudioStreamGet(SDL_AudioStream *stream,void *buf,int len); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_AudioStreamPut <C-R>=<SID>Abbreviation("SDL_AudioStreamPut(SDL_AudioStream *stream,const void *buf,int len); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_BuildAudioCVT <C-R>=<SID>Abbreviation("SDL_BuildAudioCVT(SDL_AudioCVT * cvt,SDL_AudioFormat src_format,Uint8 src_channels,int src_rate,SDL_AudioFormat dst_format,Uint8 dst_channels,int dst_rate); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_CalculateGammaRamp <C-R>=<SID>Abbreviation("SDL_CalculateGammaRamp(float gamma,Uint16 * ramp); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_CaptureMouse <C-R>=<SID>Abbreviation("SDL_CaptureMouse(SDL_bool enabled); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_ClearError <C-R>=<SID>Abbreviation("SDL_ClearError(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_ClearHints <C-R>=<SID>Abbreviation("SDL_ClearHints(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_ClearQueuedAudio <C-R>=<SID>Abbreviation("SDL_ClearQueuedAudio(SDL_AudioDeviceID dev); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_CloseAudio <C-R>=<SID>Abbreviation("SDL_CloseAudio(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_CloseAudioDevice <C-R>=<SID>Abbreviation("SDL_CloseAudioDevice(SDL_AudioDeviceID dev); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_ComposeCustomBlendMode <C-R>=<SID>Abbreviation("SDL_ComposeCustomBlendMode(SDL_BlendFactor srcColorFactor,SDL_BlendFactor dstColorFactor,SDL_BlendOperation colorOperation,SDL_BlendFactor srcAlphaFactor,SDL_BlendFactor dstAlphaFactor,SDL_BlendOperation alphaOperation); /* SDL_BlendMode  */")<CR>
inoreabbrev <silent> <buffer> SDL_CondBroadcast <C-R>=<SID>Abbreviation("SDL_CondBroadcast(SDL_cond * cond); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_CondSignal <C-R>=<SID>Abbreviation("SDL_CondSignal(SDL_cond * cond); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_CondWait <C-R>=<SID>Abbreviation("SDL_CondWait(SDL_cond * cond,SDL_mutex * mutex); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_CondWaitTimeout <C-R>=<SID>Abbreviation("SDL_CondWaitTimeout(SDL_cond * cond,SDL_mutex * mutex,Uint32 ms); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_ConvertAudio <C-R>=<SID>Abbreviation("SDL_ConvertAudio(SDL_AudioCVT * cvt); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_ConvertPixels <C-R>=<SID>Abbreviation("SDL_ConvertPixels(int width,int height,Uint32 src_format,const void * src,int src_pitch,Uint32 dst_format,void * dst,int dst_pitch); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_ConvertSurface <C-R>=<SID>Abbreviation("SDL_ConvertSurface (SDL_Surface * src,const SDL_PixelFormat * fmt,Uint32 flags); /* SDL_Surface * */")<CR>
inoreabbrev <silent> <buffer> SDL_ConvertSurfaceFormat <C-R>=<SID>Abbreviation("SDL_ConvertSurfaceFormat (SDL_Surface * src,Uint32 pixel_format,Uint32 flags); /* SDL_Surface * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateColorCursor <C-R>=<SID>Abbreviation("SDL_CreateColorCursor(SDL_Surface *surface,int hot_x,int hot_y); /* SDL_Cursor * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateCond <C-R>=<SID>Abbreviation("SDL_CreateCond(); /* SDL_cond * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateCursor <C-R>=<SID>Abbreviation("SDL_CreateCursor(const Uint8 * data,const Uint8 * mask,int w,int h,int hot_x,int hot_y); /* SDL_Cursor * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateMutex <C-R>=<SID>Abbreviation("SDL_CreateMutex(); /* SDL_mutex * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateRGBSurface <C-R>=<SID>Abbreviation("SDL_CreateRGBSurface (Uint32 flags,int width,int height,int depth,Uint32 Rmask,Uint32 Gmask,Uint32 Bmask,Uint32 Amask); /* SDL_Surface * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateRGBSurfaceFrom <C-R>=<SID>Abbreviation("SDL_CreateRGBSurfaceFrom(void *pixels,int width,int height,int depth,int pitch,Uint32 Rmask,Uint32 Gmask,Uint32 Bmask,Uint32 Amask); /* SDL_Surface * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateRGBSurfaceWithFormat <C-R>=<SID>Abbreviation("SDL_CreateRGBSurfaceWithFormat (Uint32 flags,int width,int height,int depth,Uint32 format); /* SDL_Surface * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateRGBSurfaceWithFormatFrom <C-R>=<SID>Abbreviation("SDL_CreateRGBSurfaceWithFormatFrom (void *pixels,int width,int height,int depth,int pitch,Uint32 format); /* SDL_Surface * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateRenderer <C-R>=<SID>Abbreviation("SDL_CreateRenderer(SDL_Window * window,int index,Uint32 flags); /* SDL_Renderer *  */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateSemaphore <C-R>=<SID>Abbreviation("SDL_CreateSemaphore(Uint32 initial_value); /* SDL_sem * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateShapedWindow <C-R>=<SID>Abbreviation("SDL_CreateShapedWindow(const char *title,unsigned int x,unsigned int y,unsigned int w,unsigned int h,Uint32 flags); /* SDL_Window *  */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateSoftwareRenderer <C-R>=<SID>Abbreviation("SDL_CreateSoftwareRenderer(SDL_Surface * surface); /* SDL_Renderer *  */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateSystemCursor <C-R>=<SID>Abbreviation("SDL_CreateSystemCursor(SDL_SystemCursor id); /* SDL_Cursor * */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateTexture <C-R>=<SID>Abbreviation("SDL_CreateTexture(SDL_Renderer * renderer,Uint32 format,int access,int w,int h); /* SDL_Texture *  */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateTextureFromSurface <C-R>=<SID>Abbreviation("SDL_CreateTextureFromSurface(SDL_Renderer * renderer,SDL_Surface * surface); /* SDL_Texture *  */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateWindow <C-R>=<SID>Abbreviation("SDL_CreateWindow(const char *title,int x,int y,int w,int h,Uint32 flags); /* SDL_Window *  */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateWindowAndRenderer <C-R>=<SID>Abbreviation("SDL_CreateWindowAndRenderer( int width,int height,Uint32 window_flags,SDL_Window **window,SDL_Renderer **renderer); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_CreateWindowFrom <C-R>=<SID>Abbreviation("SDL_CreateWindowFrom(const void *data); /* SDL_Window *  */")<CR>
inoreabbrev <silent> <buffer> SDL_DXGIGetOutputInfo <C-R>=<SID>Abbreviation("SDL_DXGIGetOutputInfo( int displayIndex,int *adapterIndex,int *outputIndex ); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_DelEventWatch <C-R>=<SID>Abbreviation("SDL_DelEventWatch(SDL_EventFilter filter,void *userdata); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_DelHintCallback <C-R>=<SID>Abbreviation("SDL_DelHintCallback(const char *name,SDL_HintCallback callback,void *userdata); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_Delay <C-R>=<SID>Abbreviation("SDL_Delay(Uint32 ms); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_DequeueAudio <C-R>=<SID>Abbreviation("SDL_DequeueAudio(SDL_AudioDeviceID dev,void *data,Uint32 len); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_DestroyCond <C-R>=<SID>Abbreviation("SDL_DestroyCond(SDL_cond * cond); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_DestroyMutex <C-R>=<SID>Abbreviation("SDL_DestroyMutex(SDL_mutex * mutex); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_DestroyRenderer <C-R>=<SID>Abbreviation("SDL_DestroyRenderer(SDL_Renderer * renderer); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_DestroySemaphore <C-R>=<SID>Abbreviation("SDL_DestroySemaphore(SDL_sem * sem); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_DestroyTexture <C-R>=<SID>Abbreviation("SDL_DestroyTexture(SDL_Texture * texture); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_DestroyWindow <C-R>=<SID>Abbreviation("SDL_DestroyWindow(SDL_Window * window); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_DetachThread <C-R>=<SID>Abbreviation("SDL_DetachThread(SDL_Thread * thread); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_Direct <C-R>=<SID>Abbreviation("SDL_Direct3D9GetAdapterIndex( int displayIndex ); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_DisableScreenSaver <C-R>=<SID>Abbreviation("SDL_DisableScreenSaver(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_DuplicateSurface <C-R>=<SID>Abbreviation("SDL_DuplicateSurface(SDL_Surface * surface); /* SDL_Surface * */")<CR>
inoreabbrev <silent> <buffer> SDL_EnableScreenSaver <C-R>=<SID>Abbreviation("SDL_EnableScreenSaver(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_EnclosePoints <C-R>=<SID>Abbreviation("SDL_EnclosePoints(const SDL_Point * points,int count,const SDL_Rect * clip,SDL_Rect * result); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_Error <C-R>=<SID>Abbreviation("SDL_Error(SDL_errorcode code); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_EventState <C-R>=<SID>Abbreviation("SDL_EventState(Uint32 type,int state); /* Uint8  */")<CR>
inoreabbrev <silent> <buffer> SDL_FillRect <C-R>=<SID>Abbreviation("SDL_FillRect (SDL_Surface * dst,const SDL_Rect * rect,Uint32 color); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_FillRects <C-R>=<SID>Abbreviation("SDL_FillRects (SDL_Surface * dst,const SDL_Rect * rects,int count,Uint32 color); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_FilterEvents <C-R>=<SID>Abbreviation("SDL_FilterEvents(SDL_EventFilter filter,void *userdata); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_FlushEvent <C-R>=<SID>Abbreviation("SDL_FlushEvent(Uint32 type); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_FlushEvents <C-R>=<SID>Abbreviation("SDL_FlushEvents(Uint32 minType,Uint32 maxType); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_FreeAudioStream <C-R>=<SID>Abbreviation("SDL_FreeAudioStream(SDL_AudioStream *stream); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_FreeCursor <C-R>=<SID>Abbreviation("SDL_FreeCursor(SDL_Cursor * cursor); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_FreeFormat <C-R>=<SID>Abbreviation("SDL_FreeFormat(SDL_PixelFormat *format); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_FreePalette <C-R>=<SID>Abbreviation("SDL_FreePalette(SDL_Palette * palette); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_FreeRW <C-R>=<SID>Abbreviation("SDL_FreeRW(SDL_RWops * area); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_FreeSurface <C-R>=<SID>Abbreviation("SDL_FreeSurface(SDL_Surface * surface); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_FreeWAV <C-R>=<SID>Abbreviation("SDL_FreeWAV(Uint8 * audio_buf); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_BindTexture <C-R>=<SID>Abbreviation("SDL_GL_BindTexture(SDL_Texture *texture,float *texw,float *texh); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_CreateContext <C-R>=<SID>Abbreviation("SDL_GL_CreateContext(SDL_Window * window); /* SDL_GLContext  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_DeleteContext <C-R>=<SID>Abbreviation("SDL_GL_DeleteContext(SDL_GLContext context); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_ExtensionSupported <C-R>=<SID>Abbreviation("SDL_GL_ExtensionSupported(const char *extension); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_GetAttribute <C-R>=<SID>Abbreviation("SDL_GL_GetAttribute(SDL_GLattr attr,int *value); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_GetCurrentContext <C-R>=<SID>Abbreviation("SDL_GL_GetCurrentContext(); /* SDL_GLContext  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_GetCurrentWindow <C-R>=<SID>Abbreviation("SDL_GL_GetCurrentWindow(); /* SDL_Window*  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_GetDrawableSize <C-R>=<SID>Abbreviation("SDL_GL_GetDrawableSize(SDL_Window * window,int *w,int *h); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_GetProcAddress <C-R>=<SID>Abbreviation("SDL_GL_GetProcAddress(const char *proc); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_GetSwapInterval <C-R>=<SID>Abbreviation("SDL_GL_GetSwapInterval(); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_LoadLibrary <C-R>=<SID>Abbreviation("SDL_GL_LoadLibrary(const char *path); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_MakeCurrent <C-R>=<SID>Abbreviation("SDL_GL_MakeCurrent(SDL_Window * window,SDL_GLContext context); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_ResetAttributes <C-R>=<SID>Abbreviation("SDL_GL_ResetAttributes(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_SetAttribute <C-R>=<SID>Abbreviation("SDL_GL_SetAttribute(SDL_GLattr attr,int value); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_SetSwapInterval <C-R>=<SID>Abbreviation("SDL_GL_SetSwapInterval(int interval); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_SwapWindow <C-R>=<SID>Abbreviation("SDL_GL_SwapWindow(SDL_Window * window); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_UnbindTexture <C-R>=<SID>Abbreviation("SDL_GL_UnbindTexture(SDL_Texture *texture); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GL_UnloadLibrary <C-R>=<SID>Abbreviation("SDL_GL_UnloadLibrary(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerAddMapping <C-R>=<SID>Abbreviation("SDL_GameControllerAddMapping(const char* mappingString); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerAddMappingsFromRW <C-R>=<SID>Abbreviation("SDL_GameControllerAddMappingsFromRW(SDL_RWops * rw,int freerw); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerClose <C-R>=<SID>Abbreviation("SDL_GameControllerClose(SDL_GameController *gamecontroller); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerEventState <C-R>=<SID>Abbreviation("SDL_GameControllerEventState(int state); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerFromInstanceID <C-R>=<SID>Abbreviation("SDL_GameControllerFromInstanceID(SDL_JoystickID joyid); /* SDL_GameController * */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerFromPlayerIndex <C-R>=<SID>Abbreviation("SDL_GameControllerFromPlayerIndex(int player_index); /* SDL_GameController * */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetAttached <C-R>=<SID>Abbreviation("SDL_GameControllerGetAttached(SDL_GameController *gamecontroller); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetAxis <C-R>=<SID>Abbreviation("SDL_GameControllerGetAxis (SDL_GameController *gamecontroller,SDL_GameControllerAxis axis); /* Sint16 */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetAxisFromString <C-R>=<SID>Abbreviation("SDL_GameControllerGetAxisFromString(const char *pchString); /* SDL_GameControllerAxis  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetBindForAxis <C-R>=<SID>Abbreviation("SDL_GameControllerGetBindForAxis(SDL_GameController *gamecontroller,SDL_GameControllerAxis axis); /* SDL_GameControllerButtonBind  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetBindForButton <C-R>=<SID>Abbreviation("SDL_GameControllerGetBindForButton(SDL_GameController *gamecontroller,SDL_GameControllerButton button); /* SDL_GameControllerButtonBind  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetButton <C-R>=<SID>Abbreviation("SDL_GameControllerGetButton(SDL_GameController *gamecontroller,SDL_GameControllerButton button); /* Uint8  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetButtonFromString <C-R>=<SID>Abbreviation("SDL_GameControllerGetButtonFromString(const char *pchString); /* SDL_GameControllerButton  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetJoystick <C-R>=<SID>Abbreviation("SDL_GameControllerGetJoystick(SDL_GameController *gamecontroller); /* SDL_Joystick * */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetPlayerIndex <C-R>=<SID>Abbreviation("SDL_GameControllerGetPlayerIndex(SDL_GameController *gamecontroller); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetProduct <C-R>=<SID>Abbreviation("SDL_GameControllerGetProduct(SDL_GameController * gamecontroller); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetProductVersion <C-R>=<SID>Abbreviation("SDL_GameControllerGetProductVersion(SDL_GameController * gamecontroller); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetStringForAxis <C-R>=<SID>Abbreviation("SDL_GameControllerGetStringForAxis(SDL_GameControllerAxis axis); /* const char*  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetStringForButton <C-R>=<SID>Abbreviation("SDL_GameControllerGetStringForButton(SDL_GameControllerButton button); /* const char*  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetType <C-R>=<SID>Abbreviation("SDL_GameControllerGetType(SDL_GameController *gamecontroller); /* SDL_GameControllerType  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerGetVendor <C-R>=<SID>Abbreviation("SDL_GameControllerGetVendor(SDL_GameController * gamecontroller); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerMapping <C-R>=<SID>Abbreviation("SDL_GameControllerMapping(SDL_GameController * gamecontroller); /* char *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerMappingForDeviceIndex <C-R>=<SID>Abbreviation("SDL_GameControllerMappingForDeviceIndex(int joystick_index); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerMappingForGUID <C-R>=<SID>Abbreviation("SDL_GameControllerMappingForGUID(SDL_JoystickGUID guid); /* char *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerMappingForIndex <C-R>=<SID>Abbreviation("SDL_GameControllerMappingForIndex(int mapping_index); /* char *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerName <C-R>=<SID>Abbreviation("SDL_GameControllerName(SDL_GameController *gamecontroller); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerNameForIndex <C-R>=<SID>Abbreviation("SDL_GameControllerNameForIndex(int joystick_index); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerNumMappings <C-R>=<SID>Abbreviation("SDL_GameControllerNumMappings(); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerOpen <C-R>=<SID>Abbreviation("SDL_GameControllerOpen(int joystick_index); /* SDL_GameController * */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerRumble <C-R>=<SID>Abbreviation("SDL_GameControllerRumble(SDL_GameController *gamecontroller,Uint16 low_frequency_rumble,Uint16 high_frequency_rumble,Uint32 duration_ms); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerSetPlayerIndex <C-R>=<SID>Abbreviation("SDL_GameControllerSetPlayerIndex(SDL_GameController *gamecontroller,int player_index); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerTypeForIndex <C-R>=<SID>Abbreviation("SDL_GameControllerTypeForIndex(int joystick_index); /* SDL_GameControllerType  */")<CR>
inoreabbrev <silent> <buffer> SDL_GameControllerUpdate <C-R>=<SID>Abbreviation("SDL_GameControllerUpdate(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetAndroidSDKVersion <C-R>=<SID>Abbreviation("SDL_GetAndroidSDKVersion(); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetAssertionHandler <C-R>=<SID>Abbreviation("SDL_GetAssertionHandler(void **puserdata); /* SDL_AssertionHandler  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetAssertionReport <C-R>=<SID>Abbreviation("SDL_GetAssertionReport(); /* const SDL_AssertData *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetAudioDeviceName <C-R>=<SID>Abbreviation("SDL_GetAudioDeviceName(int index,int iscapture); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetAudioDeviceStatus <C-R>=<SID>Abbreviation("SDL_GetAudioDeviceStatus(SDL_AudioDeviceID dev); /* SDL_AudioStatus */")<CR>
inoreabbrev <silent> <buffer> SDL_GetAudioDriver <C-R>=<SID>Abbreviation("SDL_GetAudioDriver(int index); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetAudioStatus <C-R>=<SID>Abbreviation("SDL_GetAudioStatus(); /* SDL_AudioStatus  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetBasePath <C-R>=<SID>Abbreviation("SDL_GetBasePath(); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetCPUCacheLineSize <C-R>=<SID>Abbreviation("SDL_GetCPUCacheLineSize(); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetCPUCount <C-R>=<SID>Abbreviation("SDL_GetCPUCount(); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetClipRect <C-R>=<SID>Abbreviation("SDL_GetClipRect(SDL_Surface * surface,SDL_Rect * rect); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetClipboardText <C-R>=<SID>Abbreviation("SDL_GetClipboardText(); /* char *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetClosestDisplayMode <C-R>=<SID>Abbreviation("SDL_GetClosestDisplayMode(int displayIndex,const SDL_DisplayMode * mode,SDL_DisplayMode * closest); /* SDL_DisplayMode *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetColorKey <C-R>=<SID>Abbreviation("SDL_GetColorKey(SDL_Surface * surface,Uint32 * key); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetCurrentAudioDriver <C-R>=<SID>Abbreviation("SDL_GetCurrentAudioDriver(); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetCurrentDisplayMode <C-R>=<SID>Abbreviation("SDL_GetCurrentDisplayMode(int displayIndex,SDL_DisplayMode * mode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetCurrentVideoDriver <C-R>=<SID>Abbreviation("SDL_GetCurrentVideoDriver(); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetCursor <C-R>=<SID>Abbreviation("SDL_GetCursor(); /* SDL_Cursor * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetDefaultAssertionHandler <C-R>=<SID>Abbreviation("SDL_GetDefaultAssertionHandler(); /* SDL_AssertionHandler  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetDefaultCursor <C-R>=<SID>Abbreviation("SDL_GetDefaultCursor(); /* SDL_Cursor * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetDesktopDisplayMode <C-R>=<SID>Abbreviation("SDL_GetDesktopDisplayMode(int displayIndex,SDL_DisplayMode * mode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetDisplayBounds <C-R>=<SID>Abbreviation("SDL_GetDisplayBounds(int displayIndex,SDL_Rect * rect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetDisplayDPI <C-R>=<SID>Abbreviation("SDL_GetDisplayDPI(int displayIndex,float * ddpi,float * hdpi,float * vdpi); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetDisplayMode <C-R>=<SID>Abbreviation("SDL_GetDisplayMode(int displayIndex,int modeIndex,SDL_DisplayMode * mode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetDisplayName <C-R>=<SID>Abbreviation("SDL_GetDisplayName(int displayIndex); /* const char *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetDisplayOrientation <C-R>=<SID>Abbreviation("SDL_GetDisplayOrientation(int displayIndex); /* SDL_DisplayOrientation  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetDisplayUsableBounds <C-R>=<SID>Abbreviation("SDL_GetDisplayUsableBounds(int displayIndex,SDL_Rect * rect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetError <C-R>=<SID>Abbreviation("SDL_GetError(); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetEventFilter <C-R>=<SID>Abbreviation("SDL_GetEventFilter(SDL_EventFilter * filter,void **userdata); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetGlobalMouseState <C-R>=<SID>Abbreviation("SDL_GetGlobalMouseState(int *x,int *y); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetGrabbedWindow <C-R>=<SID>Abbreviation("SDL_GetGrabbedWindow(void); /* SDL_Window *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetHint <C-R>=<SID>Abbreviation("SDL_GetHint(const char *name); /* const char *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetHintBoolean <C-R>=<SID>Abbreviation("SDL_GetHintBoolean(const char *name,SDL_bool default_value); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetKeyFromName <C-R>=<SID>Abbreviation("SDL_GetKeyFromName(const char *name); /* SDL_Keycode  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetKeyFromScancode <C-R>=<SID>Abbreviation("SDL_GetKeyFromScancode(SDL_Scancode scancode); /* SDL_Keycode  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetKeyName <C-R>=<SID>Abbreviation("SDL_GetKeyName(SDL_Keycode key); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetKeyboardFocus <C-R>=<SID>Abbreviation("SDL_GetKeyboardFocus(void); /* SDL_Window *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetKeyboardState <C-R>=<SID>Abbreviation("SDL_GetKeyboardState(int *numkeys); /* const Uint8 * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetMemoryFunctions <C-R>=<SID>Abbreviation("SDL_GetMemoryFunctions(SDL_malloc_func *malloc_func,SDL_calloc_func *calloc_func,SDL_realloc_func *realloc_func,SDL_free_func *free_func); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetModState <C-R>=<SID>Abbreviation("SDL_GetModState(void); /* SDL_Keymod  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetMouseFocus <C-R>=<SID>Abbreviation("SDL_GetMouseFocus(void); /* SDL_Window *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetMouseState <C-R>=<SID>Abbreviation("SDL_GetMouseState(int *x,int *y); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetNumAllocations <C-R>=<SID>Abbreviation("SDL_GetNumAllocations(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetNumAudioDevices <C-R>=<SID>Abbreviation("SDL_GetNumAudioDevices(int iscapture); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetNumAudioDrivers <C-R>=<SID>Abbreviation("SDL_GetNumAudioDrivers(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetNumDisplayModes <C-R>=<SID>Abbreviation("SDL_GetNumDisplayModes(int displayIndex); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetNumRenderDrivers <C-R>=<SID>Abbreviation("SDL_GetNumRenderDrivers(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetNumTouchDevices <C-R>=<SID>Abbreviation("SDL_GetNumTouchDevices(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetNumTouchFingers <C-R>=<SID>Abbreviation("SDL_GetNumTouchFingers(SDL_TouchID touchID); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetNumVideoDisplays <C-R>=<SID>Abbreviation("SDL_GetNumVideoDisplays(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetNumVideoDrivers <C-R>=<SID>Abbreviation("SDL_GetNumVideoDrivers(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetPerformanceCounter <C-R>=<SID>Abbreviation("SDL_GetPerformanceCounter(void); /* Uint64  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetPerformanceFrequency <C-R>=<SID>Abbreviation("SDL_GetPerformanceFrequency(void); /* Uint64  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetPixelFormatName <C-R>=<SID>Abbreviation("SDL_GetPixelFormatName(Uint32 format); /* const char*  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetPlatform <C-R>=<SID>Abbreviation("SDL_GetPlatform (void); /* const char *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetPowerInfo <C-R>=<SID>Abbreviation("SDL_GetPowerInfo(int *secs,int *pct); /* SDL_PowerState  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetPrefPath <C-R>=<SID>Abbreviation("SDL_GetPrefPath(const char *org,const char *app); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetQueuedAudioSize <C-R>=<SID>Abbreviation("SDL_GetQueuedAudioSize(SDL_AudioDeviceID dev); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRGB <C-R>=<SID>Abbreviation("SDL_GetRGB(Uint32 pixel,const SDL_PixelFormat * format,Uint8 * r,Uint8 * g,Uint8 * b); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRGBA <C-R>=<SID>Abbreviation("SDL_GetRGBA(Uint32 pixel,const SDL_PixelFormat * format,Uint8 * r,Uint8 * g,Uint8 * b,Uint8 * a); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRelativeMouseMode <C-R>=<SID>Abbreviation("SDL_GetRelativeMouseMode(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRelativeMouseState <C-R>=<SID>Abbreviation("SDL_GetRelativeMouseState(int *x,int *y); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRenderDrawBlendMode <C-R>=<SID>Abbreviation("SDL_GetRenderDrawBlendMode(SDL_Renderer * renderer,SDL_BlendMode *blendMode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRenderDrawColor <C-R>=<SID>Abbreviation("SDL_GetRenderDrawColor(SDL_Renderer * renderer,Uint8 * r,Uint8 * g,Uint8 * b,Uint8 * a); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRenderDriverInfo <C-R>=<SID>Abbreviation("SDL_GetRenderDriverInfo(int index,SDL_RendererInfo * info); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRenderTarget <C-R>=<SID>Abbreviation("SDL_GetRenderTarget(SDL_Renderer *renderer); /* SDL_Texture *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRenderer <C-R>=<SID>Abbreviation("SDL_GetRenderer(SDL_Window * window); /* SDL_Renderer *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRendererInfo <C-R>=<SID>Abbreviation("SDL_GetRendererInfo(SDL_Renderer * renderer,SDL_RendererInfo * info); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRendererOutputSize <C-R>=<SID>Abbreviation("SDL_GetRendererOutputSize(SDL_Renderer * renderer,int *w,int *h); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRevision <C-R>=<SID>Abbreviation("SDL_GetRevision(void); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetRevisionNumber <C-R>=<SID>Abbreviation("SDL_GetRevisionNumber(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetScancodeFromKey <C-R>=<SID>Abbreviation("SDL_GetScancodeFromKey(SDL_Keycode key); /* SDL_Scancode  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetScancodeFromName <C-R>=<SID>Abbreviation("SDL_GetScancodeFromName(const char *name); /* SDL_Scancode  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetScancodeName <C-R>=<SID>Abbreviation("SDL_GetScancodeName(SDL_Scancode scancode); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetShapedWindowMode <C-R>=<SID>Abbreviation("SDL_GetShapedWindowMode(SDL_Window *window,SDL_WindowShapeMode *shape_mode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetSurfaceAlphaMod <C-R>=<SID>Abbreviation("SDL_GetSurfaceAlphaMod(SDL_Surface * surface,Uint8 * alpha); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetSurfaceBlendMode <C-R>=<SID>Abbreviation("SDL_GetSurfaceBlendMode(SDL_Surface * surface,SDL_BlendMode *blendMode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetSurfaceColorMod <C-R>=<SID>Abbreviation("SDL_GetSurfaceColorMod(SDL_Surface * surface,Uint8 * r,Uint8 * g,Uint8 * b); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetSystemRAM <C-R>=<SID>Abbreviation("SDL_GetSystemRAM(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetTextureAlphaMod <C-R>=<SID>Abbreviation("SDL_GetTextureAlphaMod(SDL_Texture * texture,Uint8 * alpha); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetTextureBlendMode <C-R>=<SID>Abbreviation("SDL_GetTextureBlendMode(SDL_Texture * texture,SDL_BlendMode *blendMode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetTextureColorMod <C-R>=<SID>Abbreviation("SDL_GetTextureColorMod(SDL_Texture * texture,Uint8 * r,Uint8 * g,Uint8 * b); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetTextureScaleMode <C-R>=<SID>Abbreviation("SDL_GetTextureScaleMode(SDL_Texture * texture,SDL_ScaleMode *scaleMode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetThreadID <C-R>=<SID>Abbreviation("SDL_GetThreadID(SDL_Thread * thread); /* SDL_threadID  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetThreadName <C-R>=<SID>Abbreviation("SDL_GetThreadName(SDL_Thread *thread); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetTicks <C-R>=<SID>Abbreviation("SDL_GetTicks(void); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetTouchDevice <C-R>=<SID>Abbreviation("SDL_GetTouchDevice(int index); /* SDL_TouchID  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetTouchDeviceType <C-R>=<SID>Abbreviation("SDL_GetTouchDeviceType(SDL_TouchID touchID); /* SDL_TouchDeviceType  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetTouchFinger <C-R>=<SID>Abbreviation("SDL_GetTouchFinger(SDL_TouchID touchID,int index); /* SDL_Finger *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetVersion <C-R>=<SID>Abbreviation("SDL_GetVersion(SDL_version * ver); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetVideoDriver <C-R>=<SID>Abbreviation("SDL_GetVideoDriver(int index); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowBordersSize <C-R>=<SID>Abbreviation("SDL_GetWindowBordersSize(SDL_Window * window,int *top,int *left,int *bottom,int *right); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowBrightness <C-R>=<SID>Abbreviation("SDL_GetWindowBrightness(SDL_Window * window); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowData <C-R>=<SID>Abbreviation("SDL_GetWindowData(SDL_Window * window,const char *name); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowDisplayIndex <C-R>=<SID>Abbreviation("SDL_GetWindowDisplayIndex(SDL_Window * window); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowDisplayMode <C-R>=<SID>Abbreviation("SDL_GetWindowDisplayMode(SDL_Window * window,SDL_DisplayMode * mode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowFlags <C-R>=<SID>Abbreviation("SDL_GetWindowFlags(SDL_Window * window); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowFromID <C-R>=<SID>Abbreviation("SDL_GetWindowFromID(Uint32 id); /* SDL_Window *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowGammaRamp <C-R>=<SID>Abbreviation("SDL_GetWindowGammaRamp(SDL_Window * window,Uint16 * red,Uint16 * green,Uint16 * blue); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowGrab <C-R>=<SID>Abbreviation("SDL_GetWindowGrab(SDL_Window * window); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowID <C-R>=<SID>Abbreviation("SDL_GetWindowID(SDL_Window * window); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowMaximumSize <C-R>=<SID>Abbreviation("SDL_GetWindowMaximumSize(SDL_Window * window,int *w,int *h); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowMinimumSize <C-R>=<SID>Abbreviation("SDL_GetWindowMinimumSize(SDL_Window * window,int *w,int *h); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowOpacity <C-R>=<SID>Abbreviation("SDL_GetWindowOpacity(SDL_Window * window,float * out_opacity); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowPixelFormat <C-R>=<SID>Abbreviation("SDL_GetWindowPixelFormat(SDL_Window * window); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowPosition <C-R>=<SID>Abbreviation("SDL_GetWindowPosition(SDL_Window * window,int *x,int *y); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowSize <C-R>=<SID>Abbreviation("SDL_GetWindowSize(SDL_Window * window,int *w,int *h); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowSurface <C-R>=<SID>Abbreviation("SDL_GetWindowSurface(SDL_Window * window); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowTitle <C-R>=<SID>Abbreviation("SDL_GetWindowTitle(SDL_Window * window); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_GetWindowWMInfo <C-R>=<SID>Abbreviation("SDL_GetWindowWMInfo(SDL_Window * window,SDL_SysWMinfo * info); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetYUVConversionMode <C-R>=<SID>Abbreviation("SDL_GetYUVConversionMode(void); /* SDL_YUV_CONVERSION_MODE  */")<CR>
inoreabbrev <silent> <buffer> SDL_GetYUVConversionModeForResolution <C-R>=<SID>Abbreviation("SDL_GetYUVConversionModeForResolution(int width,int height); /* SDL_YUV_CONVERSION_MODE  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticClose <C-R>=<SID>Abbreviation("SDL_HapticClose(SDL_Haptic * haptic); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticDestroyEffect <C-R>=<SID>Abbreviation("SDL_HapticDestroyEffect(SDL_Haptic * haptic,int effect); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticEffectSupported <C-R>=<SID>Abbreviation("SDL_HapticEffectSupported(SDL_Haptic * haptic,SDL_HapticEffect * effect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticGetEffectStatus <C-R>=<SID>Abbreviation("SDL_HapticGetEffectStatus(SDL_Haptic * haptic,int effect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticIndex <C-R>=<SID>Abbreviation("SDL_HapticIndex(SDL_Haptic * haptic); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticName <C-R>=<SID>Abbreviation("SDL_HapticName(int device_index); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticNewEffect <C-R>=<SID>Abbreviation("SDL_HapticNewEffect(SDL_Haptic * haptic,SDL_HapticEffect * effect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticNumAxes <C-R>=<SID>Abbreviation("SDL_HapticNumAxes(SDL_Haptic * haptic); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticNumEffects <C-R>=<SID>Abbreviation("SDL_HapticNumEffects(SDL_Haptic * haptic); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticNumEffectsPlaying <C-R>=<SID>Abbreviation("SDL_HapticNumEffectsPlaying(SDL_Haptic * haptic); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticOpen <C-R>=<SID>Abbreviation("SDL_HapticOpen(int device_index); /* SDL_Haptic * */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticOpenFromJoystick <C-R>=<SID>Abbreviation("SDL_HapticOpenFromJoystick(SDL_Joystick * joystick); /* SDL_Haptic * */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticOpenFromMouse <C-R>=<SID>Abbreviation("SDL_HapticOpenFromMouse(void); /* SDL_Haptic * */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticOpened <C-R>=<SID>Abbreviation("SDL_HapticOpened(int device_index); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticPause <C-R>=<SID>Abbreviation("SDL_HapticPause(SDL_Haptic * haptic); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticQuery <C-R>=<SID>Abbreviation("SDL_HapticQuery(SDL_Haptic * haptic); /* unsigned int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticRumbleInit <C-R>=<SID>Abbreviation("SDL_HapticRumbleInit(SDL_Haptic * haptic); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticRumblePlay <C-R>=<SID>Abbreviation("SDL_HapticRumblePlay(SDL_Haptic * haptic,float strength,Uint32 length ); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticRumbleStop <C-R>=<SID>Abbreviation("SDL_HapticRumbleStop(SDL_Haptic * haptic); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticRumbleSupported <C-R>=<SID>Abbreviation("SDL_HapticRumbleSupported(SDL_Haptic * haptic); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticRunEffect <C-R>=<SID>Abbreviation("SDL_HapticRunEffect(SDL_Haptic * haptic,int effect,Uint32 iterations); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticSetAutocenter <C-R>=<SID>Abbreviation("SDL_HapticSetAutocenter(SDL_Haptic * haptic,int autocenter); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticSetGain <C-R>=<SID>Abbreviation("SDL_HapticSetGain(SDL_Haptic * haptic,int gain); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticStopAll <C-R>=<SID>Abbreviation("SDL_HapticStopAll(SDL_Haptic * haptic); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticStopEffect <C-R>=<SID>Abbreviation("SDL_HapticStopEffect(SDL_Haptic * haptic,int effect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticUnpause <C-R>=<SID>Abbreviation("SDL_HapticUnpause(SDL_Haptic * haptic); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_HapticUpdateEffect <C-R>=<SID>Abbreviation("SDL_HapticUpdateEffect(SDL_Haptic * haptic,int effect,SDL_HapticEffect * data); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_Has <C-R>=<SID>Abbreviation("SDL_Has3DNow(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasARMSIMD <C-R>=<SID>Abbreviation("SDL_HasARMSIMD(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasAVX <C-R>=<SID>Abbreviation("SDL_HasAVX(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasAVX <C-R>=<SID>Abbreviation("SDL_HasAVX2(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasAVX <C-R>=<SID>Abbreviation("SDL_HasAVX512F(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasAltiVec <C-R>=<SID>Abbreviation("SDL_HasAltiVec(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasClipboardText <C-R>=<SID>Abbreviation("SDL_HasClipboardText(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasColorKey <C-R>=<SID>Abbreviation("SDL_HasColorKey(SDL_Surface * surface); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasEvent <C-R>=<SID>Abbreviation("SDL_HasEvent(Uint32 type); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasEvents <C-R>=<SID>Abbreviation("SDL_HasEvents(Uint32 minType,Uint32 maxType); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasIntersection <C-R>=<SID>Abbreviation("SDL_HasIntersection(const SDL_Rect * A,const SDL_Rect * B); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasMMX <C-R>=<SID>Abbreviation("SDL_HasMMX(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasNEON <C-R>=<SID>Abbreviation("SDL_HasNEON(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasRDTSC <C-R>=<SID>Abbreviation("SDL_HasRDTSC(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasSSE <C-R>=<SID>Abbreviation("SDL_HasSSE(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasSSE <C-R>=<SID>Abbreviation("SDL_HasSSE2(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasSSE <C-R>=<SID>Abbreviation("SDL_HasSSE3(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasSSE <C-R>=<SID>Abbreviation("SDL_HasSSE41(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasSSE <C-R>=<SID>Abbreviation("SDL_HasSSE42(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HasScreenKeyboardSupport <C-R>=<SID>Abbreviation("SDL_HasScreenKeyboardSupport(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_HideWindow <C-R>=<SID>Abbreviation("SDL_HideWindow(SDL_Window * window); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_Init <C-R>=<SID>Abbreviation("SDL_Init(Uint32 flags); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_InitSubSystem <C-R>=<SID>Abbreviation("SDL_InitSubSystem(Uint32 flags); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_IntersectRect <C-R>=<SID>Abbreviation("SDL_IntersectRect(const SDL_Rect * A,const SDL_Rect * B,SDL_Rect * result); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_IntersectRectAndLine <C-R>=<SID>Abbreviation("SDL_IntersectRectAndLine(const SDL_Rect * rect,int *X1,int *Y1,int *X2,int *Y2); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_IsAndroidTV <C-R>=<SID>Abbreviation("SDL_IsAndroidTV(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_IsChromebook <C-R>=<SID>Abbreviation("SDL_IsChromebook(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_IsDeXMode <C-R>=<SID>Abbreviation("SDL_IsDeXMode(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_IsGameController <C-R>=<SID>Abbreviation("SDL_IsGameController(int joystick_index); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_IsScreenKeyboardShown <C-R>=<SID>Abbreviation("SDL_IsScreenKeyboardShown(SDL_Window *window); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_IsScreenSaverEnabled <C-R>=<SID>Abbreviation("SDL_IsScreenSaverEnabled(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_IsShapedWindow <C-R>=<SID>Abbreviation("SDL_IsShapedWindow(const SDL_Window *window); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_IsTablet <C-R>=<SID>Abbreviation("SDL_IsTablet(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_IsTextInputActive <C-R>=<SID>Abbreviation("SDL_IsTextInputActive(void); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickClose <C-R>=<SID>Abbreviation("SDL_JoystickClose(SDL_Joystick * joystick); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickCurrentPowerLevel <C-R>=<SID>Abbreviation("SDL_JoystickCurrentPowerLevel(SDL_Joystick * joystick); /* SDL_JoystickPowerLevel  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickEventState <C-R>=<SID>Abbreviation("SDL_JoystickEventState(int state); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickFromInstanceID <C-R>=<SID>Abbreviation("SDL_JoystickFromInstanceID(SDL_JoystickID instance_id); /* SDL_Joystick * */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickFromPlayerIndex <C-R>=<SID>Abbreviation("SDL_JoystickFromPlayerIndex(int player_index); /* SDL_Joystick * */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetAttached <C-R>=<SID>Abbreviation("SDL_JoystickGetAttached(SDL_Joystick * joystick); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetAxis <C-R>=<SID>Abbreviation("SDL_JoystickGetAxis(SDL_Joystick * joystick,int axis); /* Sint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetAxisInitialState <C-R>=<SID>Abbreviation("SDL_JoystickGetAxisInitialState(SDL_Joystick * joystick,int axis,Sint16 *state); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetBall <C-R>=<SID>Abbreviation("SDL_JoystickGetBall(SDL_Joystick * joystick,int ball,int *dx,int *dy); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetButton <C-R>=<SID>Abbreviation("SDL_JoystickGetButton(SDL_Joystick * joystick,int button); /* Uint8  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetDeviceGUID <C-R>=<SID>Abbreviation("SDL_JoystickGetDeviceGUID(int device_index); /* SDL_JoystickGUID  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetDeviceInstanceID <C-R>=<SID>Abbreviation("SDL_JoystickGetDeviceInstanceID(int device_index); /* SDL_JoystickID  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetDevicePlayerIndex <C-R>=<SID>Abbreviation("SDL_JoystickGetDevicePlayerIndex(int device_index); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetDeviceProduct <C-R>=<SID>Abbreviation("SDL_JoystickGetDeviceProduct(int device_index); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetDeviceProductVersion <C-R>=<SID>Abbreviation("SDL_JoystickGetDeviceProductVersion(int device_index); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetDeviceType <C-R>=<SID>Abbreviation("SDL_JoystickGetDeviceType(int device_index); /* SDL_JoystickType  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetDeviceVendor <C-R>=<SID>Abbreviation("SDL_JoystickGetDeviceVendor(int device_index); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetGUID <C-R>=<SID>Abbreviation("SDL_JoystickGetGUID(SDL_Joystick * joystick); /* SDL_JoystickGUID  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetGUIDFromString <C-R>=<SID>Abbreviation("SDL_JoystickGetGUIDFromString(const char *pchGUID); /* SDL_JoystickGUID  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetGUIDString <C-R>=<SID>Abbreviation("SDL_JoystickGetGUIDString(SDL_JoystickGUID guid,char *pszGUID,int cbGUID); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetHat <C-R>=<SID>Abbreviation("SDL_JoystickGetHat(SDL_Joystick * joystick,int hat); /* Uint8  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetPlayerIndex <C-R>=<SID>Abbreviation("SDL_JoystickGetPlayerIndex(SDL_Joystick * joystick); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetProduct <C-R>=<SID>Abbreviation("SDL_JoystickGetProduct(SDL_Joystick * joystick); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetProductVersion <C-R>=<SID>Abbreviation("SDL_JoystickGetProductVersion(SDL_Joystick * joystick); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetType <C-R>=<SID>Abbreviation("SDL_JoystickGetType(SDL_Joystick * joystick); /* SDL_JoystickType  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickGetVendor <C-R>=<SID>Abbreviation("SDL_JoystickGetVendor(SDL_Joystick * joystick); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickInstanceID <C-R>=<SID>Abbreviation("SDL_JoystickInstanceID(SDL_Joystick * joystick); /* SDL_JoystickID  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickIsHaptic <C-R>=<SID>Abbreviation("SDL_JoystickIsHaptic(SDL_Joystick * joystick); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickName <C-R>=<SID>Abbreviation("SDL_JoystickName(SDL_Joystick * joystick); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickNameForIndex <C-R>=<SID>Abbreviation("SDL_JoystickNameForIndex(int device_index); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickNumAxes <C-R>=<SID>Abbreviation("SDL_JoystickNumAxes(SDL_Joystick * joystick); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickNumBalls <C-R>=<SID>Abbreviation("SDL_JoystickNumBalls(SDL_Joystick * joystick); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickNumButtons <C-R>=<SID>Abbreviation("SDL_JoystickNumButtons(SDL_Joystick * joystick); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickNumHats <C-R>=<SID>Abbreviation("SDL_JoystickNumHats(SDL_Joystick * joystick); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickOpen <C-R>=<SID>Abbreviation("SDL_JoystickOpen(int device_index); /* SDL_Joystick * */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickRumble <C-R>=<SID>Abbreviation("SDL_JoystickRumble(SDL_Joystick * joystick,Uint16 low_frequency_rumble,Uint16 high_frequency_rumble,Uint32 duration_ms); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickSetPlayerIndex <C-R>=<SID>Abbreviation("SDL_JoystickSetPlayerIndex(SDL_Joystick * joystick,int player_index); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_JoystickUpdate <C-R>=<SID>Abbreviation("SDL_JoystickUpdate(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LinuxSetThreadPriority <C-R>=<SID>Abbreviation("SDL_LinuxSetThreadPriority(Sint64 threadID,int priority); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_LoadBMP_RW <C-R>=<SID>Abbreviation("SDL_LoadBMP_RW(SDL_RWops * src,int freesrc); /* SDL_Surface * */")<CR>
inoreabbrev <silent> <buffer> SDL_LoadDollarTemplates <C-R>=<SID>Abbreviation("SDL_LoadDollarTemplates(SDL_TouchID touchId,SDL_RWops *src); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_LoadFile <C-R>=<SID>Abbreviation("SDL_LoadFile(const char *file,size_t *datasize); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_LoadFile_RW <C-R>=<SID>Abbreviation("SDL_LoadFile_RW(SDL_RWops * src,size_t *datasize,int freesrc); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_LoadFunction <C-R>=<SID>Abbreviation("SDL_LoadFunction(void *handle,const char *name); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_LoadObject <C-R>=<SID>Abbreviation("SDL_LoadObject(const char *sofile); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_LoadWAV_RW <C-R>=<SID>Abbreviation("SDL_LoadWAV_RW(SDL_RWops * src,int freesrc,SDL_AudioSpec * spec,Uint8 ** audio_buf,Uint32 * audio_len); /* SDL_AudioSpec * */")<CR>
inoreabbrev <silent> <buffer> SDL_LockAudio <C-R>=<SID>Abbreviation("SDL_LockAudio(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LockAudioDevice <C-R>=<SID>Abbreviation("SDL_LockAudioDevice(SDL_AudioDeviceID dev); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LockJoysticks <C-R>=<SID>Abbreviation("SDL_LockJoysticks(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LockMutex <C-R>=<SID>Abbreviation("SDL_LockMutex(SDL_mutex * mutex); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_LockSurface <C-R>=<SID>Abbreviation("SDL_LockSurface(SDL_Surface * surface); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_LockTexture <C-R>=<SID>Abbreviation("SDL_LockTexture(SDL_Texture * texture,const SDL_Rect * rect,void **pixels,int *pitch); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_LockTextureToSurface <C-R>=<SID>Abbreviation("SDL_LockTextureToSurface(SDL_Texture *texture,const SDL_Rect *rect,SDL_Surface **surface); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_Log <C-R>=<SID>Abbreviation("SDL_Log(SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(1); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogCritical <C-R>=<SID>Abbreviation("SDL_LogCritical(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogDebug <C-R>=<SID>Abbreviation("SDL_LogDebug(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogError <C-R>=<SID>Abbreviation("SDL_LogError(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogGetOutputFunction <C-R>=<SID>Abbreviation("SDL_LogGetOutputFunction(SDL_LogOutputFunction *callback,void **userdata); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogGetPriority <C-R>=<SID>Abbreviation("SDL_LogGetPriority(int category); /* SDL_LogPriority  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogInfo <C-R>=<SID>Abbreviation("SDL_LogInfo(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogMessage <C-R>=<SID>Abbreviation("SDL_LogMessage(int category,SDL_LogPriority priority,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(3); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogMessageV <C-R>=<SID>Abbreviation("SDL_LogMessageV(int category,SDL_LogPriority priority,const char *fmt,va_list ap); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogResetPriorities <C-R>=<SID>Abbreviation("SDL_LogResetPriorities(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogSetAllPriority <C-R>=<SID>Abbreviation("SDL_LogSetAllPriority(SDL_LogPriority priority); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogSetOutputFunction <C-R>=<SID>Abbreviation("SDL_LogSetOutputFunction(SDL_LogOutputFunction callback,void *userdata); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogSetPriority <C-R>=<SID>Abbreviation("SDL_LogSetPriority(int category,SDL_LogPriority priority); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogVerbose <C-R>=<SID>Abbreviation("SDL_LogVerbose(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LogWarn <C-R>=<SID>Abbreviation("SDL_LogWarn(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_LowerBlit <C-R>=<SID>Abbreviation("SDL_LowerBlit (SDL_Surface * src,SDL_Rect * srcrect,SDL_Surface * dst,SDL_Rect * dstrect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_LowerBlitScaled <C-R>=<SID>Abbreviation("SDL_LowerBlitScaled (SDL_Surface * src,SDL_Rect * srcrect,SDL_Surface * dst,SDL_Rect * dstrect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_MapRGB <C-R>=<SID>Abbreviation("SDL_MapRGB(const SDL_PixelFormat * format,Uint8 r,Uint8 g,Uint8 b); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_MapRGBA <C-R>=<SID>Abbreviation("SDL_MapRGBA(const SDL_PixelFormat * format,Uint8 r,Uint8 g,Uint8 b,Uint8 a); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_MasksToPixelFormatEnum <C-R>=<SID>Abbreviation("SDL_MasksToPixelFormatEnum(int bpp,Uint32 Rmask,Uint32 Gmask,Uint32 Bmask,Uint32 Amask); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_MaximizeWindow <C-R>=<SID>Abbreviation("SDL_MaximizeWindow(SDL_Window * window); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_MemoryBarrierAcquireFunction <C-R>=<SID>Abbreviation("SDL_MemoryBarrierAcquireFunction(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_MemoryBarrierReleaseFunction <C-R>=<SID>Abbreviation("SDL_MemoryBarrierReleaseFunction(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_Metal_CreateView <C-R>=<SID>Abbreviation("SDL_Metal_CreateView(SDL_Window * window); /* SDL_MetalView  */")<CR>
inoreabbrev <silent> <buffer> SDL_Metal_DestroyView <C-R>=<SID>Abbreviation("SDL_Metal_DestroyView(SDL_MetalView view); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_MinimizeWindow <C-R>=<SID>Abbreviation("SDL_MinimizeWindow(SDL_Window * window); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_MixAudio <C-R>=<SID>Abbreviation("SDL_MixAudio(Uint8 * dst,const Uint8 * src,Uint32 len,int volume); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_MixAudioFormat <C-R>=<SID>Abbreviation("SDL_MixAudioFormat(Uint8 * dst,const Uint8 * src,SDL_AudioFormat format,Uint32 len,int volume); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_MouseIsHaptic <C-R>=<SID>Abbreviation("SDL_MouseIsHaptic(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_NewAudioStream <C-R>=<SID>Abbreviation("SDL_NewAudioStream(const SDL_AudioFormat src_format,const Uint8 src_channels,const int src_rate,const SDL_AudioFormat dst_format,const Uint8 dst_channels,const int dst_rate); /* SDL_AudioStream *  */")<CR>
inoreabbrev <silent> <buffer> SDL_NumHaptics <C-R>=<SID>Abbreviation("SDL_NumHaptics(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_NumJoysticks <C-R>=<SID>Abbreviation("SDL_NumJoysticks(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_NumSensors <C-R>=<SID>Abbreviation("SDL_NumSensors(void); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_OnApplicationDidBecomeActive <C-R>=<SID>Abbreviation("SDL_OnApplicationDidBecomeActive(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_OnApplicationDidChangeStatusBarOrientation <C-R>=<SID>Abbreviation("SDL_OnApplicationDidChangeStatusBarOrientation(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_OnApplicationDidEnterBackground <C-R>=<SID>Abbreviation("SDL_OnApplicationDidEnterBackground(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_OnApplicationDidReceiveMemoryWarning <C-R>=<SID>Abbreviation("SDL_OnApplicationDidReceiveMemoryWarning(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_OnApplicationWillEnterForeground <C-R>=<SID>Abbreviation("SDL_OnApplicationWillEnterForeground(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_OnApplicationWillResignActive <C-R>=<SID>Abbreviation("SDL_OnApplicationWillResignActive(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_OnApplicationWillTerminate <C-R>=<SID>Abbreviation("SDL_OnApplicationWillTerminate(void); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_OpenAudio <C-R>=<SID>Abbreviation("SDL_OpenAudio(SDL_AudioSpec * desired,SDL_AudioSpec * obtained); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_OpenAudioDevice <C-R>=<SID>Abbreviation("SDL_OpenAudioDevice(const char *device,int iscapture,const SDL_AudioSpec * desired,SDL_AudioSpec * obtained,int allowed_changes); /* SDL_AudioDeviceID  */")<CR>
inoreabbrev <silent> <buffer> SDL_PauseAudio <C-R>=<SID>Abbreviation("SDL_PauseAudio(int pause_on); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_PauseAudioDevice <C-R>=<SID>Abbreviation("SDL_PauseAudioDevice(SDL_AudioDeviceID dev,int pause_on); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_PeepEvents <C-R>=<SID>Abbreviation("SDL_PeepEvents(SDL_Event * events,int numevents,SDL_eventaction action,Uint32 minType,Uint32 maxType); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_PixelFormatEnumToMasks <C-R>=<SID>Abbreviation("SDL_PixelFormatEnumToMasks(Uint32 format,int *bpp,Uint32 * Rmask,Uint32 * Gmask,Uint32 * Bmask,Uint32 * Amask); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_PollEvent <C-R>=<SID>Abbreviation("SDL_PollEvent(SDL_Event * event); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_PumpEvents <C-R>=<SID>Abbreviation("SDL_PumpEvents(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_PushEvent <C-R>=<SID>Abbreviation("SDL_PushEvent(SDL_Event * event); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_QueryTexture <C-R>=<SID>Abbreviation("SDL_QueryTexture(SDL_Texture * texture,Uint32 * format,int *access,int *w,int *h); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_QueueAudio <C-R>=<SID>Abbreviation("SDL_QueueAudio(SDL_AudioDeviceID dev,const void *data,Uint32 len); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_Quit <C-R>=<SID>Abbreviation("SDL_Quit(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_QuitSubSystem <C-R>=<SID>Abbreviation("SDL_QuitSubSystem(Uint32 flags); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_RWFromConstMem <C-R>=<SID>Abbreviation("SDL_RWFromConstMem(const void *mem,int size); /* SDL_RWops * */")<CR>
inoreabbrev <silent> <buffer> SDL_RWFromFP <C-R>=<SID>Abbreviation("SDL_RWFromFP(FILE * fp,SDL_bool autoclose); /* SDL_RWops * */")<CR>
inoreabbrev <silent> <buffer> SDL_RWFromFP <C-R>=<SID>Abbreviation("SDL_RWFromFP(void * fp,SDL_bool autoclose); /* SDL_RWops * */")<CR>
inoreabbrev <silent> <buffer> SDL_RWFromFile <C-R>=<SID>Abbreviation("SDL_RWFromFile(const char *file,const char *mode); /* SDL_RWops * */")<CR>
inoreabbrev <silent> <buffer> SDL_RWFromMem <C-R>=<SID>Abbreviation("SDL_RWFromMem(void *mem,int size); /* SDL_RWops * */")<CR>
inoreabbrev <silent> <buffer> SDL_RWclose <C-R>=<SID>Abbreviation("SDL_RWclose(SDL_RWops *context); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RWread <C-R>=<SID>Abbreviation("SDL_RWread(SDL_RWops *context,void *ptr,size_t size,size_t maxnum); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_RWseek <C-R>=<SID>Abbreviation("SDL_RWseek(SDL_RWops *context,Sint64 offset,int whence); /* Sint64  */")<CR>
inoreabbrev <silent> <buffer> SDL_RWsize <C-R>=<SID>Abbreviation("SDL_RWsize(SDL_RWops *context); /* Sint64  */")<CR>
inoreabbrev <silent> <buffer> SDL_RWtell <C-R>=<SID>Abbreviation("SDL_RWtell(SDL_RWops *context); /* Sint64  */")<CR>
inoreabbrev <silent> <buffer> SDL_RWwrite <C-R>=<SID>Abbreviation("SDL_RWwrite(SDL_RWops *context,const void *ptr,size_t size,size_t num); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_RaiseWindow <C-R>=<SID>Abbreviation("SDL_RaiseWindow(SDL_Window * window); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_ReadBE <C-R>=<SID>Abbreviation("SDL_ReadBE16(SDL_RWops * src); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_ReadBE <C-R>=<SID>Abbreviation("SDL_ReadBE32(SDL_RWops * src); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_ReadBE <C-R>=<SID>Abbreviation("SDL_ReadBE64(SDL_RWops * src); /* Uint64  */")<CR>
inoreabbrev <silent> <buffer> SDL_ReadLE <C-R>=<SID>Abbreviation("SDL_ReadLE16(SDL_RWops * src); /* Uint16  */")<CR>
inoreabbrev <silent> <buffer> SDL_ReadLE <C-R>=<SID>Abbreviation("SDL_ReadLE32(SDL_RWops * src); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_ReadLE <C-R>=<SID>Abbreviation("SDL_ReadLE64(SDL_RWops * src); /* Uint64  */")<CR>
inoreabbrev <silent> <buffer> SDL_ReadU <C-R>=<SID>Abbreviation("SDL_ReadU8(SDL_RWops * src); /* Uint8  */")<CR>
inoreabbrev <silent> <buffer> SDL_RecordGesture <C-R>=<SID>Abbreviation("SDL_RecordGesture(SDL_TouchID touchId); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RegisterApp <C-R>=<SID>Abbreviation("SDL_RegisterApp(char *name,Uint32 style,void *hInst); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RegisterEvents <C-R>=<SID>Abbreviation("SDL_RegisterEvents(int numevents); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_RemoveTimer <C-R>=<SID>Abbreviation("SDL_RemoveTimer(SDL_TimerID id); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderClear <C-R>=<SID>Abbreviation("SDL_RenderClear(SDL_Renderer * renderer); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderCopy <C-R>=<SID>Abbreviation("SDL_RenderCopy(SDL_Renderer * renderer,SDL_Texture * texture,const SDL_Rect * srcrect,const SDL_Rect * dstrect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderCopyEx <C-R>=<SID>Abbreviation("SDL_RenderCopyEx(SDL_Renderer * renderer,SDL_Texture * texture,const SDL_Rect * srcrect,const SDL_Rect * dstrect,const double angle,const SDL_Point *center,const SDL_RendererFlip flip); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderCopyExF <C-R>=<SID>Abbreviation("SDL_RenderCopyExF(SDL_Renderer * renderer,SDL_Texture * texture,const SDL_Rect * srcrect,const SDL_FRect * dstrect,const double angle,const SDL_FPoint *center,const SDL_RendererFlip flip); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderCopyF <C-R>=<SID>Abbreviation("SDL_RenderCopyF(SDL_Renderer * renderer,SDL_Texture * texture,const SDL_Rect * srcrect,const SDL_FRect * dstrect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawLine <C-R>=<SID>Abbreviation("SDL_RenderDrawLine(SDL_Renderer * renderer,int x1,int y1,int x2,int y2); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawLineF <C-R>=<SID>Abbreviation("SDL_RenderDrawLineF(SDL_Renderer * renderer,float x1,float y1,float x2,float y2); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawLines <C-R>=<SID>Abbreviation("SDL_RenderDrawLines(SDL_Renderer * renderer,const SDL_Point * points,int count); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawLinesF <C-R>=<SID>Abbreviation("SDL_RenderDrawLinesF(SDL_Renderer * renderer,const SDL_FPoint * points,int count); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawPoint <C-R>=<SID>Abbreviation("SDL_RenderDrawPoint(SDL_Renderer * renderer,int x,int y); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawPointF <C-R>=<SID>Abbreviation("SDL_RenderDrawPointF(SDL_Renderer * renderer,float x,float y); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawPoints <C-R>=<SID>Abbreviation("SDL_RenderDrawPoints(SDL_Renderer * renderer,const SDL_Point * points,int count); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawPointsF <C-R>=<SID>Abbreviation("SDL_RenderDrawPointsF(SDL_Renderer * renderer,const SDL_FPoint * points,int count); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawRect <C-R>=<SID>Abbreviation("SDL_RenderDrawRect(SDL_Renderer * renderer,const SDL_Rect * rect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawRectF <C-R>=<SID>Abbreviation("SDL_RenderDrawRectF(SDL_Renderer * renderer,const SDL_FRect * rect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawRects <C-R>=<SID>Abbreviation("SDL_RenderDrawRects(SDL_Renderer * renderer,const SDL_Rect * rects,int count); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderDrawRectsF <C-R>=<SID>Abbreviation("SDL_RenderDrawRectsF(SDL_Renderer * renderer,const SDL_FRect * rects,int count); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderFillRect <C-R>=<SID>Abbreviation("SDL_RenderFillRect(SDL_Renderer * renderer,const SDL_Rect * rect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderFillRectF <C-R>=<SID>Abbreviation("SDL_RenderFillRectF(SDL_Renderer * renderer,const SDL_FRect * rect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderFillRects <C-R>=<SID>Abbreviation("SDL_RenderFillRects(SDL_Renderer * renderer,const SDL_Rect * rects,int count); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderFillRectsF <C-R>=<SID>Abbreviation("SDL_RenderFillRectsF(SDL_Renderer * renderer,const SDL_FRect * rects,int count); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderFlush <C-R>=<SID>Abbreviation("SDL_RenderFlush(SDL_Renderer * renderer); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderGetClipRect <C-R>=<SID>Abbreviation("SDL_RenderGetClipRect(SDL_Renderer * renderer,SDL_Rect * rect); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderGetD <C-R>=<SID>Abbreviation("SDL_RenderGetD3D9Device(SDL_Renderer * renderer); /* IDirect3DDevice9*  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderGetIntegerScale <C-R>=<SID>Abbreviation("SDL_RenderGetIntegerScale(SDL_Renderer * renderer); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderGetLogicalSize <C-R>=<SID>Abbreviation("SDL_RenderGetLogicalSize(SDL_Renderer * renderer,int *w,int *h); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderGetMetalCommandEncoder <C-R>=<SID>Abbreviation("SDL_RenderGetMetalCommandEncoder(SDL_Renderer * renderer); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderGetMetalLayer <C-R>=<SID>Abbreviation("SDL_RenderGetMetalLayer(SDL_Renderer * renderer); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderGetScale <C-R>=<SID>Abbreviation("SDL_RenderGetScale(SDL_Renderer * renderer,float *scaleX,float *scaleY); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderGetViewport <C-R>=<SID>Abbreviation("SDL_RenderGetViewport(SDL_Renderer * renderer,SDL_Rect * rect); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderIsClipEnabled <C-R>=<SID>Abbreviation("SDL_RenderIsClipEnabled(SDL_Renderer * renderer); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderPresent <C-R>=<SID>Abbreviation("SDL_RenderPresent(SDL_Renderer * renderer); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderReadPixels <C-R>=<SID>Abbreviation("SDL_RenderReadPixels(SDL_Renderer * renderer,const SDL_Rect * rect,Uint32 format,void *pixels,int pitch); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderSetClipRect <C-R>=<SID>Abbreviation("SDL_RenderSetClipRect(SDL_Renderer * renderer,const SDL_Rect * rect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderSetIntegerScale <C-R>=<SID>Abbreviation("SDL_RenderSetIntegerScale(SDL_Renderer * renderer,SDL_bool enable); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderSetLogicalSize <C-R>=<SID>Abbreviation("SDL_RenderSetLogicalSize(SDL_Renderer * renderer,int w,int h); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderSetScale <C-R>=<SID>Abbreviation("SDL_RenderSetScale(SDL_Renderer * renderer,float scaleX,float scaleY); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderSetViewport <C-R>=<SID>Abbreviation("SDL_RenderSetViewport(SDL_Renderer * renderer,const SDL_Rect * rect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_RenderTargetSupported <C-R>=<SID>Abbreviation("SDL_RenderTargetSupported(SDL_Renderer *renderer); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_ReportAssertion <C-R>=<SID>Abbreviation("SDL_ReportAssertion(SDL_AssertData *,const char *,const char *,int); /* SDL_AssertState  */")<CR>
inoreabbrev <silent> <buffer> SDL_ResetAssertionReport <C-R>=<SID>Abbreviation("SDL_ResetAssertionReport(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_RestoreWindow <C-R>=<SID>Abbreviation("SDL_RestoreWindow(SDL_Window * window); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SIMDAlloc <C-R>=<SID>Abbreviation("SDL_SIMDAlloc(const size_t len); /* void *  */")<CR>
inoreabbrev <silent> <buffer> SDL_SIMDFree <C-R>=<SID>Abbreviation("SDL_SIMDFree(void *ptr); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SIMDGetAlignment <C-R>=<SID>Abbreviation("SDL_SIMDGetAlignment(); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_SaveAllDollarTemplates <C-R>=<SID>Abbreviation("SDL_SaveAllDollarTemplates(SDL_RWops *dst); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SaveBMP_RW <C-R>=<SID>Abbreviation("SDL_SaveBMP_RW (SDL_Surface * surface,SDL_RWops * dst,int freedst); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SaveDollarTemplate <C-R>=<SID>Abbreviation("SDL_SaveDollarTemplate(SDL_GestureID gestureId,SDL_RWops *dst); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SemPost <C-R>=<SID>Abbreviation("SDL_SemPost(SDL_sem * sem); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SemTryWait <C-R>=<SID>Abbreviation("SDL_SemTryWait(SDL_sem * sem); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SemValue <C-R>=<SID>Abbreviation("SDL_SemValue(SDL_sem * sem); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_SemWait <C-R>=<SID>Abbreviation("SDL_SemWait(SDL_sem * sem); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SemWaitTimeout <C-R>=<SID>Abbreviation("SDL_SemWaitTimeout(SDL_sem * sem,Uint32 ms); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorClose <C-R>=<SID>Abbreviation("SDL_SensorClose(SDL_Sensor * sensor); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorFromInstanceID <C-R>=<SID>Abbreviation("SDL_SensorFromInstanceID(SDL_SensorID instance_id); /* SDL_Sensor * */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorGetData <C-R>=<SID>Abbreviation("SDL_SensorGetData(SDL_Sensor * sensor,float *data,int num_values); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorGetDeviceInstanceID <C-R>=<SID>Abbreviation("SDL_SensorGetDeviceInstanceID(int device_index); /* SDL_SensorID  */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorGetDeviceName <C-R>=<SID>Abbreviation("SDL_SensorGetDeviceName(int device_index); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorGetDeviceNonPortableType <C-R>=<SID>Abbreviation("SDL_SensorGetDeviceNonPortableType(int device_index); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorGetDeviceType <C-R>=<SID>Abbreviation("SDL_SensorGetDeviceType(int device_index); /* SDL_SensorType  */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorGetInstanceID <C-R>=<SID>Abbreviation("SDL_SensorGetInstanceID(SDL_Sensor *sensor); /* SDL_SensorID  */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorGetName <C-R>=<SID>Abbreviation("SDL_SensorGetName(SDL_Sensor *sensor); /* const char * */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorGetNonPortableType <C-R>=<SID>Abbreviation("SDL_SensorGetNonPortableType(SDL_Sensor *sensor); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorGetType <C-R>=<SID>Abbreviation("SDL_SensorGetType(SDL_Sensor *sensor); /* SDL_SensorType  */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorOpen <C-R>=<SID>Abbreviation("SDL_SensorOpen(int device_index); /* SDL_Sensor * */")<CR>
inoreabbrev <silent> <buffer> SDL_SensorUpdate <C-R>=<SID>Abbreviation("SDL_SensorUpdate(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetAssertionHandler <C-R>=<SID>Abbreviation("SDL_SetAssertionHandler( SDL_AssertionHandler handler,void *userdata); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetClipRect <C-R>=<SID>Abbreviation("SDL_SetClipRect(SDL_Surface * surface,const SDL_Rect * rect); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetClipboardText <C-R>=<SID>Abbreviation("SDL_SetClipboardText(const char *text); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetColorKey <C-R>=<SID>Abbreviation("SDL_SetColorKey(SDL_Surface * surface,int flag,Uint32 key); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetCursor <C-R>=<SID>Abbreviation("SDL_SetCursor(SDL_Cursor * cursor); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetError <C-R>=<SID>Abbreviation("SDL_SetError(SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(1); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetEventFilter <C-R>=<SID>Abbreviation("SDL_SetEventFilter(SDL_EventFilter filter,void *userdata); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetHint <C-R>=<SID>Abbreviation("SDL_SetHint(const char *name,const char *value); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetHintWithPriority <C-R>=<SID>Abbreviation("SDL_SetHintWithPriority(const char *name,const char *value,SDL_HintPriority priority); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetMainReady <C-R>=<SID>Abbreviation("SDL_SetMainReady(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetMemoryFunctions <C-R>=<SID>Abbreviation("SDL_SetMemoryFunctions(SDL_malloc_func malloc_func,SDL_calloc_func calloc_func,SDL_realloc_func realloc_func,SDL_free_func free_func); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetModState <C-R>=<SID>Abbreviation("SDL_SetModState(SDL_Keymod modstate); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetPaletteColors <C-R>=<SID>Abbreviation("SDL_SetPaletteColors(SDL_Palette * palette,const SDL_Color * colors,int firstcolor,int ncolors); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetPixelFormatPalette <C-R>=<SID>Abbreviation("SDL_SetPixelFormatPalette(SDL_PixelFormat * format,SDL_Palette *palette); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetRelativeMouseMode <C-R>=<SID>Abbreviation("SDL_SetRelativeMouseMode(SDL_bool enabled); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetRenderDrawBlendMode <C-R>=<SID>Abbreviation("SDL_SetRenderDrawBlendMode(SDL_Renderer * renderer,SDL_BlendMode blendMode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetRenderDrawColor <C-R>=<SID>Abbreviation("SDL_SetRenderDrawColor(SDL_Renderer * renderer,Uint8 r,Uint8 g,Uint8 b,Uint8 a); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetRenderTarget <C-R>=<SID>Abbreviation("SDL_SetRenderTarget(SDL_Renderer *renderer,SDL_Texture *texture); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetSurfaceAlphaMod <C-R>=<SID>Abbreviation("SDL_SetSurfaceAlphaMod(SDL_Surface * surface,Uint8 alpha); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetSurfaceBlendMode <C-R>=<SID>Abbreviation("SDL_SetSurfaceBlendMode(SDL_Surface * surface,SDL_BlendMode blendMode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetSurfaceColorMod <C-R>=<SID>Abbreviation("SDL_SetSurfaceColorMod(SDL_Surface * surface,Uint8 r,Uint8 g,Uint8 b); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetSurfacePalette <C-R>=<SID>Abbreviation("SDL_SetSurfacePalette(SDL_Surface * surface,SDL_Palette * palette); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetSurfaceRLE <C-R>=<SID>Abbreviation("SDL_SetSurfaceRLE(SDL_Surface * surface,int flag); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetTextInputRect <C-R>=<SID>Abbreviation("SDL_SetTextInputRect(SDL_Rect *rect); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetTextureAlphaMod <C-R>=<SID>Abbreviation("SDL_SetTextureAlphaMod(SDL_Texture * texture,Uint8 alpha); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetTextureBlendMode <C-R>=<SID>Abbreviation("SDL_SetTextureBlendMode(SDL_Texture * texture,SDL_BlendMode blendMode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetTextureColorMod <C-R>=<SID>Abbreviation("SDL_SetTextureColorMod(SDL_Texture * texture,Uint8 r,Uint8 g,Uint8 b); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetTextureScaleMode <C-R>=<SID>Abbreviation("SDL_SetTextureScaleMode(SDL_Texture * texture,SDL_ScaleMode scaleMode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetThreadPriority <C-R>=<SID>Abbreviation("SDL_SetThreadPriority(SDL_ThreadPriority priority); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowBordered <C-R>=<SID>Abbreviation("SDL_SetWindowBordered(SDL_Window * window,SDL_bool bordered); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowBrightness <C-R>=<SID>Abbreviation("SDL_SetWindowBrightness(SDL_Window * window,float brightness); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowData <C-R>=<SID>Abbreviation("SDL_SetWindowData(SDL_Window * window,const char *name,void *userdata); /* void*  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowDisplayMode <C-R>=<SID>Abbreviation("SDL_SetWindowDisplayMode(SDL_Window * window,const SDL_DisplayMode * mode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowFullscreen <C-R>=<SID>Abbreviation("SDL_SetWindowFullscreen(SDL_Window * window,Uint32 flags); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowGammaRamp <C-R>=<SID>Abbreviation("SDL_SetWindowGammaRamp(SDL_Window * window,const Uint16 * red,const Uint16 * green,const Uint16 * blue); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowGrab <C-R>=<SID>Abbreviation("SDL_SetWindowGrab(SDL_Window * window,SDL_bool grabbed); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowHitTest <C-R>=<SID>Abbreviation("SDL_SetWindowHitTest(SDL_Window * window,SDL_HitTest callback,void *callback_data); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowIcon <C-R>=<SID>Abbreviation("SDL_SetWindowIcon(SDL_Window * window,SDL_Surface * icon); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowInputFocus <C-R>=<SID>Abbreviation("SDL_SetWindowInputFocus(SDL_Window * window); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowMaximumSize <C-R>=<SID>Abbreviation("SDL_SetWindowMaximumSize(SDL_Window * window,int max_w,int max_h); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowMinimumSize <C-R>=<SID>Abbreviation("SDL_SetWindowMinimumSize(SDL_Window * window,int min_w,int min_h); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowModalFor <C-R>=<SID>Abbreviation("SDL_SetWindowModalFor(SDL_Window * modal_window,SDL_Window * parent_window); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowOpacity <C-R>=<SID>Abbreviation("SDL_SetWindowOpacity(SDL_Window * window,float opacity); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowPosition <C-R>=<SID>Abbreviation("SDL_SetWindowPosition(SDL_Window * window,int x,int y); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowResizable <C-R>=<SID>Abbreviation("SDL_SetWindowResizable(SDL_Window * window,SDL_bool resizable); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowShape <C-R>=<SID>Abbreviation("SDL_SetWindowShape(SDL_Window *window,SDL_Surface *shape,SDL_WindowShapeMode *shape_mode); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowSize <C-R>=<SID>Abbreviation("SDL_SetWindowSize(SDL_Window * window,int w,int h); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowTitle <C-R>=<SID>Abbreviation("SDL_SetWindowTitle(SDL_Window * window,const char *title); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetWindowsMessageHook <C-R>=<SID>Abbreviation("SDL_SetWindowsMessageHook(SDL_WindowsMessageHook callback,void *userdata); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SetYUVConversionMode <C-R>=<SID>Abbreviation("SDL_SetYUVConversionMode(SDL_YUV_CONVERSION_MODE mode); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_ShowCursor <C-R>=<SID>Abbreviation("SDL_ShowCursor(int toggle); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_ShowMessageBox <C-R>=<SID>Abbreviation("SDL_ShowMessageBox(const SDL_MessageBoxData *messageboxdata,int *buttonid); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_ShowSimpleMessageBox <C-R>=<SID>Abbreviation("SDL_ShowSimpleMessageBox(Uint32 flags,const char *title,const char *message,SDL_Window *window); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_ShowWindow <C-R>=<SID>Abbreviation("SDL_ShowWindow(SDL_Window * window); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_SoftStretch <C-R>=<SID>Abbreviation("SDL_SoftStretch(SDL_Surface * src,const SDL_Rect * srcrect,SDL_Surface * dst,const SDL_Rect * dstrect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_StartTextInput <C-R>=<SID>Abbreviation("SDL_StartTextInput(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_StopTextInput <C-R>=<SID>Abbreviation("SDL_StopTextInput(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_TLSCreate <C-R>=<SID>Abbreviation("SDL_TLSCreate(); /* SDL_TLSID  */")<CR>
inoreabbrev <silent> <buffer> SDL_TLSGet <C-R>=<SID>Abbreviation("SDL_TLSGet(SDL_TLSID id); /* void *  */")<CR>
inoreabbrev <silent> <buffer> SDL_ThreadID <C-R>=<SID>Abbreviation("SDL_ThreadID(); /* SDL_threadID  */")<CR>
inoreabbrev <silent> <buffer> SDL_TryLockMutex <C-R>=<SID>Abbreviation("SDL_TryLockMutex(SDL_mutex * mutex); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_UIKitRunApp <C-R>=<SID>Abbreviation("SDL_UIKitRunApp(int argc,char *argv[],SDL_main_func mainFunction); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_UnionRect <C-R>=<SID>Abbreviation("SDL_UnionRect(const SDL_Rect * A,const SDL_Rect * B,SDL_Rect * result); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_UnloadObject <C-R>=<SID>Abbreviation("SDL_UnloadObject(void *handle); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_UnlockAudio <C-R>=<SID>Abbreviation("SDL_UnlockAudio(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_UnlockAudioDevice <C-R>=<SID>Abbreviation("SDL_UnlockAudioDevice(SDL_AudioDeviceID dev); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_UnlockJoysticks <C-R>=<SID>Abbreviation("SDL_UnlockJoysticks(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_UnlockMutex <C-R>=<SID>Abbreviation("SDL_UnlockMutex(SDL_mutex * mutex); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_UnlockSurface <C-R>=<SID>Abbreviation("SDL_UnlockSurface(SDL_Surface * surface); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_UnlockTexture <C-R>=<SID>Abbreviation("SDL_UnlockTexture(SDL_Texture * texture); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_UnregisterApp <C-R>=<SID>Abbreviation("SDL_UnregisterApp(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_UpdateTexture <C-R>=<SID>Abbreviation("SDL_UpdateTexture(SDL_Texture * texture,const SDL_Rect * rect,const void *pixels,int pitch); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_UpdateWindowSurface <C-R>=<SID>Abbreviation("SDL_UpdateWindowSurface(SDL_Window * window); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_UpdateWindowSurfaceRects <C-R>=<SID>Abbreviation("SDL_UpdateWindowSurfaceRects(SDL_Window * window,const SDL_Rect * rects,int numrects); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_UpdateYUVTexture <C-R>=<SID>Abbreviation("SDL_UpdateYUVTexture(SDL_Texture * texture,const SDL_Rect * rect,const Uint8 *Yplane,int Ypitch,const Uint8 *Uplane,int Upitch,const Uint8 *Vplane,int Vpitch); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_UpperBlit <C-R>=<SID>Abbreviation("SDL_UpperBlit (SDL_Surface * src,const SDL_Rect * srcrect,SDL_Surface * dst,SDL_Rect * dstrect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_UpperBlitScaled <C-R>=<SID>Abbreviation("SDL_UpperBlitScaled (SDL_Surface * src,const SDL_Rect * srcrect,SDL_Surface * dst,SDL_Rect * dstrect); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_VideoInit <C-R>=<SID>Abbreviation("SDL_VideoInit(const char *driver_name); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_VideoQuit <C-R>=<SID>Abbreviation("SDL_VideoQuit(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_Vulkan_CreateSurface <C-R>=<SID>Abbreviation("SDL_Vulkan_CreateSurface(                        SDL_Window *window,                        VkInstance instance,                        VkSurfaceKHR* surface); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_Vulkan_GetDrawableSize <C-R>=<SID>Abbreviation("SDL_Vulkan_GetDrawableSize(SDL_Window * window,int *w,int *h); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_Vulkan_GetInstanceExtensions <C-R>=<SID>Abbreviation("SDL_Vulkan_GetInstanceExtensions(                            SDL_Window *window,                            unsigned int *pCount,                            const char **pNames); /* SDL_bool  */")<CR>
inoreabbrev <silent> <buffer> SDL_Vulkan_GetVkGetInstanceProcAddr <C-R>=<SID>Abbreviation("SDL_Vulkan_GetVkGetInstanceProcAddr(); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_Vulkan_LoadLibrary <C-R>=<SID>Abbreviation("SDL_Vulkan_LoadLibrary(const char *path); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_Vulkan_UnloadLibrary <C-R>=<SID>Abbreviation("SDL_Vulkan_UnloadLibrary(); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_WaitEvent <C-R>=<SID>Abbreviation("SDL_WaitEvent(SDL_Event * event); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_WaitEventTimeout <C-R>=<SID>Abbreviation("SDL_WaitEventTimeout(SDL_Event * event,int timeout); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_WaitThread <C-R>=<SID>Abbreviation("SDL_WaitThread(SDL_Thread * thread,int *status); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_WarpMouseGlobal <C-R>=<SID>Abbreviation("SDL_WarpMouseGlobal(int x,int y); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_WarpMouseInWindow( SDL_WarpMouseInWindow(SDL_Window * window,int x,int y); /* void  */
inoreabbrev <silent> <buffer> SDL_WasInit <C-R>=<SID>Abbreviation("SDL_WasInit(Uint32 flags); /* Uint32  */")<CR>
inoreabbrev <silent> <buffer> SDL_WinRTGetDeviceFamily <C-R>=<SID>Abbreviation("SDL_WinRTGetDeviceFamily(); /* SDL_WinRT_DeviceFamily  */")<CR>
inoreabbrev <silent> <buffer> SDL_WinRTGetFSPathUNICODE <C-R>=<SID>Abbreviation("SDL_WinRTGetFSPathUNICODE(SDL_WinRT_Path pathType); /* const wchar_t *  */")<CR>
inoreabbrev <silent> <buffer> SDL_WinRTGetFSPathUTF <C-R>=<SID>Abbreviation("SDL_WinRTGetFSPathUTF8(SDL_WinRT_Path pathType); /* const char *  */")<CR>
inoreabbrev <silent> <buffer> SDL_WinRTRunApp <C-R>=<SID>Abbreviation("SDL_WinRTRunApp(SDL_main_func mainFunction,void * reserved); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_WriteBE <C-R>=<SID>Abbreviation("SDL_WriteBE16(SDL_RWops * dst,Uint16 value); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_WriteBE <C-R>=<SID>Abbreviation("SDL_WriteBE32(SDL_RWops * dst,Uint32 value); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_WriteBE <C-R>=<SID>Abbreviation("SDL_WriteBE64(SDL_RWops * dst,Uint64 value); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_WriteLE <C-R>=<SID>Abbreviation("SDL_WriteLE16(SDL_RWops * dst,Uint16 value); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_WriteLE <C-R>=<SID>Abbreviation("SDL_WriteLE32(SDL_RWops * dst,Uint32 value); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_WriteLE <C-R>=<SID>Abbreviation("SDL_WriteLE64(SDL_RWops * dst,Uint64 value); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_WriteU <C-R>=<SID>Abbreviation("SDL_WriteU8(SDL_RWops * dst,Uint8 value); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_abs <C-R>=<SID>Abbreviation("SDL_abs(int x); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_acos <C-R>=<SID>Abbreviation("SDL_acos(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_acosf <C-R>=<SID>Abbreviation("SDL_acosf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_asin <C-R>=<SID>Abbreviation("SDL_asin(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_asinf <C-R>=<SID>Abbreviation("SDL_asinf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_atan <C-R>=<SID>Abbreviation("SDL_atan(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_atan <C-R>=<SID>Abbreviation("SDL_atan2(double x,double y); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_atan <C-R>=<SID>Abbreviation("SDL_atan2f(float x,float y); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_atanf <C-R>=<SID>Abbreviation("SDL_atanf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_atof <C-R>=<SID>Abbreviation("SDL_atof(const char *str); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_atoi <C-R>=<SID>Abbreviation("SDL_atoi(const char *str); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_calloc <C-R>=<SID>Abbreviation("SDL_calloc(size_t nmemb,size_t size); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_ceil <C-R>=<SID>Abbreviation("SDL_ceil(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_ceilf <C-R>=<SID>Abbreviation("SDL_ceilf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_copysign <C-R>=<SID>Abbreviation("SDL_copysign(double x,double y); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_copysignf <C-R>=<SID>Abbreviation("SDL_copysignf(float x,float y); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_cos <C-R>=<SID>Abbreviation("SDL_cos(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_cosf <C-R>=<SID>Abbreviation("SDL_cosf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_exp <C-R>=<SID>Abbreviation("SDL_exp(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_expf <C-R>=<SID>Abbreviation("SDL_expf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_fabs <C-R>=<SID>Abbreviation("SDL_fabs(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_fabsf <C-R>=<SID>Abbreviation("SDL_fabsf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_floor <C-R>=<SID>Abbreviation("SDL_floor(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_floorf <C-R>=<SID>Abbreviation("SDL_floorf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_fmod <C-R>=<SID>Abbreviation("SDL_fmod(double x,double y); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_fmodf <C-R>=<SID>Abbreviation("SDL_fmodf(float x,float y); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_free <C-R>=<SID>Abbreviation("SDL_free(void *mem); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_getenv <C-R>=<SID>Abbreviation("SDL_getenv(const char *name); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_iPhoneSetAnimationCallback <C-R>=<SID>Abbreviation("SDL_iPhoneSetAnimationCallback(SDL_Window * window,int interval,void (*callback)(void*),void *callbackParam); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_iPhoneSetEventPump <C-R>=<SID>Abbreviation("SDL_iPhoneSetEventPump(SDL_bool enabled); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_iconv <C-R>=<SID>Abbreviation("SDL_iconv(SDL_iconv_t cd,const char **inbuf,size_t * inbytesleft,char **outbuf,size_t * outbytesleft); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_iconv_close <C-R>=<SID>Abbreviation("SDL_iconv_close(SDL_iconv_t cd); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_iconv_open <C-R>=<SID>Abbreviation("SDL_iconv_open(const char *tocode,const char *fromcode); /* SDL_iconv_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_iconv_string <C-R>=<SID>Abbreviation("SDL_iconv_string(const char *tocode,const char *fromcode,const char *inbuf,size_t inbytesleft); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_isdigit <C-R>=<SID>Abbreviation("SDL_isdigit(int x); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_islower <C-R>=<SID>Abbreviation("SDL_islower(int x); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_isspace <C-R>=<SID>Abbreviation("SDL_isspace(int x); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_isupper <C-R>=<SID>Abbreviation("SDL_isupper(int x); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_itoa <C-R>=<SID>Abbreviation("SDL_itoa(int value,char *str,int radix); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_lltoa <C-R>=<SID>Abbreviation("SDL_lltoa(Sint64 value,char *str,int radix); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_log <C-R>=<SID>Abbreviation("SDL_log(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_log <C-R>=<SID>Abbreviation("SDL_log10(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_log <C-R>=<SID>Abbreviation("SDL_log10f(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_logf <C-R>=<SID>Abbreviation("SDL_logf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_ltoa <C-R>=<SID>Abbreviation("SDL_ltoa(long value,char *str,int radix); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_malloc <C-R>=<SID>Abbreviation("SDL_malloc(size_t size); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_memcmp <C-R>=<SID>Abbreviation("SDL_memcmp(const void *s1,const void *s2,size_t len); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_memcpy <C-R>=<SID>Abbreviation("SDL_memcpy(SDL_OUT_BYTECAP(len) void *dst,SDL_IN_BYTECAP(len) const void *src,size_t len); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_memmove <C-R>=<SID>Abbreviation("SDL_memmove(SDL_OUT_BYTECAP(len) void *dst,SDL_IN_BYTECAP(len) const void *src,size_t len); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_memset <C-R>=<SID>Abbreviation("SDL_memset(SDL_OUT_BYTECAP(len) void *dst,int c,size_t len); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_pow <C-R>=<SID>Abbreviation("SDL_pow(double x,double y); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_powf <C-R>=<SID>Abbreviation("SDL_powf(float x,float y); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_qsort <C-R>=<SID>Abbreviation("SDL_qsort(void *base,size_t nmemb,size_t size,int (*compare) (const void *,const void *)); /* void  */")<CR>
inoreabbrev <silent> <buffer> SDL_realloc <C-R>=<SID>Abbreviation("SDL_realloc(void *mem,size_t size); /* void * */")<CR>
inoreabbrev <silent> <buffer> SDL_scalbn <C-R>=<SID>Abbreviation("SDL_scalbn(double x,int n); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_scalbnf <C-R>=<SID>Abbreviation("SDL_scalbnf(float x,int n); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_setenv <C-R>=<SID>Abbreviation("SDL_setenv(const char *name,const char *value,int overwrite); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_sin <C-R>=<SID>Abbreviation("SDL_sin(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_sinf <C-R>=<SID>Abbreviation("SDL_sinf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_snprintf <C-R>=<SID>Abbreviation("SDL_snprintf(SDL_OUT_Z_CAP(maxlen) char *text,size_t maxlen,SDL_PRINTF_FORMAT_STRING const char *fmt,... ) SDL_PRINTF_VARARG_FUNC(3); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_sqrt <C-R>=<SID>Abbreviation("SDL_sqrt(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_sqrtf <C-R>=<SID>Abbreviation("SDL_sqrtf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_sscanf <C-R>=<SID>Abbreviation("SDL_sscanf(const char *text,SDL_SCANF_FORMAT_STRING const char *fmt,...) SDL_SCANF_VARARG_FUNC(2); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_strcasecmp <C-R>=<SID>Abbreviation("SDL_strcasecmp(const char *str1,const char *str2); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_strchr <C-R>=<SID>Abbreviation("SDL_strchr(const char *str,int c); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_strcmp <C-R>=<SID>Abbreviation("SDL_strcmp(const char *str1,const char *str2); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_strdup <C-R>=<SID>Abbreviation("SDL_strdup(const char *str); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_strlcat <C-R>=<SID>Abbreviation("SDL_strlcat(SDL_INOUT_Z_CAP(maxlen) char *dst,const char *src,size_t maxlen); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_strlcpy <C-R>=<SID>Abbreviation("SDL_strlcpy(SDL_OUT_Z_CAP(maxlen) char *dst,const char *src,size_t maxlen); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_strlen <C-R>=<SID>Abbreviation("SDL_strlen(const char *str); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_strlwr <C-R>=<SID>Abbreviation("SDL_strlwr(char *str); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_strncasecmp <C-R>=<SID>Abbreviation("SDL_strncasecmp(const char *str1,const char *str2,size_t len); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_strncmp <C-R>=<SID>Abbreviation("SDL_strncmp(const char *str1,const char *str2,size_t maxlen); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_strrchr <C-R>=<SID>Abbreviation("SDL_strrchr(const char *str,int c); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_strrev <C-R>=<SID>Abbreviation("SDL_strrev(char *str); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_strstr <C-R>=<SID>Abbreviation("SDL_strstr(const char *haystack,const char *needle); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_strtod <C-R>=<SID>Abbreviation("SDL_strtod(const char *str,char **endp); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_strtokr <C-R>=<SID>Abbreviation("SDL_strtokr(char *s1,const char *s2,char **saveptr); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_strtol <C-R>=<SID>Abbreviation("SDL_strtol(const char *str,char **endp,int base); /* long  */")<CR>
inoreabbrev <silent> <buffer> SDL_strtoll <C-R>=<SID>Abbreviation("SDL_strtoll(const char *str,char **endp,int base); /* Sint64  */")<CR>
inoreabbrev <silent> <buffer> SDL_strtoul <C-R>=<SID>Abbreviation("SDL_strtoul(const char *str,char **endp,int base); /* unsigned long  */")<CR>
inoreabbrev <silent> <buffer> SDL_strtoull <C-R>=<SID>Abbreviation("SDL_strtoull(const char *str,char **endp,int base); /* Uint64  */")<CR>
inoreabbrev <silent> <buffer> SDL_strupr <C-R>=<SID>Abbreviation("SDL_strupr(char *str); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_tan <C-R>=<SID>Abbreviation("SDL_tan(double x); /* double  */")<CR>
inoreabbrev <silent> <buffer> SDL_tanf <C-R>=<SID>Abbreviation("SDL_tanf(float x); /* float  */")<CR>
inoreabbrev <silent> <buffer> SDL_tolower <C-R>=<SID>Abbreviation("SDL_tolower(int x); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_toupper <C-R>=<SID>Abbreviation("SDL_toupper(int x); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_uitoa <C-R>=<SID>Abbreviation("SDL_uitoa(unsigned int value,char *str,int radix); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_ulltoa <C-R>=<SID>Abbreviation("SDL_ulltoa(Uint64 value,char *str,int radix); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_ultoa <C-R>=<SID>Abbreviation("SDL_ultoa(unsigned long value,char *str,int radix); /* char * */")<CR>
inoreabbrev <silent> <buffer> SDL_utf <C-R>=<SID>Abbreviation("SDL_utf8strlcpy(SDL_OUT_Z_CAP(dst_bytes) char *dst,const char *src,size_t dst_bytes); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_utf <C-R>=<SID>Abbreviation("SDL_utf8strlen(const char *str); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_vsnprintf <C-R>=<SID>Abbreviation("SDL_vsnprintf(SDL_OUT_Z_CAP(maxlen) char *text,size_t maxlen,const char *fmt,va_list ap); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_vsscanf <C-R>=<SID>Abbreviation("SDL_vsscanf(const char *text,const char *fmt,va_list ap); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_wcscmp <C-R>=<SID>Abbreviation("SDL_wcscmp(const wchar_t *str1,const wchar_t *str2); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_wcsdup <C-R>=<SID>Abbreviation("SDL_wcsdup(const wchar_t *wstr); /* wchar_t * */")<CR>
inoreabbrev <silent> <buffer> SDL_wcslcat <C-R>=<SID>Abbreviation("SDL_wcslcat(SDL_INOUT_Z_CAP(maxlen) wchar_t *dst,const wchar_t *src,size_t maxlen); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_wcslcpy <C-R>=<SID>Abbreviation("SDL_wcslcpy(SDL_OUT_Z_CAP(maxlen) wchar_t *dst,const wchar_t *src,size_t maxlen); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_wcslen <C-R>=<SID>Abbreviation("SDL_wcslen(const wchar_t *wstr); /* size_t  */")<CR>
inoreabbrev <silent> <buffer> SDL_wcsncmp <C-R>=<SID>Abbreviation("SDL_wcsncmp(const wchar_t *str1,const wchar_t *str2,size_t maxlen); /* int  */")<CR>
inoreabbrev <silent> <buffer> SDL_wcsstr <C-R>=<SID>Abbreviation("SDL_wcsstr(const wchar_t *haystack,const wchar_t *needle); /* wchar_t * */")<CR>

" TTF SDL_TTF sdl_ttf sdlttf
inoreabbrev <silent> <buffer> TTF_ByteSwappedUNICODE <C-R>=<SID>Abbreviation("TTF_ByteSwappedUNICODE(int swapped); /* void  */")<CR>
inoreabbrev <silent> <buffer> TTF_CloseFont <C-R>=<SID>Abbreviation("TTF_CloseFont(TTF_Font *font); /* void  */")<CR>
inoreabbrev <silent> <buffer> TTF_FontAscent <C-R>=<SID>Abbreviation("TTF_FontAscent(const TTF_Font *font); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_FontDescent <C-R>=<SID>Abbreviation("TTF_FontDescent(const TTF_Font *font); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_FontFaceFamilyName <C-R>=<SID>Abbreviation("TTF_FontFaceFamilyName(const TTF_Font *font); /* char *  */")<CR>
inoreabbrev <silent> <buffer> TTF_FontFaceIsFixedWidth <C-R>=<SID>Abbreviation("TTF_FontFaceIsFixedWidth(const TTF_Font *font); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_FontFaceStyleName <C-R>=<SID>Abbreviation("TTF_FontFaceStyleName(const TTF_Font *font); /* char *  */")<CR>
inoreabbrev <silent> <buffer> TTF_FontFaces <C-R>=<SID>Abbreviation("TTF_FontFaces(const TTF_Font *font); /* long  */")<CR>
inoreabbrev <silent> <buffer> TTF_FontHeight <C-R>=<SID>Abbreviation("TTF_FontHeight(const TTF_Font *font); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_FontLineSkip <C-R>=<SID>Abbreviation("TTF_FontLineSkip(const TTF_Font *font); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_GetFontHinting <C-R>=<SID>Abbreviation("TTF_GetFontHinting(const TTF_Font *font); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_GetFontKerning <C-R>=<SID>Abbreviation("TTF_GetFontKerning(const TTF_Font *font); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_GetFontKerningSize <C-R>=<SID>Abbreviation("TTF_GetFontKerningSize(TTF_Font *font,int prev_index,int index) SDL_DEPRECATED;")<CR>
inoreabbrev <silent> <buffer> TTF_GetFontKerningSizeGlyphs <C-R>=<SID>Abbreviation("TTF_GetFontKerningSizeGlyphs(TTF_Font *font,Uint16 previous_ch,Uint16 ch);")<CR>
inoreabbrev <silent> <buffer> TTF_GetFontOutline <C-R>=<SID>Abbreviation("TTF_GetFontOutline(const TTF_Font *font); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_GetFontStyle <C-R>=<SID>Abbreviation("TTF_GetFontStyle(const TTF_Font *font); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_GlyphIsProvided <C-R>=<SID>Abbreviation("TTF_GlyphIsProvided(const TTF_Font *font,Uint16 ch); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_GlyphMetrics <C-R>=<SID>Abbreviation("TTF_GlyphMetrics(TTF_Font *font,Uint16 ch,int *minx,int *maxx,int *miny,int *maxy,int *advance); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_Init <C-R>=<SID>Abbreviation("TTF_Init(); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_Linked_Version <C-R>=<SID>Abbreviation("TTF_Linked_Version(); /* const SDL_version *  */")<CR>
inoreabbrev <silent> <buffer> TTF_OpenFont <C-R>=<SID>Abbreviation("TTF_OpenFont(const char *file,int ptsize); /* TTF_Font *  */")<CR>
inoreabbrev <silent> <buffer> TTF_OpenFontIndex <C-R>=<SID>Abbreviation("TTF_OpenFontIndex(const char *file,int ptsize,long index); /* TTF_Font *  */")<CR>
inoreabbrev <silent> <buffer> TTF_OpenFontIndexRW <C-R>=<SID>Abbreviation("TTF_OpenFontIndexRW(SDL_RWops *src,int freesrc,int ptsize,long index); /* TTF_Font *  */")<CR>
inoreabbrev <silent> <buffer> TTF_OpenFontRW <C-R>=<SID>Abbreviation("TTF_OpenFontRW(SDL_RWops *src,int freesrc,int ptsize); /* TTF_Font *  */")<CR>
inoreabbrev <silent> <buffer> TTF_Quit <C-R>=<SID>Abbreviation("TTF_Quit(); /* void  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderGlyph_Blended <C-R>=<SID>Abbreviation("TTF_RenderGlyph_Blended(TTF_Font *font,Uint16 ch,SDL_Color fg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderGlyph_Shaded <C-R>=<SID>Abbreviation("TTF_RenderGlyph_Shaded(TTF_Font *font,Uint16 ch,SDL_Color fg,SDL_Color bg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderGlyph_Solid <C-R>=<SID>Abbreviation("TTF_RenderGlyph_Solid(TTF_Font *font,Uint16 ch,SDL_Color fg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderText_Blended <C-R>=<SID>Abbreviation("TTF_RenderText_Blended(TTF_Font *font,const char *text,SDL_Color fg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderText_Blended_Wrapped <C-R>=<SID>Abbreviation("TTF_RenderText_Blended_Wrapped(TTF_Font *font,const char *text,SDL_Color fg,Uint32 wrapLength); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderText_Shaded <C-R>=<SID>Abbreviation("TTF_RenderText_Shaded(TTF_Font *font,const char *text,SDL_Color fg,SDL_Color bg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderText_Solid <C-R>=<SID>Abbreviation("TTF_RenderText_Solid(TTF_Font *font,const char *text,SDL_Color fg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderUNICODE_Blended <C-R>=<SID>Abbreviation("TTF_RenderUNICODE_Blended(TTF_Font *font,const Uint16 *text,SDL_Color fg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderUNICODE_Blended_Wrapped <C-R>=<SID>Abbreviation("TTF_RenderUNICODE_Blended_Wrapped(TTF_Font *font,const Uint16 *text,SDL_Color fg,Uint32 wrapLength); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderUNICODE_Shaded <C-R>=<SID>Abbreviation("TTF_RenderUNICODE_Shaded(TTF_Font *font,const Uint16 *text,SDL_Color fg,SDL_Color bg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderUNICODE_Solid <C-R>=<SID>Abbreviation("TTF_RenderUNICODE_Solid(TTF_Font *font,const Uint16 *text,SDL_Color fg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderUTF <C-R>=<SID>Abbreviation("TTF_RenderUTF8_Blended(TTF_Font *font,const char *text,SDL_Color fg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderUTF <C-R>=<SID>Abbreviation("TTF_RenderUTF8_Blended_Wrapped(TTF_Font *font,const char *text,SDL_Color fg,Uint32 wrapLength); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderUTF <C-R>=<SID>Abbreviation("TTF_RenderUTF8_Shaded(TTF_Font *font,const char *text,SDL_Color fg,SDL_Color bg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_RenderUTF <C-R>=<SID>Abbreviation("TTF_RenderUTF8_Solid(TTF_Font *font,const char *text,SDL_Color fg); /* SDL_Surface *  */")<CR>
inoreabbrev <silent> <buffer> TTF_SetFontHinting <C-R>=<SID>Abbreviation("TTF_SetFontHinting(TTF_Font *font,int hinting); /* void  */")<CR>
inoreabbrev <silent> <buffer> TTF_SetFontKerning <C-R>=<SID>Abbreviation("TTF_SetFontKerning(TTF_Font *font,int allowed); /* void  */")<CR>
inoreabbrev <silent> <buffer> TTF_SetFontOutline <C-R>=<SID>Abbreviation("TTF_SetFontOutline(TTF_Font *font,int outline); /* void  */")<CR>
inoreabbrev <silent> <buffer> TTF_SetFontStyle <C-R>=<SID>Abbreviation("TTF_SetFontStyle(TTF_Font *font,int style); /* void  */")<CR>
inoreabbrev <silent> <buffer> TTF_SizeText <C-R>=<SID>Abbreviation("TTF_SizeText(TTF_Font *font,const char *text,int *w,int *h); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_SizeUNICODE <C-R>=<SID>Abbreviation("TTF_SizeUNICODE(TTF_Font *font,const Uint16 *text,int *w,int *h); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_SizeUTF <C-R>=<SID>Abbreviation("TTF_SizeUTF8(TTF_Font *font,const char *text,int *w,int *h); /* int  */")<CR>
inoreabbrev <silent> <buffer> TTF_WasInit <C-R>=<SID>Abbreviation("TTF_WasInit(); /* int  */")<CR>

let b:did_ftplugin = 1
