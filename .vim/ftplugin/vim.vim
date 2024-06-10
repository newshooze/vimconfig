if exists("b:did_ftplugin")
  finish
endif

let maplocalleader = ","
set dictionary=~/.vim/dict/vimscriptcompletions.txt
set complete+=k
nnoremap <buffer> <leader>s :source %<CR>
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/vim.vim<CR>
let b:did_ftplugin = 1
