set encoding=utf-8
set relativenumber
set nu
set showmatch
set hlsearch
set ignorecase

set autoindent
set shiftwidth=4
set smartindent	
set smarttab
set softtabstop=4
set expandtab

set backspace=indent,eol,start

set cursorline

set showcmd
set showmode
set showmatch

set history=9999


" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
    set colorcolumn=120
endif

