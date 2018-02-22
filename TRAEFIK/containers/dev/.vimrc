:syntax on
:set background=light
set tabstop=4
:function! ReverseBackground()
: let Mysyn=&syntax
: if &bg=="light"
: se bg=dark
: else
: se bg=light
: endif
: syn on
: exe "set syntax=" . Mysyn
": echo "now syntax is "&syntax
:endfunction
:command! Invbg call ReverseBackground()
:noremap <F11> :Invbg<CR>
