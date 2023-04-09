#!/bin/bash
set -euxo pipefail

# OS Check
# Mac(intel or apple silicon)
if [ "$(uname)" == 'Darwin' ]; then
  echo 'Start setup MacOS'
  # Check for Homebrew
  if test ! $(which brew); then
    echo 'Install Homebrew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  
    echo 'eval' $(/opt/homebrew/bin/brew shellenv) >> $HOME/.zprofile
    eval $(/opt/homebrew/bin/brew shellenv)
  else
    echo "Already installed Homebrew"
  fi

  # Check for xcode command line tool
  if ! xcode-select --print-path &> /dev/null; then
    echo "Install xcode command line tool"
    xcode-select --install
  else
    echo "Already installed xcode command line tool"
  fi

  # Apple silicon
  if [ "$(uname -m)" == 'arm64' ]; then
    # Check for rosetta2
    if [[$(sysctl -n machdep.cpu.brand_string) != *"Apple M"* ]]; then
      echo "Install rosetta2"
      /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    else
      echo "Already installed rosetta2"
    fi
  fi
  brew bundle

# Linux
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  RELEASE_FILE=/etc/os-release
  # Ubuntu
  if grep '^NAME="Ubuntu' "${RELEASE_FILE}" >/dev/null; then
    echo 'Start setup UbuntuOS'
    sudo apt install language-pack-ja
    sudo update-locale LANG=ja_JP.UTF-8
    sudo apt-get install build-essential procps curl file git
    if test ! $(which brew); then
      echo 'Install Homebrew'
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  
      echo 'eval' $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) >> $HOME/.bash_profile
      eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    else
      echo "Already installed Homebrew"
    fi
  fi
  brew bundle
  brew install zsh
  echo 'Change shell to zsh'
  sudo chsh $USER -s $(which zsh)
  echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> $HOME/.zprofile
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  source $HOME/.zprofile

# 
else
  echo "Your platform is not supported."
  uname -a
  exit 1
fi
