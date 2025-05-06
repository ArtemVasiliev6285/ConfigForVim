" ======================
" PLUGINS (Vim-Plug)
" ======================
call plug#begin('~/.vim/plugged')

" Основные утилиты
Plug 'jiangmiao/auto-pairs'          " Автозакрытие скобок
Plug 'preservim/nerdtree'            " Файловый менеджер
Plug 'tpope/vim-fugitive'            " Git интеграция
Plug 'airblade/vim-gitgutter'        " Изменения Git
Plug 'ghifarit53/tokyonight-vim'     " Цветовая схема
Plug 'vim-airline/vim-airline'       " Статус бар
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'          " Комментирование кода
Plug 'yggdroot/indentline'           " Линии отступов
Plug 'mhinz/vim-startify'            " Стартовый экран

" LSP и автодополнение
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'            " Линтер

" Языковая поддержка
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'vim-scripts/bash-support.vim'
Plug 'mattn/emmet-vim'               " HTML/CSS
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'              " Подсветка цветов
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'evanleck/vim-svelte', { 'for': 'svelte' }

call plug#end()

" ======================
" BASIC SETTINGS
" ======================
set encoding=utf-8
set mouse=a
set noerrorbells
set novisualbell
set relativenumber
set number
set cursorline
set signcolumn=yes
set scrolloff=8
set colorcolumn=80

" Табы и отступы
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent

" Поиск
set ignorecase
set smartcase
set incsearch
set hlsearch

" Фолдинг
set foldmethod=indent
set foldlevel=99

" Файлы
set hidden
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile

" ======================
" THEME
" ======================
colorscheme tokyonight
set termguicolors
let g:airline_theme = "tokyonight"
let g:tokyonight_style = "night"
let g:tokyonight_enable_italic = 1

" ======================
" PLUGIN SETTINGS
" ======================

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
nmap <F4> :NERDTreeToggle<CR>

" GitGutter
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▁'

" Emmet
let g:user_emmet_mode='n'
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {
\  'variables': {'lang': 'ru'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\  },
\}

" coc.nvim
let g:coc_global_extensions = [
  \ 'coc-pyright',
  \ 'coc-go',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-snippets',
  \ 'coc-prettier'
  \ ]

" Использование TAB для автодополнения
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ALE
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'go': ['golangci-lint'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint', 'tsserver'],
\   'html': ['htmlhint'],
\   'css': ['stylelint'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort'],
\   'go': ['gofmt'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\}
let g:ale_fix_on_save = 1

" ======================
" KEY MAPPINGS
" ======================
nnoremap <leader>gd :CocCommand git.diffCached<CR>
nnoremap <leader>gl :CocCommand git.showCommit<CR>
nnoremap <silent> K :call ShowDocumentation()<CR>
nnoremap <F3> :terminal<CR>
nnoremap <leader>h :nohlsearch<CR>

" HTML/CSS специфичные
nnoremap <leader>ht :CocCommand html.showOutput<CR>
nnoremap <leader>em :CocCommand emmet.expandAbbreviation<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" ======================
" AUTOCMD
" ======================
" Форматирование при сохранении
autocmd BufWritePre *.go,*.py,*.sh,*.js,*.ts,*.html,*.css,*.scss :call CocAction('format')

" Настройки для разных типов файлов
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css,scss setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript,typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

" ======================
" FINAL SETUP
" ======================
syntax on
filetype plugin indent on
