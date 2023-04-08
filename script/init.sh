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
  # TODO vim & zsh setting

# Linux
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  RELEASE_FILE=/etc/os-release
  # Ubuntu
  if grep '^NAME="Ubuntu' "${RELEASE_FILE}" >/dev/null; then
    echo 'Start setup UbuntuOS'
    # TODO support UbuntuOS
  fi

# 
else
  echo "Your platform is not supported."
  uname -a
  exit 1
fi
