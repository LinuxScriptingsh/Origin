#!/bin/bash
echo "###################################################"
echo Made by LinuxSquare. This script comes WITHOUT warranty.
echo Inspired by LinuxGuides. https://www.youtube.com/LinuxGuides
echo Please check the code of the script before executing the Script.
echo You can abort this script any time by pressing  Ctrl + C
echo "###################################################"
echo This Script will now delete ~/.EA32/ "("If existing")"
echo [Enter]
echo "###################################################"

read

rm -rf ~/.EA32/


echo "###################################################"
echo Do you want, that this installer removes all other Versions of wine on your Computer?
echo [y/n]
echo "###################################################"
read a
if [[ $a == "Y" || $a == "y" ]]; then
	sudo pacman -Rns wine-staging --noconfirm
fi

#!/bin/bash

sudo pacman -Syu --noconfirm

sudo pacman -S wine-staging lib32-libldap lib32-gnutls wget --noconfirm #wget just in case you haven't installed it yet.

wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks

chmod +x winetricks

WINEPREFIX=~/.EA32 WINEARCH=win32 wine
WINEPREFIX=~/.EA32 ./winetricks vcrun2010
WINEPREFIX=~/.EA32 ./winetricks vcrun2013
WINEPREFIX=~/.EA32 ./winetricks vcrun2017
WINEPREFIX=~/.EA32 ./winetricks d3dx9
WINEPREFIX=~/.EA32 wine winecfg

wget https://origin-a.akamaihd.net/Origin-Client-Download/origin/live/OriginThinSetup.exe
WINEPREFIX=~/.EA32 wine OriginThinSetup.exe
rm -rf OriginThinSetup.exe
rm -rf winetricks

echo "###################################################"
echo Installer has just finished.
echo Start game with following Command:
echo WINEPREFIX=~/.EA32 wine "C:/Program Files (x86)/Origin/Origin.exe"
echo Good Luck and Have Fun!
echo "###################################################"
