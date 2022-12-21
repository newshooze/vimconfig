
let maplocalleader = ","

nnoremap <buffer> <localleader>e :bd<CR>:edit ~/.vim/ftplugin/qf.vim<CR>

" Close the quick fix window in many ways
nnoremap <buffer> <CR> :bd<CR>
nnoremap <buffer> q :bd<CR>
nnoremap <buffer> <S-Q> :bd<CR>
nnoremap <buffer> <ESC> :bd<CR>
nnoremap <buffer> <localleader>q :bd<CR>
nnoremap <buffer> <leader>q :bd<CR>
nnoremap <buffer> <localleader>c :bd<CR>

" Go to next quickfix error
nnoremap <buffer> n :bd<CR>:cnext<CR>
nnoremap <buffer> <localleader>n :bd<CR>:cnext<CR>

" Go to previous quickfix error
nnoremap <buffer> p :bd<CR>:cprev<CR>
nnoremap <buffer> <localleader>p :bd<CR>:cprev<CR>

