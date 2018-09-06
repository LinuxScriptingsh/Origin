#!/bin/bash

FILE=origin

help() {
  echo -e "  -i, --install\t\t\t Installs the software"
  echo -e "  -u, --update\t\t\t Updates the software"
}

install() {
  rm -rf ~/SquareGames/EA32/
  sudo pacman -Rns wine-staging --noconfirm
  sudo pacman -Syu --noconfirm
  sudo pacman -S wine-staging lib32-libldap lib32-gnutls wget --noconfirm
  wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
  chmod +x winetricks
  mkdir ~/SquareGames
  mkdir ~/SquareGames/EA32
  WINEPREFIX=~/SquareGames/EA32 WINEARCH=win32 wine
  WINEPREFIX=~/SquareGames/EA32 ./winetricks vcrun2010
  WINEPREFIX=~/SquareGames/EA32 ./winetricks vcrun2013
  WINEPREFIX=~/SquareGames/EA32 ./winetricks vcrun2017
  WINEPREFIX=~/SquareGames/EA32 ./winetricks d3dx9
  WINEPREFIX=~/SquareGames/EA32 wine winecfg
  wget https://origin-a.akamaihd.net/Origin-Client-Download/origin/live/OriginThinSetup.exe
  WINEPREFIX=~/SquareGames/EA32 wine OriginThinSetup.exe
  rm -rf OriginThinSetup.exe
  rm -rf winetricks
}

update() {
  sudo pacman -S git --noconfirm
  git clone https://github.com/DrDoctor13/wine-origin-updater.git && cd wine-origin-updater
  WINEPREFIX=~/SquareGames/EA32 ./updateorigin.sh && cd ..
  rm -rf wine-origin-updater
}

if [[ $1 = "-i" || $1 = "--install" ]]; then
  install
elif [[ $1 = "-u" || $1 = "--update" ]]; then
  update
elif [[ $1 = "--help" ]]; then
  help
else
  echo Type ./$FILE.sh --help for more information
fi
