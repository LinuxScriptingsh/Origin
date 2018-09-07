#!/bin/bash

help() {
  echo -e "  -i, --install\t\t\t Installs the software"
  echo -e "  -u, --update\t\t\t Updates the software"
}

install() {
  echo [Origin Install] Removing EA32 Folder
  rm -rf ~/SquareGames/EA32/
  echo [Origin Install] Removing old versions of wine
  pacman -Rns wine-staging --noconfirm
  echo [Origin Install] Updating your System
  pacman -Syu --noconfirm
  echo [Origin Install] Installing wine and additional libraries
  pacman -S wine-staging lib32-libldap lib32-gnutls wget --noconfirm
  echo [Origin Install] Downloading winetricks
  wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
  chmod +x winetricks
  mkdir ~/SquareGames
  mkdir ~/SquareGames/EA32
  WINEPREFIX=~/SquareGames/EA32 WINEARCH=win32 wine
  echo [Origin Install] Installing Visual C++ 2010
  WINEPREFIX=~/SquareGames/EA32 ./winetricks vcrun2010
  echo [Origin Install] Installing Visual C++ 2013
  WINEPREFIX=~/SquareGames/EA32 ./winetricks vcrun2013
  echo [Origin Install] Installing Visual C++ 2017
  WINEPREFIX=~/SquareGames/EA32 ./winetricks vcrun2017
  echo [Origin Install] Installing DirecX9
  WINEPREFIX=~/SquareGames/EA32 ./winetricks d3dx9
  WINEPREFIX=~/SquareGames/EA32 wine winecfg
  echo [Origin Install] Downloading OriginThinSetup.exe
  wget https://origin-a.akamaihd.net/Origin-Client-Download/origin/live/OriginThinSetup.exe
  WINEPREFIX=~/SquareGames/EA32 wine OriginThinSetup.exe
  echo [Origin Install] Removing OriginThinSetup.exe
  rm -rf OriginThinSetup.exe
  echo [Origin Install] Removing winetricks
  rm -rf winetricks
}

update() {
  echo [Origin Install] Installing git
  pacman -S git --noconfirm
  echo [Origin Install] Cloning wine-origin-updater from DrDoctor13
  git clone https://github.com/DrDoctor13/wine-origin-updater.git && cd wine-origin-updater
  echo [Origin Install] Executing Updatescript with used Wineprefix
  WINEPREFIX=~/SquareGames/EA32 ./updateorigin.sh && cd ..
  echo [Origin Install] Removing wine-origin-updater
  rm -rf wine-origin-updater
}

if [[ $EUID -ne 0 ]]; then
  echo [Origin Install] Script only excecuteable with root.
else
  if [[ $1 = "-i" || $1 = "--install" ]]; then
    install
  elif [[ $1 = "-u" || $1 = "--update" ]]; then
    update
  elif [[ $1 = "--help" ]]; then
    help
  else
    echo Type $0 --help for more information
  fi
fi
