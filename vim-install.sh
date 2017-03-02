#!/bin/bash
if ! [[ -d $HOME/Programs ]]; then
	mkdir -p $HOME/Programs
fi

if ! [[ -d /usr/local/share/applications ]]; then
	sudo mkdir -p /usr/local/share/applications
	sudo mkdir -p /usr/local/share/pixmaps
	sudo mkdir -p /usr/local/bin
fi

VIM_VERSION=$(wget -cq https://github.com/vim/vim/releases -O - | grep ".tar.gz" | head -n 1 | cut -d '"' -f 2 | cut -d '/' -f 5 | sed 's|.tar.gz||g' | sed 's|v||g')
VIMDIR=$HOME/Programs/vim-${VIM_VERSION}
INSTDIR=$VIMDIR/INST
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
	sudo ln -sf $INSTDIR/usr/bin/vim /usr/local/bin/$i
done

for j in "${others[@]}"
do
	sudo ln -sf $INSTDIR/usr/bin/$j /usr/local/bin/$j
done

sudo ln -sf $VIMDIR/runtime/vim48x48.png /usr/local/share/pixmaps/vim.png
sudo ln -sf $VIMDIR/runtime/vim48x48.png /usr/local/share/pixmaps/gvim.png
sudo ln -sf $VIMDIR/runtime/vim.desktop /usr/local/share/applications/vim.desktop
sudo ln -sf $VIMDIR/runtime/gvim.desktop /usr/local/share/applications/gvim.desktop
