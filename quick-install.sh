#!/usr/local/bin/bash
sudo pkg install -y wget vim git curl

if ! [[ -d $HOME/.vim/bundle/Vundle.vim ]]; then
	mkdir -p $HOME/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

if ! [[ -d $HOME/.vim/colors ]]; then
	mkdir -p $HOME/.vim/colors
	wget -cq https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -O $HOME/.vim/colors/molokai.vim
fi	

if ! [[ -d $HOME/.vim/syntax ]]; then
	mkdir -p $HOME/.vim/syntax
fi

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle 
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install syntastic & YouCompleteMe
cd ~/.vim/bundle
if ! [[ -d $HOME/.vim/bundle/syntastic ]]; then
    git clone --depth=1 https://github.com/vim-syntastic/syntastic.git 
else
    cd syntastic && git pull origin master && cd -
fi
#if ! [[ -d $HOME/.vim/bundle/YouCompleteMe ]]; then
#    git clone https://github.com/Valloric/YouCompleteMe.git 
#else
#    cd YouCompleteMe && git pull origin master && cd -
#    git submodule update --init --recursive
#fi
#cd YouCompleteMe 
#YCM_CORES=1 ./install.py --js-completer


if [[ $(uname) == "Linux" ]]; then
    cp $EDT/vim/.vimrc $HOME
else
    cp $EDT/vim/.vimrc-cross $HOME/.vimrc
fi
cp $EDT/vim/sh.vim $HOME/.vim/syntax
cp $EDT/vim/*.add $HOME/.vim/spell

# Install Vundle plugins -- or try to at least, doesn't seem to work
vim +PluginInstall +qall
