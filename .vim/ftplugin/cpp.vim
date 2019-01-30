

" Compile current filename.cpp to filename.o then link to executable filename
nmap <buffer> <F5> <ESC>:!g++ -c -I/usr/include -o %:r.o %<CR>
imap <buffer> <F5> <ESC>:!g++ -c -I/usr/include -o %:r.o %<CR>

nmap <buffer> <F8> :!make<CR>
imap <buffer> <S-F8> :!make clean<CR>

command! Template execute "source ~/.vim/template/cpp.vim"
map <buffer> <F12> :Template<CR>

" std c++ defs
iabbrev <buffer> cout std::cout << "" << std::endl;<ESC>:normal 0f"<CR>
iabbrev <buffer> ifstream ifstream filestream("".c_str());<CR>if(filestream.is_open())<CR>{<CR>std::string textline;<CR>while(filestream.good())<CR>{<CR>std::getline(filestream,textline,'\n');<CR>}<CR>}<CR>}<ESC>:normal 9k4w<CR>
iabbrev <buffer> find( find(haystack.begin(),haystack.end(),needle)==haystack.end());<ESC>:normal 12b<CR>
