
map <buffer> <F8> :!make<CR>
map <buffer> <S-F8> :!make clean<CR>
map <buffer> <F5> :8new +:read\!make<CR>
autocmd FileType cpp,c,h,hpp,cxx,C,hxx :set dictionary=~/.vim/dict/c

command! Template execute "source ~/.vim/template/cpp.vim"
map <buffer> <F12> :Template<CR>
