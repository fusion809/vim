set nocompatible               " be iMproved
filetype off                   " required!

set runtimepath+=~/.vim_runtime
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'
source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

call vundle#rc()

Plugin 'parkr/vim-jekyll'
Plugin 'scrooloose/nerdtree'
Plugin 'Firef0x/PKGBUILD.vim'
Plugin 'spec.vim'
Plugin 'vimExplorer--Viau'
Plugin 'tpope/vim-fugitive'
Plugin 'geetarista/ego.vim'
execute pathogen#infect()
call pathogen#helptags()
syntax on
colorscheme ego

let GHUB="/home/fusion809/GitHub"
function FGI()
	NERDTree /home/fusion809/GitHub/mine/websites/fusion809.github.io
endfunction

function PKG()
	NERDTree /home/fusion809/GitHub/mine/packaging/PKGBUILDs
endfunction

function SH()
        NERDTree /home/fusion809/Shell
endfunction

au BufNewFile,BufRead *.m setlocal ft=matlab
