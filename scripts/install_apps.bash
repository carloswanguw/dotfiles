#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#------------------------------------------------------------------------------#
# App lists

# The 'core' is a collection of lightweight apps, these are installed when
# time is too short for a full install
CORE_APPS=(
	clang
	clang-format
	ctags
	expect
	git
	git-lfs
        gnome-do
	gparted
	htop
	jstest-gtk
	nmap
	screen
	ssh
	tmux
	tree
	traceroute
	unzip
	xclip
)

MAIN_APPS=(
	android-tools-adb
	default-jdk
	default-jre
	docker-ce
        ffmpeg
	firefox
	gimp
	gpsprune
	inkscape
	josm
	#mercurial
	octave
	#openvpn
	#opera-stable
        nautilus-image-converter
	pavucontrol
	pinta
        plantuml
	python-pip
	#syncthing
	virtualbox
	vlc
	wireshark
)

# Apps not usually needed on 'work' machines
ENTERTAINMENT_APPS=(
	nautilus-dropbox
        espeak
	steam
)

#------------------------------------------------------------------------------#
# Main entry point of script

main()
{
	repository_additions
	clear
	case "$1" in
		-e)
			echo "Installing entertainment apps only ..."
			sudo apt-get -y install "${ENTERTAINMENT_APPS[@]}"
			;;
		-c)
			echo "Installing core apps only ..."
			sudo apt-get -y install "${CORE_APPS[@]}"
			;;
		-a)
			echo "Installing all apps ..."
			sudo apt-get -y install "${ENTERTAINMENT_APPS[@]}"
			# Fall through
			;;&
		*)
			echo "Installing core and main apps ..."
			default_install
			;;
	esac
}

repository_additions()
{
	sudo add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"
	sudo add-apt-repository multiverse
	#sudo add-apt-repository -y ppa:thomas-schiex/blender
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt-get install curl

	## git-lfs
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

	## Docker
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

	echo "Updating package lists ..."
	sudo apt-get update -qq
}

default_install()
{
	sudo apt-get -y install "${CORE_APPS[@]}"
	sudo apt-get -y install "${MAIN_APPS[@]}"

	# Other more complicated installations
	install_chrome
	install_ros
}

#------------------------------------------------------------------------------#
# Custom Installs

install_chrome()
{
	if not_installed 'google-chrome-stable'; then
		TEMP_DIR=$(mktemp -d)
		cd "$TEMP_DIR"
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
		sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
	fi
}

install_ros()
{
	UBUNTU_CODENAME=$(lsb_release -s -c)
	case $UBUNTU_CODENAME in
		trusty)
			ROS_DISTRO=indigo;;
		xenial)
			ROS_DISTRO=kinetic;;
		*)
			echo "Unsupported version of Ubuntu detected. Only trusty (14.04.*) and xenial (16.04.*) are currently supported."
		exit 1
	esac

	sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu $UBUNTU_CODENAME main\" > /etc/apt/sources.list.d/ros-latest.list"
	wget -qO - http://packages.ros.org/ros.key | sudo apt-key add -

	echo "Updating package lists ..."
	sudo apt-get -qq update

	echo "Installing ROS $ROS_DISTRO ..."
	sudo apt-get -qq install ros-$ROS_DISTRO-desktop python-rosinstall > /dev/null

	source /opt/ros/$ROS_DISTRO/setup.bash

	# Prepare rosdep to install dependencies.
	echo "Updating rosdep ..."
	if [ ! -d /etc/ros/rosdep ]; then
		sudo rosdep init > /dev/null
	fi
	rosdep update > /dev/null
}

#------------------------------------------------------------------------------#
# Utility functions

not_installed() {
	res=$(dpkg-query -W -f='${Status}' "$1" 2>&1)
	if [[ "$res" == "install ok installed"* ]]; then
		echo "$1 is already installed"
		return 1
	fi
	return 0
}

main "$@"
