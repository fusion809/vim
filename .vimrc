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
""" PKGBUILD
Plugin 'Firef0x/PKGBUILD.vim'
""" specfile
Plugin 'spec.vim'
""" Gnuplot
Plugin 'mdlerch/vim-gnuplot'
""" git manager
Plugin 'tpope/vim-fugitive'
""" Molokai theme
Plugin 'tomasr/molokai'
""" tabular for Markdown
Plugin 'godlygeek/tabular'
""" Markdown
Plugin 'plasticboy/vim-markdown'
""" Spell-check/thesaurus
Plugin 'reedes/vim-lexical'
""" Markdown Preview
Plugin 'JamshedVesuna/vim-markdown-preview'
""" Vala syntax-highlighting plugin, seemingly unmaintained since 7 Sep 2012
Plugin 'tkztmk/vim-vala'
""" Python linting, syntax-highlighting, code-completion, go-to-definition, etc.
Plugin 'klen/python-mode'
""" CoffeeScript mode
Plugin 'kchmck/vim-coffee-script'
""" VimL
Plugin 'syngan/vim-vimlint'

" Pathogen
execute pathogen#infect()
call pathogen#helptags()

" Molokai theme
syntax on
colorscheme molokai

" NERDTree
let NERDTreeShowHidden=1

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

" Markdown Preview
let vim_markdown_preview_github=1

" Keyboard shortcuts
" More traditional keybindings
map <C-a> <esc>ggVG<CR>
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" More normal splits
set splitbelow
set splitright
