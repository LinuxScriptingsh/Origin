#!/bin/bash
echo "###################################################"
echo Made by LinuxScripting.sh. This script comes WITHOUT warranty.
echo Inspired by LinuxGuides. https://www.youtube.com/LinuxGuides
echo Please check the code of the script before executing this Script.
echo You can abort this script every time by pressing  Ctrl + C
echo "###################################################"
echo This Script will now delete ~/.Origin32/ "("If existing")"
echo [Enter]
echo "###################################################"

read

rm -r ~/.Origin32/


echo "###################################################"
echo Do you want, that this installer removes all other Versions of wine on your Computer?
echo [y/n]
echo "###################################################"
read a
if [[ $a == "Y" || $a == "y" ]]; then
	sudo apt purge *wine* --yes
fi

sudo dpkg --add-architecture i386
wget https://dl.winehq.org/wine-builds/Release.key
sudo apt-key add Release.key

#!/bin/bash
echo "Which OS are you using?"
options=("Linux Mint 18.x" "Linux Mint 17.x" "Ubuntu")
select opt in "${options[@]}"
do
	case $opt in
		"Linux Mint 18.x")
		if sudo grep -q "deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main" /etc/apt/sources.list.d/additional-repositories.list
		then
			echo "Repository already added, skipping..."
		else
			sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main'
			echo "Added repository"
		fi
		break
		;;
		"Linux Mint 17.x")
		if sudo grep -q "deb https://dl.winehq.org/wine-builds/ubuntu/ trusty main" /etc/apt/sources.list.d/additional-repositories.list
		then
			echo "Repository already added, skipping..."
		else
			sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ trusty main'
			echo "Added repository"
		fi
		break
		;;
		"Ubuntu")
		if sudo grep -q "https://dl.winehq.org/wine-builds/ubuntu/" /etc/apt/sources.list.d/additional-repositories.list
		then
			echo "Repository already added, skipping..."
		else
			sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
			echo "Added repository"
		fi
		break
		;;
		*)
		echo invalid option
		;;
	esac
done
sudo apt-get update

sudo apt-get install --install-recommends winehq-staging --yes

wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks

chmod +x winetricks

WINEPREFIX=~/.Origin32 WINEARCH=win32 wine
WINEPREFIX=~/.Origin32 ./winetricks vcrun2010 vcrun2013 vcrun2017 d3dx9
WINEPREFIX=~/.Origin32 wine winecfg

wget https://origin-a.akamaihd.net/Origin-Client-Download/origin/live/OriginThinSetup.exe
WINEPREFIX=~/.Origin32 wine OriginThinSetup.exe
rm OriginThinSetup.exe
rm winetricks
rm Release.key

echo "###################################################"
echo Installer has just finished.
echo Start game with following Command:
echo WINEPREFIX=~/.Origin32 wine "C:/Program Files (x86)/Origin/Origin.exe"
echo Good Luck and Have Fun!
echo "###################################################"
