#!/usr/bin/bash

HOMEDIR=/home/$USER
DESCARGAS=$HOMEDIR/Descargas

sudo apt update -y
sudo parrot-upgrade -y
sudo apt install -y build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev libuv1-dev

git clone https://github.com/baskerville/bspwm.git $DESCARGAS/bspwm
git clone https://github.com/baskerville/sxhkd.git $DESCARGAS/sxhkd

(cd $DESCARGAS/bspwm && make && sudo make install)
(cd $DESCARGAS/sxhkd && make && sudo make install)

sudo apt install -y bspwm

mkdir $HOMEDIR/.config/bspwm
mkdir $HOMEDIR/.config/sxhkd
envsubst < ./bspwmrc_template > $HOMEDIR/.config/bspwm/bspwmrc
chmod +x $HOMEDIR/.config/bspwm/bspwmrc
envsubst < ./sxhkdrc_template > $HOMEDIR/.config/sxhkd/sxhkdrc

mkdir $HOMEDIR/.config/bspwm/scripts/
cp ./bspwm_resize $HOMEDIR/.config/bspwm/scripts/
chmod +x $HOMEDIR/.config/bspwm/scripts/bspwm_resize

sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev

git clone --recursive https://github.com/polybar/polybar $DESCARGAS/polybar

mkdir $DESCARGAS/polybar/build
(cd $DESCARGAS/polybar/build && cmake $DESCARGAS/polybar && make -j$(nproc) && sudo make install)

sudo apt update -y
sudo apt install -y meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev

git clone https://github.com/ibhagwan/picom.git $DESCARGAS/picom
(cd $DESCARGAS/picom && git submodule update --init --recursive && meson --buildtype=release . build && ninja -C build && sudo ninja -C build install)

sudo apt install -y rofi

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip -P $DESCARGAS/
sudo unzip $DESCARGAS/Hack.zip -d /usr/share/fonts/
fc-cache -v

mkdir $DESCARGAS/Firefox/

read -n 1 -p "Download last version of Firefox in '$DESCARGAS' folder" input

sudo chown $USER:$USER /opt/
mv $DESCARGAS/firefox* /opt/firefox.tar.gz
tar -xf /opt/firefox.tar.gz -C /opt/
rm /opt/firefox.tar.gz

sudo apt update
sudo apt install -y firejail feh

mkdir $HOMEDIR/Images
cp fondo.jpg $HOMEDIR/Images
cp fondo.png $HOMEDIR/Images

BLUESKY=$DESCARGAS/blue-sky
git clone https://github.com/VaughnValle/blue-sky.git $BLUESKY

mkdir $HOMEDIR/.config/polybar
cp -r ./polybar/* $HOMEDIR/.config/polybar

sudo cp ./polybar/fonts/* /usr/share/fonts/truetype/
fc-cache -v

mkdir $HOMEDIR/.config/picom
cp ./picom.conf $HOMEDIR/.config/picom

cp -r ./bin $HOMEDIR/.config/
chmod +x $HOMEDIR/.config/bin/*

mkdir -p $HOMEDIR/.config/rofi/themes
cp $BLUESKY/nord.rasi $HOMEDIR/.config/rofi/themes
rofi-theme-selector

sudo apt update
sudo apt install -y slim libpam0g-dev libxrandr-dev libfreetype6-dev libimlib2-dev libxft-dev

git clone https://github.com/joelburget/slimlock.git $DESCARGAS/slimlock
(cd $DESCARGAS/slimlock && sudo make && sudo make install)
(cd $BLUESKY/slim && sudo cp slim.conf /etc/ && sudo cp slimlock.conf /etc && sudo cp -r default /usr/share/slim/themes)

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
cp ./.zshrc $HOMEDIR
cp ./.p10k.zsh $HOMEDIR

sudo chown $USER:$USER /root
sudo chown $USER:$USER /root/.cache -R
sudo chown $USER:$USER /root/.local -R

(cd /root && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k && sudo ln -s -f $HOMEDIR/.zshrc .zshrc)
cp ./.p10k_root.zsh /root/.p10k.zsh

usermod --shell /usr/bin/zsh $USER
usermod --shell /usr/bin/zsh root

sudo apt update
sudo apt install -y bat ranger

wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd-musl_0.20.1_amd64.deb -P $DESCARGAS/
sudo dpkg -i $DESCARGAS/lsd-musl_0.20.1_amd64.deb

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install | y


sudo mkdir /usr/share/zsh-plugins/
sudo chown $USER:$USER /usr/share/zsh-plugins
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh -P /usr/share/zsh-plugins/

rm -r $HOMEDIR/.config/nvim
cp -r ./nvim $HOMEDIR/.config
sudo rm -r /root/.config/nvim
sudo cp -r ./nvim /root/.config

git clone https://github.com/gpakosz/.tmux.git $HOMEDIR/.tmux
ln -s -f $HOMEDIR/.tmux/.tmux.conf
cp $HOMEDIR/.tmux/.tmux.conf.local $HOMEDIR

sudo git clone https://github.com/gpakosz/.tmux.git /root/.tmux
sudo ln -s -f /root/.tmux/.tmux.conf
sudo cp /root/.tmux/.tmux.conf.local /root

mkdir $HOMEDIR/tools
wget "https://github.com/diego-treitos/linux-smart-enumeration/raw/master/lse.sh" -P $HOMEDIR/tools
chmod +x $HOMEDIR/tools/lse.sh

