set nocompatible               " be iMproved
filetype plugin on             " required!

set runtimepath+=~/.vim_runtime
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'
"source ~/.vim_runtime/vimrcs/basic.vim
"source ~/.vim_runtime/vimrcs/filetypes.vim
"source ~/.vim_runtime/vimrcs/plugins_config.vim
"source ~/.vim_runtime/vimrcs/extended.vim

"try
"source ~/.vim_runtime/my_configs.vim
"catch
"endtry

call vundle#rc()

Plugin 'parkr/vim-jekyll'
Plugin 'scrooloose/nerdtree'
Plugin 'Firef0x/PKGBUILD.vim'
Plugin 'spec.vim'
Plugin 'mdlerch/vim-gnuplot'
Plugin 'vimExplorer--Viau'
Plugin 'tpope/vim-fugitive'
Plugin 'geetarista/ego.vim'
Plugin 'tomasr/molokai'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'reedes/vim-lexical'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'tkztmk/vim-vala'
Plugin 'klen/python-mode'
Plugin 'kchmck/vim-coffee-script'
let vim_markdown_preview_github=1
execute pathogen#infect()
call pathogen#helptags()
syntax on
colorscheme molokai

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

" Keyboard shortcuts
" Traditional keybindings
map <C-a> <esc>ggVG<CR>
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" More normal splits
set splitbelow
set splitright
