#!/bin/zsh

# Install [homebrew](https://brew.sh/)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install all `brew` packages
brew bundle

# Create development workspace, separating work and personal
mkdir -p ~/dev/personal

# Use [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinking dotfiles
stow .

# Install AWS CLI
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "/tmp/AWSCLIV2.pkg"
sudo installer -pkg /tmp/AWSCLIV2.pkg -target /

# Use theme for bat
bat cache --build
