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
" Go support
"Plugin 'fatih/vim-go'

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

" Spell-checking
augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END
let g:lexical#spell = 1
let g:lexical#spelllang = ['en_au', 'en_gb',]

" Markdown mode
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" Markdown Preview
let vim_markdown_preview_github=1

" Keyboard shortcuts
" More traditional keybindings

" CTRL-X for Cut
silent !stty -ixon > /dev/null 2>/dev/null

" CTRL-A for Select All
map <C-A> ggVG<CR>

" CTRL-C is Copy only works in gVim
map <C-C> "+y<CR>

" C-Q for Quit
map <C-Q> :qa!<CR>

" CTRL-V is Paste only works in gVim
map <C-V> "+gP
cmap <C-V> <C-R>+

" CTRL-X for Cut only works in gVim
map <C-x> "+x
cmap <C-x> <C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>

nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" More normal splits
set splitbelow
set splitright

