
let maplocalleader = ","

nnoremap <buffer> <localleader>e :bd<CR>:edit ~/.vim/ftplugin/qf.vim<CR>

" Close the quick fix window in many ways
nnoremap <buffer> q :cclose<CR>
nnoremap <buffer> <S-Q> :cclose<CR>
nnoremap <buffer> <ESC> :cclose<CR>
nnoremap <buffer> <localleader>q :cclose<CR>
nnoremap <buffer> <leader>q :cclose<CR>
nnoremap <buffer> <localleader>c :cclose<CR>

" Go to next quickfix error
nnoremap <buffer> n :bd<CR>:cnext<CR>
nnoremap <buffer> <localleader>n :bd<CR>:cnext<CR>

" Go to previous quickfix error
nnoremap <buffer> p :bd<CR>:cprev<CR>
nnoremap <buffer> <localleader>p :bd<CR>:cprev<CR>

