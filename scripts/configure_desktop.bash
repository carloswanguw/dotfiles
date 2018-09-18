#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# Paths to config locations
CONFIGS_DIR="$REPO_DIR/anchor"

main()
{
	# remove any folders, link a custom base bashrc, setup vim
	remove_unused
	link_stuff
	setup_vim
	#configure_gsettings
	#configure_systemd
}

remove_unused()
{
	# Remove unused folders
	rm -rf ~/Music
	rm -rf ~/Videos
	rm -rf ~/Templates
	rm -rf ~/Examples
	rm -rf ~/Pictures
	rm -rf ~/Public
}

link_stuff()
{
	process_config_dir "$CONFIGS_DIR"

	echo "Symlinks created successfully."
	echo ""
}

setup_vim()
{
	sudo apt-get -y install vim

	BUNDLE="$HOME/.vim/bundle"
	if [ ! -d "$BUNDLE/Vundle.vim" ]; then
		mkdir -p "$BUNDLE"
		git clone https://github.com/VundleVim/Vundle.vim.git "$BUNDLE/Vundle.vim"
	fi

	# Update existing (or new) installation
	cd "$BUNDLE/Vundle.vim"
	git pull -q
	vim -c VundleInstall -c quitall
	bash "$BUNDLE/fzf/install" --all >> /dev/null

	echo "Vim setup updated."
}

#configure_gsettings()
#{
#	gsettings set com.canonical.Unity.Launcher favorites \
#		"['application://unity-control-center.desktop',
#		'application://gnome-system-monitor.desktop',
#		'application://org.gnome.Nautilus.desktop',
#		'application://opera.desktop',
#		'application://atom.desktop',
#		'unity://expo-icon',
#		'unity://devices',
#		'unity://running-apps']"
#
#	gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
#	gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ icon-size 42
#
#	# Disable sticky edges
#	dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-capture-mouse false
#
#	# Default apps
#	xdg-settings set default-web-browser opera.desktop
#}

#configure_systemd()
#{
#	# Systemd does not allow symlinks which is quite frustrating
#	# We must place actual service files, not symlinks
#	mkdir -p ~/.config/systemd/user
#	wget -P ~/.config/systemd/user/ https://raw.githubusercontent.com/syncthing/syncthing/master/etc/linux-systemd/user/syncthing.service
#	systemctl --user enable syncthing.service
#	systemctl --user start syncthing.service
#}

#------------------------------------------------------------------------------#
# Anything below this line should not require editing based on user preference

link_config()
{
	# $1 = Relative path to file from config root dir
	# $2 = Full path to config root dir
	# $3 = Full path to destination root dir
	LINK="$3$1"

	# Add sudo command if the folder is owned by root
	CONTAINING_DIR=$(dirname "$LINK")
	prefix=""
	if [ "$(stat -c '%U' "$CONTAINING_DIR")" == "root" ]; then
		prefix="sudo"
	fi

	$prefix mkdir -p "$CONTAINING_DIR"
	$prefix rm -f "$LINK"
	$prefix ln -sf "$2$1" "$LINK"
}

process_config_dir()
{
	# This function takes in a directory and looks for both the root and home
	# folders which are then used to link configs
	# $1 = Full path to directory containing 'root' and 'home' configs

	if [ -d "$1/home" ]; then
		setup_configs "$1/home" "$HOME"
	fi
	if [ -d "$1/root" ]; then
		setup_configs "$1/root" ""
	fi
}

setup_configs()
{
	# Loop over config folder and link config files
	# $1 = Full path to directory containing config files
	# $2 = Full path to destination root dir
	if [ ! -d "$1" ]; then
		echo "Warning: The following config directory was not found, skipping this directory."
		echo "	$1"
		return 0
	fi
	echo "Linking configs found in $1 to $2"

	configs=()

	cd "$1"
	while IFS=  read -r -d $'\0'; do
		# Remove the leading .
		string=${REPLY#*.}
		configs+=("$string")
	done < <(find . -type f -print0)

	for config in "${configs[@]}"; do
		link_config "$config" "$1" "$2"
	done
}

main
