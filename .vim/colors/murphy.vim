" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ron Aaron <ron@ronware.org>
" Last Change:	2003 May 02

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "murphy"

hi Normal		ctermbg=Black  ctermfg=yellow
hi Nontext		ctermfg=LightMagenta
if &t_Co ==9 
hi Comment		term=underline ctermfg=LightGrey
else
hi Comment		term=underline ctermfg=Red
endif
hi Constant		term=underline ctermfg=LightGreen 
hi Identifier	term=underline ctermfg=LightCyan  
hi Ignore					   ctermfg=black	  
hi PreProc		term=underline ctermfg=DarkGreen
hi Search		term=reverse					  
hi Special		term=bold	   ctermfg=Yellow
hi Statement	term=bold	   ctermfg=Yellow	  
hi Type						   ctermfg=Cyan
hi Error		term=reverse   ctermbg=Red	  ctermfg=White 
hi Todo			term=standout  ctermbg=Yellow ctermfg=Black 
" From the source:
hi Cursor										  
hi Directory	term=bold	   ctermfg=LightCyan  
hi ErrorMsg		term=standout  ctermbg=DarkRed	  ctermfg=White 
hi IncSearch	term=reverse   cterm=reverse	  
hi LineNr		term=underline ctermfg=Yellow					
hi ModeMsg		term=bold	   cterm=bold		  
hi MoreMsg		term=bold	   ctermfg=LightGreen 
hi NonText		term=bold	   ctermfg=Blue		  
hi Question		term=standout  ctermfg=LightGreen 
hi SpecialKey	term=bold	   ctermfg=LightBlue  
hi StatusLine	term=reverse,bold cterm=reverse   
hi StatusLineNC term=reverse   cterm=reverse	  
hi Title		term=bold	   ctermfg=LightMagenta 
hi WarningMsg	term=standout  ctermfg=LightRed   
hi Visual		term=reverse   cterm=reverse	  
