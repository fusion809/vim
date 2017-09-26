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
	if [[ "${DISTRO_VERSION}" == "5" ]]; then
		sudo urpmi.addmedia home:fusion809 $OBS_URL/Mageia_${DISTRO_VERSION}/
		sudo urpmi.update -a
		sudo urpmi vim vim-gtk2 git
        else 
		sudo dnf config-manager --add-repo $OBS_URL/Mageia_Cauldron/home:fusion809.repo
		sudo dnf install -y vim vim-gtk2 git
	fi
elif [[ "${DISTRO_NAME}" == "RHEL" ]] || [[ "${DISTRO_NAME}" == "Red Hat Enterprise Linux" ]]; then
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
echo 'deb http://download.opensuse.org/repositories/home:/fusion809/Debian_8.0/ /' > /etc/apt/sources.list.d/vim.list 
apt-get update
apt-get install -y vim vim-gtk git
EOF
    elif [[ "${DISTRO_VERSION}" == "9" ]]; then
sudo -s -- << EOF
wget -nv http://download.opensuse.org/repositories/home:fusion809/Debian_9.0/Release.key -O Release.key
apt-key add - < Release.key
echo 'deb http://download.opensuse.org/repositories/home:/fusion809/Debian_9.0/ /' > /etc/apt/sources.list.d/vim.list
apt-get update
apt-get install -y vim vim-gtk git
EOF
    fi
elif [[ "${DISTRO_NAME}" == "Ubuntu" ]]; then
    sudo -s -- << EOF
wget -nv http://download.opensuse.org/repositories/home:fusion809/xUbuntu_${DISTRO_VERSION}/Release.key -O Release.key
apt-key add - < Release.key
echo 'deb http://download.opensuse.org/repositories/home:/fusion809/xUbuntu_${DISTRO_VERSION}/ /' > /etc/apt/sources.list.d/vim.list
apt-get update
apt-get install -y vim vim-gtk git
EOF
else
	printf "Either you are using an unsupported platform or there is a bug in this installer script. Supported platforms are presently supported versions of CentOS, Fedora, Mageia, openSUSE, RHEL and Scientific Linux, except RHEL 5. Also SLE 12/12 P1/12 P2\n"
fi

if ! [[ -d $HOME/GitHub/mine/editors/vim ]]; then
	mkdir -p $HOME/GitHub/mine/editors
	cd $HOME/GitHub/mine/editors
	git clone https://github.com/fusion809/vim vim
else
	cd $HOME/GitHub/mine/editors/vim
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

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

vim +PluginInstall +qall

if [[ $(uname) == "Linux" ]]; then
    cp vim/.vimrc $HOME
else
    cp vim/.vimrc-cross $HOME/.vimrc
fi
cp vim/sh.vim $HOME/.vim/syntax
cp vim/*.add $HOME/.vim/spell
