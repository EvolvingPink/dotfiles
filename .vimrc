" Vundle stuff
set nocompatible
filetype off

" Vundle path
set rtp+=~/.vim/bundle/Vundle.vim

" Plugin environment
call vundle#begin()

" Useful plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
"Plugin 'Valloric/YouCompleteMe'        " A completion enginge, but the installation is not as easy as puting the plugin here
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'ctrlpvim/ctrlp.vim'

" Themes
Plugin 'altercation/vim-colors-solarized'
Plugin 'arcticicestudio/nord-vim'
Plugin 'rakr/vime-one'
Plugin 'ajmwagar/vim-deus'

call vundle#end()

"Vundle stuff
filetype plugin indent on

" Activate line numbers
set number

" Python specific configurations
au BufNewFile,BufRead *.py
    \ set tabstop=4         " <tab> is 4 spaces
    \ set softtabstop=4     " 
    \ set shiftwidth=4      " shift is 4 spaces
    \ set expandtab         " expand <tab> into spaces 
    \ set autoindent        " automaticly indent new lines
    \ set fileformat=unix   " set the fileformat to unix files to prevent conversion issues

" Ignore *.pyc and *~ Dateien in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" Remove unnecessary whitespace
:highlight BadWhitespace ctermbg=darkgreen guibg=lightgreen
au BufNewFile,BufRead *.py match BadWhitespace /\s\+$/

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set laststatus=2
let g:powerline_pycmd="py3"

" Tell syntastic to use the flake8 checker (alternatives: flake9, pyflake, pylint
let g:syntastic_python_checkers = ['flake8']

" The colorscheme for vim
"colorscheme elflord
" A more intelligent colorscheme
"if has('gui_running')
"  set background=dark
"  colorscheme solarized
"else
"  colorscheme elflord
"endif

" Colorscheme based on file type
au BufEnter * colorscheme elflord
au BufEnter *.py colorscheme desert

" Enable syntax highlighting
let python_highlight_all=1
syntax on

" Set the encoding of files to UTF-8
set encoding=utf-8

" Set where new splits should appear
set splitbelow
set splitright

" Split navigation
nnoremap <C-down> <C-W><C-down>
nnoremap <C-up> <C-W><C-up>
nnoremap <C-right> <C-W><C-right>
nnoremap <C-left> <C-W><C-left>

" Enable folding
set foldmethod=indent
set foldlevel=10

" Enable folding with space
nnoremap <space> za

" NerdTree keybindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NerdTree when Vim starts with a directory argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
	\ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NerdTree is the only window rmaining in th only tab
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window and bring back NERDTree
autocmd BufEnter * if bufname('#') =~ 'NERDTree_\d\#' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
	\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" CTRLP Settings
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'

"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
