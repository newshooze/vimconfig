if exists("b:did_ftplugin")
  finish
endif

let maplocalleader = ","
set dictionary=~/.vim/dict/vimscriptcompletions.txt
set complete+=k
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/vim.vim<CR>
nnoremap <buffer> <S-K> :help <C-r><C-W><CR>
nnoremap <buffer> <localleader>s <ESC>:unlet b:did_ftplugin<CR>:source %<CR>

let b:did_ftplugin = 1
