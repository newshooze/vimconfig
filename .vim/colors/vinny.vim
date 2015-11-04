" Vim color file

:set background=light
:highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "vinny"
:hi Normal		ctermfg=yellow ctermbg=black guifg=yellow guibg=grey15
hi NonText		ctermfg=lightMagenta
hi comment		ctermfg=black ctermbg=black  
hi constant		ctermfg=lightgreen
hi identifier	ctermfg=red
hi statement	ctermfg=white	ctermbg=black
hi preproc		ctermfg=darkgreen
hi type			ctermfg=white	ctermbg=black
hi special		ctermfg=yellow	ctermbg=black
hi Underlined	ctermfg=cyan		cterm=underline
hi label		ctermfg=yellow
hi operator		ctermfg=Magenta	ctermbg=black
hi ErrorMsg		ctermfg=lightRed
hi WarningMsg	ctermfg=cyan	
hi ModeMsg		ctermfg=yellow
hi MoreMsg		ctermfg=yellow
hi Error		ctermfg=red
hi Todo			ctermfg=black	ctermbg=darkYellow
hi Cursor		ctermfg=black	ctermbg=white
hi Search		ctermfg=black	ctermbg=darkYellow
hi IncSearch	ctermfg=black	ctermbg=darkYellow
hi LineNr		ctermfg=cyan
hi title		cterm=bold
hi StatusLineNC	ctermfg=black  ctermbg=blue
hi StatusLine	ctermfg=black  ctermbg=blue
hi VertSplit	ctermfg=blue	ctermbg=blue
hi Visual		term=reverse	ctermfg=black	ctermbg=darkCyan	
hi DiffChange	ctermbg=darkGreen	ctermfg=black
hi DiffText		ctermbg=lightGreen	ctermfg=black
hi DiffAdd		ctermbg=blue		ctermfg=black
hi DiffDelete   ctermbg=cyan		ctermfg=black
hi Folded		ctermbg=yellow		ctermfg=black
hi FoldColumn	ctermbg=gray		ctermfg=black
hi cIf0			ctermfg=gray

