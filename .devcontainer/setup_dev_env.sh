#!/bin/bash

# Set up locales
echo "Generating locales..."
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales
update-locale LANG=en_US.UTF-8

# Install cpanm and latexindent dependencies
echo "Installing Perl modules..."
curl -L http://cpanmin.us | perl - --self-upgrade
cpanm Log::Dispatch::File YAML::Tiny File::HomeDir

# Install Gum tool
echo "Installing Gum tool..."
mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list
apt update && apt install gum

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
echo "y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Setup complete!"
