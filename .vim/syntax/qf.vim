" File: qf.vim
" Description: Vim quickfix syntax file
" Revision: 2024-6-1

if len(g:grep_search_string)
  execute 'syntax match SearchMatch ' . '/' . g:grep_search_string . '/'
endif

hi SearchMatch ctermfg=132
