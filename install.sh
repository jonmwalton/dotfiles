
sudo dnf copr enable solopasha/hyprland
sudo dnf copr enable erikreider/SwayNotificationCenter

swww
SwayNotificationCenter
hyprland
hyprlock
hypridle
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
