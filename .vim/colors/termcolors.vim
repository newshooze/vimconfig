"%% Vim color file
" termcolors.vim 
" 
:set background=dark
:highlight clear
if version > 580
 hi clear
 if exists("syntax_on")
 syntax reset
 endif
endif
:hi Normal ctermfg=lightgrey
:hi Cursor cterm=bold,reverse
:hi VertSplit cterm=reverse
:hi Folded ctermfg=grey ctermbg=darkgrey
:hi FoldColumn ctermfg=4 ctermbg=7
:hi IncSearch cterm=none ctermfg=yellow ctermbg=green
:hi ModeMsg cterm=none ctermfg=brown
:hi MoreMsg ctermfg=darkgreen
:hi NonText cterm=bold ctermfg=blue
:hi Question ctermfg=green
:hi Search cterm=none ctermfg=grey ctermbg=blue
:hi SpecialKey ctermfg=darkgreen
:hi StatusLine cterm=bold,reverse
:hi StatusLineNC cterm=reverse
:hi Title cterm=bold ctermfg=yellow
:hi Statement ctermfg=lightblue
:hi Visual cterm=reverse
:hi WarningMsg ctermfg=1
:hi String ctermfg=brown
" Example comment 
:hi Comment cterm=bold ctermfg=darkgrey 
:hi Constant ctermfg=brown
:hi Special ctermfg=brown
:hi Identifier ctermfg=red
:hi Include ctermfg=darkgreen
:hi PreProc ctermfg=darkgreen
:hi Operator ctermfg=lightmagenta
:hi Define  ctermfg=green
:hi Type ctermfg=blue
:hi Function ctermfg=brown
:hi Structure ctermfg=green
:hi LineNr ctermfg=3
:hi Ignore cterm=bold ctermfg=7
:hi Todo ctermfg=red ctermbg=yellow
:hi Directory ctermfg=darkcyan
:hi ErrorMsg cterm=bold cterm=bold ctermfg=7 ctermbg=1
:hi VisualNOS cterm=bold,underline
:hi WildMenu ctermfg=0 ctermbg=3
:hi DiffAdd ctermbg=4
:hi DiffChange ctermbg=5
:hi DiffDelete cterm=bold ctermfg=4 ctermbg=6
:hi DiffText cterm=bold ctermbg=1
:hi Underlined cterm=underline ctermfg=5
:hi Error cterm=bold ctermfg=7 ctermbg=1
:hi SpellErrors cterm=bold ctermfg=7 ctermbg=1
