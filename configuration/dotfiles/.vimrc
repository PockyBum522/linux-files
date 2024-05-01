syntax on
filetype indent plugin on

" I did the thing
noremap ; l
noremap l k
noremap k j
noremap j h

set modeline
set background=dark
hi Visual ctermfg=NONE ctermbg=BLUE cterm=bold
set number

" Uncomment these if you're using vim over cygwin, they're for block cursor but don't work on a local console
"let &t_ti.="\e[1 q"
"let &t_SI.="\e[5 q"
"let &t_EI.="\e[1 q"
"let &t_te.="\e[0 q"

" For learning to use hjkl...BY FORCE.
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

" Make enter useful when not in insert, too
nmap <S-Enter> i<CR><Esc>k
nmap <CR> i<CR><Esc>

"custom copy and paste
vmap <C-c> :w! ~/.vimbuf<CR>
nmap <C-c> :.w! ~/.vimbuf<CR>
nmap <C-v> :set paste<bar>:r ~/.vimbuf<bar>:set nopaste<CR>

"increment number moved from ctrl+a because tmux to ctrl + numpad+
noremap <C-i> <C-A>
