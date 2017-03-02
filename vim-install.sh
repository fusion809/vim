#!/bin/bash
VIM_VERSION=$(wget -cq https://github.com/vim/vim/releases -O - | grep ".tar.gz" | head -n 1 | cut -d '"' -f 2 | cut -d '/' -f 5 | sed 's|.tar.gz||g' | sed 's|v||g')
INSTDIR=$HOME/Programs/vim-${VIM_VERSION}/INST
datadir=/usr/share
bindir=/usr/bin
prefix=$INSTDIR/usr
EDT=$HOME/GitHub/mine/editors

sudo apt-get build-dep -y vim

if ! [[ $PWD == "$HOME/Programs" ]]; then
	cd $HOME/Programs
fi

if ! [[ -d $HOME/Programs/vim-${VIM_VERSION} ]]; then
	wget -cqO- https://github.com/vim/vim/archive/v${VIM_VERSION}.tar.gz | tar xz
	cd vim-${VIM_VERSION}
	mkdir -p INST/usr
else
	cd vim-${VIM_VERSION}
	make distclean
	if ! [[ -d $INST/usr ]]; then
		mkdir -p INST/usr
	fi
fi

./configure \
      --prefix=$prefix \
      --enable-gui=gtk2 \
      --with-features=huge \
      --enable-cscope \
      --enable-multibyte \
      --enable-perlinterp=dynamic \
      --enable-pythoninterp=dynamic \
      --enable-python3interp=dynamic \
      --enable-rubyinterp=dynamic \
      --enable-luainterp=dynamic
make
make install

vimlist=("eview"
"evim"
"ex"
"gview"
"gvim"
"gvimdiff"
"rgview"
"rgvim"
"rview"
"rvim"
"view"
"vim"
"vimdiff")

others=("gvimtutor"
"vimtutor"
"xxd")

for i in "${vimlist[@]}"
do
	sudo ln -sf $HOME/Programs/vim-${VIM_VERSION}/INST/usr/bin/vim /usr/local/bin/$i
done

for j in "${others[@]}"
do
	sudo ln -sf $HOME/Programs/vim-${VIM_VERSION}/INST/usr/bin/$j /usr/local/bin/$j
done
