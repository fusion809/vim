set nocompatible               " be iMproved
filetype off                   " required!

call vundle#rc()

Plugin 'parkr/vim-jekyll'
Plugin 'scrooloose/nerdtree'
Plugin 'Firef0x/PKGBUILD.vim'
Plugin 'spec.vim'
Plugin 'vimExplorer--Viau'
Plugin 'tpope/vim-fugitive'
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

