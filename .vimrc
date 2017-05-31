" Copyright (C) Brenton Horne 2016-2017
" Maintainer : Brenton Horne <brentonhorne77gmail.com>
"
set nocompatible               " be iMproved
filetype plugin on             " required!

" Vundle
set runtimepath+=~/.vim_runtime
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
call vundle#rc()

"" Plugins
""" NERDTree
Plugin 'scrooloose/nerdtree'
" Adds too much time to startup
Plugin 'Xuyuanp/nerdtree-git-plugin'
"" Gnuplot
Plugin 'mdlerch/vim-gnuplot'
""" git manager
Plugin 'tpope/vim-fugitive'
""" Commit browser
Plugin 'junegunn/gv.vim'
""" Molokai theme
Plugin 'tomasr/molokai'
""" Markdown
Plugin 'plasticboy/vim-markdown'
""" Spell-check/thesaurus
Plugin 'reedes/vim-lexical'
""" Markdown Preview
Plugin 'JamshedVesuna/vim-markdown-preview'
""" Vala syntax-highlighting plugin, seemingly unmaintained since 7 Sep 2012
Plugin 'tkztmk/vim-vala'
""" Python linting, syntax-highlighting, code-completion, go-to-definition, etc.
"Plugin 'klen/python-mode'
""" CoffeeScript mode
Plugin 'kchmck/vim-coffee-script'
" Julia support
Plugin 'JuliaEditorSupport/julia-vim'
" Better C/C++ support
Plugin 'c.vim'
Plugin 'justmao945/vim-clang'
" Go support
"Plugin 'fatih/vim-go'
" TOML support -- useful for Hugo
Plugin 'cespare/vim-toml'
" PyMOL support
Plugin 'PyMol-syntax'
" Linter support
Plugin 'vim-syntastic/syntastic'

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_checkers = ['clang_check']
let g:syntastic_python_checkers = ['pylint']

" Needed as otherwise following Molokai and NERDTree lines will fail!
execute pathogen#infect()

" Molokai theme
syntax on
colorscheme molokai

" NERDTree
let NERDTreeShowHidden=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" file associations
au BufNewFile,BufRead *.m setlocal ft=matlab
au BufNewFile,BufRead virc setlocal ft=vim
au BufNewFile,BufRead *.zsh-theme setlocal ft=sh
au BufNewFile,BufRead *.py setlocal number
au BufNewFile,BufRead *.c setlocal number
au BufNewFile,BufRead *.cpp setlocal number
au BufNewFile,BufRead *.cxx setlocal number
au BufNewFile,BufRead *.cc setlocal number
au BufNewFile,BufRead *.C setlocal number
au BufNewFile,BufRead *.h setlocal number
au BufNewFile,BufRead *.hpp setlocal number

" Spell-checking
augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

let g:lexical#spell = 1
let g:lexical#spelllang = ['en_au', 'en_gb',]
setlocal spell

" Markdown mode
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" Markdown Preview
let vim_markdown_preview_github=1

" Keyboard shortcuts
" More traditional keybindings

" CTRL-X for Cut
silent !stty -ixon > /dev/null 2>/dev/null

" Ctrl-a for Select All
noremap <C-a> ggVG<CR>

" Ctrl-c is Copy only works in gVim
noremap <C-c> "+y<CR>

" Ctrl-q for Quit
noremap <C-q> :qa!<CR>

" Ctrl-v is paste
noremap <C-v> "+gP

" Ctrl-x for cut
noremap <C-x> "+x

" Build project with C-m
noremap <C-m> :make<CR>

" Move between split windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert> <C-v>
vmap <S-Insert> <C-v>

nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" More normal splits
set splitbelow
set splitright

" Show cursor position in bottom-right (default on most distros but no on
" CentOS)
set ruler

" Per https://vi.stackexchange.com/a/2163/11076
" Should fix backspace issues on CentOS and other VMs
set backspace=indent,eol,start

" Fix issue with devicons per gitter chat
set ambiwidth=double

" Should fix bizarre character issue I get under Gentoo per https://superuser.com/a/486549/222722
let g:NERDTreeDirArrows=0
