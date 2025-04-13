call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()


"Theme
colorscheme koehler

"Enable mouse support
set mouse=a

"No error sound
set noerrorbells
set novisualbell

"line numbering
set relativenumber

"Customizing indentation
set expandtab
set foldcolumn=2
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"Syntax
syntax on

"Key bindings for NerdTree and additional terminal
map <F4> :NERDTreeToggle<CR>
map <F3> :terminal<CR>
