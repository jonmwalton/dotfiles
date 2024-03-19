sudo dnf copr enable alebastr/sway-extras

swww
hyprland
stow
default-fonts
ImageMagick
python3-pip
swayidle
wlogout
codium
gtk-murrine-engine
pulseaudio
fontawesome-fonts

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
