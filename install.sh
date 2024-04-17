
#!/bin/bash

install_package() {
  # Checking if package is already installed
  if sudo dnf list installed "$1" &>> /dev/null ; then
    echo -e "${OK} $1 is already installed. Skipping..."
  else
    # Package not installed
    echo -e "${NOTE} Installing $1 ..."
    sudo dnf install -y --allowerasing "$1" 2>&1 | tee -a "$LOG"
    # Making sure package is installed
    if sudo dnf list installed "$1" &>> /dev/null ; then
      echo -e "\e[1A\e[K${OK} $1 was installed."
    else
      # Something is missing, exiting to review log
      echo -e "\e[1A\e[K${ERROR} $1 failed to install :( , please check the install.log. You may need to install manually! Sorry I have tried :("
      exit 1
    fi
  fi
}

# Set the name of the log file to include the current date and time
LOG="install-$(date +%d-%H%M%S).log"

sudo dnf copr enable -y solopasha/hyprland
sudo dnf copr enable -y erikreider/SwayNotificationCenter
sudo dnf copr enable -y tofik/nwg-shell
#sudo dnf copr enable eddsalkield/swaylock-effects
#sudo dnf copr enable tiritor/waybar #includes cava support
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo

sudo dnf update -y

packages=(
    blueman
    SwayNotificationCenter
    hyprland
    waybar-git
    #hyprlock
    #hypridle
    swayidle
    hyprpaper
    stow
    default-fonts
    ImageMagick
    python3-pip
    wlogout
    codium
    gtk-murrine-engine
    pipewire-alsa
    fontawesome-fonts
    htop
    xarchiver
    lxpolkit
    pavucontrol
    network-manager-applet
    rofi-wayland
    nwg-displays
    nwg-look
    swaylock-effects
    thunar
    neofetch
    sddm
    sox
)

for PKG1 in "${packages[@]}"; do
  install_package "$PKG1" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 install had failed, please check the install.log"
    exit 1
  fi
done

sudo systemctl enable sddm.service
sudo systemctl set-default graphical.target

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
mkdir -p ~/.local/share/fonts/JetBrainsMonoNerd
tar -xJkf JetBrainsMono.tar.xz -C ~/.local/share/fonts/JetBrainsMonoNerd
fc-cache -v

pip3 install pywal
wal -i ~/dotfiles/wallpaper/

cd ~
git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
./install

cd ~
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
./install
