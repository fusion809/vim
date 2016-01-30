set nocompatible               " be iMproved
filetype off                   " required!

set runtimepath+=~/.vim_runtime

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

let GHUB="/home/fusion809/GitHub"
function FGI()
	NERDTree /home/fusion809/GitHub/fusion809.github.io
endfunction

function PKG()
	NERDTree /home/fusion809/GitHub/PKGBUILDs
endfunction

function SH()
        NERDTree /home/fusion809/Shell
endfunction
