#!/bin/bash
DISTRO_NAME=$(cat /etc/os-release | grep "^NAME=" | cut -d '=' -f 2 | sed 's/"//g')
DISTRO_VERSION=$(cat /etc/os-release | grep "^VERSION_ID=" | cut -d '=' -f 2 | sed 's/"//g')
OBS_URL="http://download.opensuse.org/repositories/home:fusion809/"

if [[ "${DISTRO_NAME}" == "Fedora" ]]; then
	sudo dnf config-manager --add-repo $OBS_URL/Fedora_${DISTRO_VERSION}/home:fusion809.repo
	sudo dnf install -y vim vim-gtk2 git
elif [[ "${DISTRO_NAME}" == "openSUSE Tumbleweed" ]]; then
	sudo zypper addrepo $OBS_URL/openSUSE_Tumbleweed/home:fusion809.repo
	sudo zypper refresh
	sudo zypper install -y vim gvim-gtk2 git
elif [[ "${DISTRO_NAME}" == "openSUSE Leap" ]]; then
	sudo zypper addrepo $OBS_URL/openSUSE_Leap_${DISTRO_VERSION}/home:fusion809.repo
	sudo zypper refresh
	sudo zypper install -y vim gvim-gtk2 git
elif [[ "${DISTRO_NAME}" == "CentOS Linux" ]]; then
	cd /etc/yum.repos.d/
	sudo curl -sOL $OBS_URL/CentOS_${DISTRO_VERSION}/home:fusion809.repo
        sudo yum install -y vim vim-gtk2
elif [[ "${DISTRO_NAME}" == "Mageia" ]]; then
	if [[ "${DISTRO_VERSION}" == "5"* ]]; then
		sudo urpmi.addmedia home:fusion809 $OBS_URL/Mageia_${DISTRO_VERSION}/
		sudo urpmi.update -a
		sudo urpmi vim vim-gtk2 git
        elif [[ "${DISTRO_VERSION}" == "6"* ]]; then
                sudo dnf config-manager --add-repo $OBS_URL/Mageia_${DISTRO_VERSION}/home:fusion809.repo
                sudo dnf install -y vim vim-gtk2 git
        else 
		sudo dnf config-manager --add-repo $OBS_URL/Mageia_Cauldron/home:fusion809.repo
		sudo dnf install -y vim vim-gtk2 git
	fi
elif [[ "${DISTRO_NAME}" == "RHEL" ]] || [[ "${DISTRO_NAME}" == "Red Hat Enterprise Linux" ]] || [[ "${DISTRO_NAME}" == "Oracle Linux" ]]; then
	cd /etc/yum.repos.d/
        sudo curl -sOL $OBS_URL/RHEL_${DISTRO_VERSION}/home:fusion809.repo
        sudo yum install -y vim vim-gtk2 git
elif [[ "${DISTRO_NAME}" == "Scientific Linux" ]]; then
	cd /etc/yum.repos.d/
        sudo curl -sOL $OBS_URL/ScientificLinux_${DISTRO_VERSION}/home:fusion809.repo
        sudo yum install -y vim vim-gtk2 git
elif [[ "${DISTRO_NAME}" == "SLE" ]] || [[ "${DISTRO_NAME}" == "SUSE Linux Enterprise"* ]]; then
	sudo zypper addrepo $OBS_URL/SLE_${DISTRO_VERSION/ /_}/home:fusion809.repo
        sudo zypper refresh
        sudo zypper install -y vim gvim-gtk2 git
elif [[ "${DISTRO_NAME}" == "Debian" ]]; then
    if [[ "${DISTRO_VERSION}" == "8" ]]; then
    sudo -s -- << EOF
wget -nv http://download.opensuse.org/repositories/home:fusion809/Debian_8.0/Release.key -O Release.key
apt-key add - < Release.key
rm Release.key
echo 'deb http://download.opensuse.org/repositories/home:/fusion809/Debian_8.0/ /' > /etc/apt/sources.list.d/vim.list 
apt-get update
apt-get install -y vim vim-gtk git curl
EOF
    elif [[ "${DISTRO_VERSION}" == "9" ]]; then
sudo -s -- << EOF
wget -nv http://download.opensuse.org/repositories/home:fusion809/Debian_9.0/Release.key -O Release.key
apt-key add - < Release.key
rm Release.key
echo 'deb http://download.opensuse.org/repositories/home:/fusion809/Debian_9.0/ /' > /etc/apt/sources.list.d/vim.list
apt-get update
apt-get install -y vim vim-gtk git curl
EOF
    fi
elif [[ "${DISTRO_NAME}" == "Ubuntu" ]]; then
    sudo -s -- << EOF
wget -nv http://download.opensuse.org/repositories/home:fusion809/xUbuntu_${DISTRO_VERSION}/Release.key -O Release.key
apt-key add - < Release.key
echo 'deb http://download.opensuse.org/repositories/home:/fusion809/xUbuntu_${DISTRO_VERSION}/ /' > /etc/apt/sources.list.d/vim.list
apt-get update
apt-get install -y vim vim-gtk git curl
EOF
else
	printf "Either you are using an unsupported platform or there is a bug in this installer script. Supported platforms are presently supported versions of CentOS, Fedora, Mageia, openSUSE, RHEL and Scientific Linux, except RHEL 5. Also SLE 12/12 P1/12 P2\n"
fi

export EDT=$HOME/GitHub/mine/editors
if ! [[ -d $HOME/GitHub/mine/editors/vim ]]; then
	mkdir -p $EDT
	cd $EDT
	git clone https://github.com/fusion809/vim vim
else
	cd $EDT/vim
	git pull --all
	cd ..
fi

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
if ! [[ -d $HOME/.vim/bundle/YouCompleteMe ]]; then
    git clone https://github.com/Valloric/YouCompleteMe.git 
else
    cd YouCompleteMe && git pull origin master && cd -
    git submodule update --init --recursive
fi
cd YouCompleteMe 
YCM_CORES=1 ./install.py --js-completer


if [[ $(uname) == "Linux" ]]; then
    cp $EDT/vim/.vimrc $HOME
else
    cp $EDT/vim/.vimrc-cross $HOME/.vimrc
fi
cp $EDT/vim/sh.vim $HOME/.vim/syntax
cp $EDT/vim/*.add $HOME/.vim/spell

# Install Vundle plugins -- or try to at least, doesn't seem to work
vim +PluginInstall +qall
