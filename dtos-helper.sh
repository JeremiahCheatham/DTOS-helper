#!/bin/fish

# aur reddio openarena unvanquished xonotic brave lbry mailspring zoom deadbeef archlinux-tweak-tool
# sudo pacman -S --needed breeze breeze-gtk kde-gtk-config plasma-framework

clear
echo "   --------- DTOS Helper 1.5 ---------"
echo "1  Run all DTOS Fixes."
echo "2  Reset DTOS from /etc/dtos folder."
echo "   --------- ArchLinux Fixes ---------"
echo "10 Let sudo use wheel group."
echo "11 Enable ParallelDownloads."
echo "12 Install git, nano, neovim, ntfs-3g and pacman-contrib."
echo "13 Configure lz4 zram with double size."
echo "14 Disable annoying pcspkr beeps."
echo "   ----------- DTOS Fixes ------------"
echo "20 Install missing packages."
echo "21 Fix volumeicon & missing alsa-utils."
echo "22 Enable bluetooth with blueman-applet."
echo "23 Enable Backlight keys with flashText."
echo "24 Adding flashText support for amixer."
echo "25 Enable notification-daemon."
echo "26 Touchpad support with Naturalscrolling."
echo "27 Set Firefox as default browser."
echo "28 Fix dm-translate typo & switch to lingva."
echo "29 Fix dm-colpick typo."
echo "   ------- GridSelect Menu Apps ------"
echo "30 Install needed Games packages."
echo "31 Install needed Education packages."
echo "32 Install needed Internet packages."
echo "33 Install needed Multimedia packages."
echo "34 Install needed Office packages."
echo "35 Install needed Settings packages."
echo "36 Install needed System packages."
echo "37 Install needed Utilities packages."
echo "   -------------- Other ----------------"
echo "40 Use pulseaudio for extended volume."
echo "41 Disable NaturalScrolling direction."
echo "42 Fix tearing for amd gpus."
echo "43 Fix tearing for intel gpus."
echo ""
echo "50 Quit"

read CHOICE
echo ""

if [ ! $CHOICE ]
    set CHOICE 0
    echo "Choose a number between 1 and 50."
end

################################# Archlinux ######################################

if [ $CHOICE -eq 2 ]
    # Reset DTOS from /etc/dtos.
    echo "Resetting DTOS from /etc/dtos folder."
    /bin/cp -r /etc/dtos/.* $HOME/
end

if [ $CHOICE -eq 10 ]
    # let /etc/sudoers and wheel handle permission.
    if sudo grep -R "^%wheel ALL=(ALL:ALL) NOPASSWD" /etc/sudoers > /dev/null
        echo "Cool NOPASSWD for wheel enabled."
    else
        echo "Enabling NOPASSWD for wheel group."
        sudo sed -i 's/# %wheel ALL=(ALL:ALL) NOPASSWD/%wheel ALL=(ALL:ALL) NOPASSWD/' /etc/sudoers
    end
    if sudo grep -R "^%wheel ALL=(ALL:ALL) NOPASSWD" /etc/sudoers > /dev/null
        if sudo ls /etc/sudoers.d/00_$USER > /dev/null 2>&1
            echo "Removing old /etc/sudoers.d/00_$USER file."
            sudo rm /etc/sudoers.d/00_$USER
        else
            echo "Cool /etc/sudoers.d/00_$USER file already removed."
        end
    end
end

if [ $CHOICE -eq 11 ]
    # Check ParallelDownloads is enabled.
    if grep -R "^ParallelDownloads" /etc/pacman.conf > /dev/null
        echo "Cool ParallelDownloads is already enabled."
    else
        echo "Enabling ParallelDownloads."
        sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
    end
end

if [ $CHOICE -eq 12 ]
    # install missing archlinux packages.
    echo "Installing missing archlinux packages."
    sudo pacman -S --needed git nano neovim ntfs-3g pacman-contrib
    echo
end

if [ $CHOICE -eq 13 ]
    # Configure zram with lz4 compression and double ram size.
    if grep "ram \* 2" /etc/systemd/zram-generator.conf > /dev/null 2>&1
        echo "Cool zram-generator.conf already configured."
    else
        echo "Generating zram-generator.conf."
        sudo bash -c "cat << EOF > /etc/systemd/zram-generator.conf
[zram0]
compression-algorithm = lz4
zram-size = ram * 2
EOF"
        sudo systemctl restart systemd-zram-setup@zram0.service
    end
end

if [ $CHOICE -eq 14 ]
    # Prevent pcspkr beeping
    if grep -R "blacklist pcspkr" /etc/modprobe.d/nobeep.conf > /dev/null 2>&1
        echo "Cool pcspkr is already blacklisted."
    else
        echo "blacklisting pcspkr and removing kernel module."
        sudo rmmod pcspkr 2> /dev/null
        sudo bash -c 'echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf'
    end
end

##################################### DTOS #####################################

if [ $CHOICE -eq 20 ] || [ $CHOICE -eq 1 ]
    # Make sure missing packages are installed.
    sudo pacman -S --needed alsa-utils moc pass qt5ct youtube-dl man-db breeze breeze-gtk kde-gtk-config xarchiver
    echo
end

if [ $CHOICE -eq 21 ] || [ $CHOICE -eq 1 ]
    # Fix volumeicon and alsa-utils

    # Make sure alsa-utils is installed.
    if pacman -Q alsa-utils > /dev/null 2>&1
        echo "Cool alsa-utils is already installed."
    else
        echo "Installing alsa-utils."
        sudo pacman -S alsa-utils
	echo
    end
    
    # Make sure if pipewire-pulse is installed enable it.
    if pacman -Q pipewire-pulse | grep "pipewire-pulse" >/dev/null
        echo "Making sure pipewire-pulse is enabled."
        systemctl --user enable pipewire-pulse --now
    end
    
    # volumeicon needs a time out to start.
    if grep -R "sleep 2 && volumeicon" $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool volumeicon already fixed."
    else
        echo "Fixing volumeicon. You will need a reboot."
        sudo sed -i 's/"volumeicon"/"sleep 2 \&\& volumeicon"/' $HOME/.config/xmonad/xmonad.hs
    end
end


if [ $CHOICE -eq 22 ] || [ $CHOICE -eq 1 ]
    #Enable bluetooh support.

    # Make sure blueman is installed.
    if pacman -Q blueman > /dev/null 2>&1
        echo "Cool blueman is already installed."
    else
        echo "Installing blueman."
        sudo pacman -S blueman
	echo
    end

    echo "Enabling bluetooth service."
    sudo systemctl enable bluetooth
    sudo systemctl start bluetooth

    if sudo ls /etc/polkit-1/rules.d/51-blueman.rules > /dev/null 2>&1
        echo "Cool 51-blueman.rules already exist."
    else
        sudo bash -c 'cat << EOF > /etc/polkit-1/rules.d/51-blueman.rules
/* Allow users in wheel group to use blueman feature requiring root without authentication */
polkit.addRule(function(action, subject) {
    if ((action.id == "org.blueman.network.setup" ||
         action.id == "org.blueman.dhcp.client" ||
         action.id == "org.blueman.rfkill.setstate" ||
         action.id == "org.blueman.pppd.pppconnect") &&
        subject.isInGroup("wheel")) {

        return polkit.Result.YES;
    }
});
EOF'
    end
    if grep -R "blueman-applet" $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool blueman-applet already enabled."
    else
        echo "Enabling blueman-applet. You will need a reboot."
        sed -i '/^  spawnOnce "nm-applet"/a\  spawnOnce "blueman-applet"' $HOME/.config/xmonad/xmonad.hs
    end
end

if [ $CHOICE -eq 23 ] || [ $CHOICE -eq 24 ] || [ $CHOICE -eq 1 ]
    if not grep -R "XMonad.Actions.ShowText" $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Enabling XMonad.Actions.ShowText."
        sed -i '/XMonad.Actions.Search/a import XMonad.Actions.ShowText' $HOME/.config/xmonad/xmonad.hs
    else
        echo "Cool XMonad.Actions.ShowText already enabled."
    end
    if not grep -R "Data.Maybe" $HOME/.config/xmonad/xmonad.hs | grep "fromMaybe" > /dev/null
        echo "Adding fromMaybe to Data.Maybe."
        sed -i 's/import Data.Maybe (/import Data.Maybe (fromMaybe, /' $HOME/.config/xmonad/xmonad.hs
    else
        echo "Cool fromMaybe found in Data.Maybe."
    end
    if not grep -R "XMonad.Util.Loggers" $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Enabling XMonad.Util.Loggers."
        sed -i '/XMonad.Util.SpawnOnce/a import XMonad.Util.Loggers (logCmd)' $HOME/.config/xmonad/xmonad.hs
    else
        echo "Cool XMonad.Util.Loggers already enabled."
    end
    if not grep -R "Theme for showText which prints messages." $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Adding Theme for showText."
        sed -i '/-- The layout hook/i -- Theme for showText which prints messages.' $HOME/.config/xmonad/xmonad.hs
        sed -i '/-- The layout hook/i myTextConfig :: ShowTextConfig' $HOME/.config/xmonad/xmonad.hs
        sed -i '/-- The layout hook/i myTextConfig = STC' $HOME/.config/xmonad/xmonad.hs
        if grep -R "swn_font" $HOME/.config/xmonad/xmonad.hs | grep "Ubuntu" > /dev/null
            sed -i '/-- The layout hook/i \    { st_font               = "xft:Ubuntu:bold:size=60"' $HOME/.config/xmonad/xmonad.hs
        else
            sed -i '/-- The layout hook/i \    { st_font               = "xft:Noto Sans:bold:size=60"' $HOME/.config/xmonad/xmonad.hs
        end
        sed -i '/-- The layout hook/i \    , st_bg                 = "#1c1f24"' $HOME/.config/xmonad/xmonad.hs
        sed -i '/-- The layout hook/i \    , st_fg                 = "#ffffff"' $HOME/.config/xmonad/xmonad.hs
        sed -i '/-- The layout hook/i \    }' $HOME/.config/xmonad/xmonad.hs
        sed -i '/-- The layout hook/i \ ' $HOME/.config/xmonad/xmonad.hs
    else
        echo "Cool showText Theme found."
    end
    if not grep -R "handleTimerEvent" $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Adding handleTimerEvent to handleEventHook."
        sed -i '/--, handleEventHook    = docks/a\    , handleEventHook    = handleTimerEvent' $HOME/.config/xmonad/xmonad.hs > /dev/null
    else
        echo "Cool handleTimerEvent found in handleEventHook."
    end
end

if [ $CHOICE -eq 23 ] || [ $CHOICE -eq 1 ]
    # Make sure light is installed.
    if pacman -Q light > /dev/null 2>&1
        echo "Cool light is already installed."
    else
        echo "Installing light."
        sudo pacman -S light
	echo
    end

    # You need to be in Video group for light to change screen brightness.
    if groups | grep video > /dev/null
        echo "Cool you're already in the video group."
    else
        echo "Adding you to video group. A restart will be needed."
        sudo usermod -a -G video $USER
    end

    # Add keybindings for screen brightness.
    if grep -R '"<XF86MonBrightnessDown>", addName "light down"' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool XF86MonBrightnessDown is already in xmonad.hs."
    else
        echo "Adding XF86MonBrightnessDown to xmonad.hs"
        sed -i '/"<XF86MonBrightnessDown>"/d' $HOME/.config/xmonad/xmonad.hs
        sed -i '/  , ("<Print>", addName "Take screenshot (dmscripts)" $ spawn "dm-maim")/a\  , ("<XF86MonBrightnessDown>", addName "light down"  $ logCmd "light -U 5 && printf \' %.0f%% \' $(light -G)" >>= flashText myTextConfig 1 . fromMaybe "")' $HOME/.config/xmonad/xmonad.hs
    end
    if grep -R '"<XF86MonBrightnessUp>", addName "light up"' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool XF86MonBrightnessUp is already in xmonad.hs."
    else
        echo "Adding XF86MonBrightnessUp to xmonad.hs"
        sed -i '/"<XF86MonBrightnessUp>"/d' $HOME/.config/xmonad/xmonad.hs
        sed -i '/  , ("<Print>", addName "Take screenshot (dmscripts)" $ spawn "dm-maim")/a\  , ("<XF86MonBrightnessUp>", addName "light up"      $ logCmd "light -A 5 && printf \' %.0f%% \' $(light -G)" >>= flashText myTextConfig 1 . fromMaybe "")' $HOME/.config/xmonad/xmonad.hs
    end
end

if [ $CHOICE -eq 24 ] || [ $CHOICE -eq 1 ]
    # Add flashText support for volume.

    if grep -R 'logCmd "printf \' %s \' $(amixer set Master 5%+' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool amixer volume raise with flashText already patched."
    else
        echo "Patching amixer volume raise with flashText."
        sed -i '/"<XF86AudioRaiseVolume>"/d' $HOME/.config/xmonad/xmonad.hs
        sed -i '/"<XF86AudioNext>"/a\  , ("<XF86AudioRaiseVolume>", addName "Raise vol"    $ logCmd "printf \' %s \' $(amixer set Master 5%+ unmute | grep \'Right:\' | awk -F\'[][]\' \'{ print $2 }\')" >>= flashText myTextConfig 1 . fromMaybe "")' $HOME/.config/xmonad/xmonad.hs
    end

    if grep -R 'logCmd "printf \' %s \' $(amixer set Master 5%-' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool amixer volume lower with flashText already patched."
    else
        echo "Patching amixer volume lower with flashText."
        sed -i '/"<XF86AudioLowerVolume>"/d' $HOME/.config/xmonad/xmonad.hs
        sed -i '/"<XF86AudioNext>"/a\  , ("<XF86AudioLowerVolume>", addName "Lower vol"    $ logCmd "printf \' %s \' $(amixer set Master 5%- unmute | grep \'Right:\' | awk -F\'[][]\' \'{ print $2 }\')" >>= flashText myTextConfig 1 . fromMaybe "")' $HOME/.config/xmonad/xmonad.hs
    end

    if grep -R 'logCmd "amixer set Master toggle' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool amixer mute with flashText already patched."
    else
        echo "Patching amixer mute with flashText."
        sed -i '/"<XF86AudioMute>"/d' $HOME/.config/xmonad/xmonad.hs
        sed -i '/"<XF86AudioNext>"/a\  , ("<XF86AudioMute>", addName "Toggle audio mute"   $ logCmd "amixer set Master toggle | grep \'off\' > /dev/null && echo \' Mute \' || echo \' Unmute \'" >>= flashText myTextConfig 1 . fromMaybe "")' $HOME/.config/xmonad/xmonad.hs
    end
end

if [ $CHOICE -eq 25 ] || [ $CHOICE -eq 1 ]
    # Make sure notification-daemon is installed.
    if pacman -Q notification-daemon | grep notification-daemon > /dev/null 2>&1
        echo "Cool notification-daemon is already installed."
    else
        echo "Installing notification-daemon."
        sudo pacman -S notification-daemon
	echo
    end

    # Launch notification-daemon
    if grep -R "/usr/lib/notification-daemon-1.0/notification-daemon" $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool notification-daemon is already in xmonad.hs."
    else
        echo "Adding notification-daemon to xmonad.hs. You will need a reboot."
        sed -i '/spawnOnce "picom"/i\  spawnOnce "/usr/lib/notification-daemon-1.0/notification-daemon"' $HOME/.config/xmonad/xmonad.hs
    end
end

if [ $CHOICE -eq 26 ] || [ $CHOICE -eq 1 ]
    # Add touch pad support with tapping and NaturalScrolling.
    echo "Generate /etc/X11/xorg.conf.d/30-touchpad.conf"
    sudo bash -c 'cat << EOF > /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lrm"
    Option "NaturalScrolling" "true"
EndSection
EOF'
end

if [ $CHOICE -eq 27 ] || [ $CHOICE -eq 1 ]
    # Make sure firefox is installed.
    if pacman -Q firefox > /dev/null 2>&1
        echo "Cool firefox is already installed."
    else
        echo "Installing firefox."
        sudo pacman -S firefox
    end

    # Make sure firefox is the default browser.
    if grep -R 'myBrowser = "qutebrowser "' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Replacing qutebrowser with firefox in xmonad.hs"
        sed -i 's/myBrowser = "qutebrowser "/myBrowser = "firefox "/' $HOME/.config/xmonad/xmonad.hs
    else
        echo "Cool firefox already replaced qutebrowser in xmonad.hs"
    end
    if grep -R 'DMBROWSER="qutebrowser"' $HOME/.config/dmscripts/config > /dev/null
        echo "Replacing qutebrowser with firefox in dmscripts"
        sed -i 's/DMBROWSER="qutebrowser"/DMBROWSER="firefox"/' $HOME/.config/dmscripts/config
    else
        echo "Cool firefox already replaced qutebrowser in dmscripts"
    end
end

if [ $CHOICE -eq 28 ] || [ $CHOICE -eq 1 ]
    # Patch for dm-translate
    if grep -R '^translate_service="libre"' $HOME/.config/dmscripts/config > /dev/null
        echo 'Fixing typo translate_service="libra" & switching to lingva'
        sed -i 's/^translate_service="libre"/# translate_service="libretranslate"/' $HOME/.config/dmscripts/config
        sed -i 's/# translate_service="lingva"/translate_service="lingva"/' $HOME/.config/dmscripts/config
    else
        echo 'Cool libre typo fixed and switched to lingva'
    end
end

if [ $CHOICE -eq 29 ] || [ $CHOICE -eq 1 ]
    # Patch for dm-colpick
    if grep -R '"M-p C"' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo 'Fixing typo "M-p C" to "M-p S-c" in dm-colpick'
        sed -i 's/"M-p C"/"M-p S-c"/' $HOME/.config/xmonad/xmonad.hs
    else
        echo 'Cool "M-p C" typo in xmonad.h already fixed.'
    end
end

############################# GridSelect Menu Apps ##############################

if [ $CHOICE -eq 30 ]
    # Install missing Game GridSelect Menu packages.

    if grep -R '"OpenArena"' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo 'Replacing AUR OpenArena for HedgeWars'
        sed -i 's/"OpenArena", "openarena"/"Hedgewars", "hedgewars"/' $HOME/.config/xmonad/xmonad.hs
    else
        echo 'Cool Hedgewars already replaced AUR OpenArena.'
    end

    if grep -R '"Unvanquished"' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo 'Replacing AUR Unvanquished for MegaGlest'
        sed -i 's/"Unvanquished", "unvanquished"/"MegaGlest", "megaglest"/' $HOME/.config/xmonad/xmonad.hs
    else
        echo 'Cool MegaGlest already replaced AUR Unvanquished.'
    end

    if grep -R '"Xonotic"' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo 'Replacing AUR Xonotic for SuperTuxKart'
        sed -i 's/"Xonotic", "xonotic-glx"/"SuperTuxKart", "supertuxkart"/' $HOME/.config/xmonad/xmonad.hs
    else
        echo 'Cool SuperTuxKart already replaced AUR Xonotic.'
    end

    if grep -R '"sauerbraten"' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo 'Replacing "sauerbraten" with "sauerbraten-client".'
        sed -i 's/"sauerbraten"/"sauerbraten-client"/' $HOME/.config/xmonad/xmonad.hs
    else
        echo 'Cool "sauerbraten-client" already replaced "sauerbraten".'
    end

    # Steam requires multilib enabled.
    if grep "^\[multilib\]" /etc/pacman.conf > /dev/null
        sudo pacman -S --needed 0ad hedgewars megaglest sauerbraten supertuxkart steam wesnoth
    else
        echo '[multilib] needs to be enabled in /etc/pacman.conf to install steam.'
        set ANSWER "0"
        while [ $ANSWER != "y" ] && [ $ANSWER != "n" ]
            echo "Would you like to enable multilib and install steam? y/n"
            read ANSWER
            echo ""
        end
        if [ $ANSWER = "y" ]
            echo "Enabling multilib."
            sudo sed -i 's/#\[multilib\]/\[multilib\]/' /etc/pacman.conf
            sudo sed -i "\|\[multilib\]|aInclude = /etc/pacman.d/mirrorlist" /etc/pacman.conf
            sudo pacman -Sy
            sudo pacman -S --needed 0ad hedgewars megaglest sauerbraten supertuxkart steam wesnoth
        else
            sudo pacman -S --needed 0ad hedgewars megaglest sauerbraten supertuxkart wesnoth
        end
    end
end

if [ $CHOICE -eq 31 ]
    # Install missing Education GridSelect Menu packages.
    sudo pacman -S --needed gcompris-qt kstars minuet

    if grep -R '"scratch"' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo 'Scratch 1.4 is deprecated and broken. Replace with scratch.mit.edu.'
        sed -i 's/"scratch"/(myBrowser ++ " https:\/\/scratch.mit.edu")/' $HOME/.config/xmonad/xmonad.hs
    else
        echo 'Cool scratch already replaced with scratch.mit.edu.'
    end
end

if [ $CHOICE -eq 32 ]
    # Install missing Internet GridSelect Menu packages. AUR brave lbry mailspring zoom
    sudo pacman -S --needed discord element-desktop firefox nextcloud qutebrowser transmission-gtk
end

if [ $CHOICE -eq 33 ]
    # Install missing Multimedia GridSelect Menu packages.
    sudo pacman -S --needed audacity blender kdenlive obs-studio vlc
end

if [ $CHOICE -eq 34 ]
    # Install missing Office GridSelect Menu packages.
    sudo pacman -S --needed evince libreoffice-fresh
end

if [ $CHOICE -eq 35 ]
    # Install missing Settings GridSelect Menu packages.
    sudo pacman -S --needed arandr lxappearance sudo gufw
end

if [ $CHOICE -eq 36 ]
    # Install missing System GridSelect Menu packages.
    sudo pacman -S --needed alacritty pcmanfm virtualbox virtualbox-host-modules-arch virt-manager
end

if [ $CHOICE -eq 37 ]
    # Install missing Utilities GridSelect Menu packages.
    sudo pacman -S --needed emacs nitrogen
end

##################################### Other #####################################

if [ $CHOICE -eq 40 ]
    # Switch alsa for pulseaudio keybindings.
    if pacman -Q pulseaudio > /dev/null 2>&1
        echo "Cool pulseaudio or pipewire-pulse already installed."
    else
        sudo pacman -S pipewire-pulse
        systemctl --user enable pipewire-pulse --now
    end
    if grep -R 'pactl -- set-sink-volume @DEFAULT_SINK@ +5' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool pactl -- set-sink-volume @DEFAULT_SINK@ +5% is already in xmonad.hs."
    else
        echo "Adding pactl -- set-sink-volume @DEFAULT_SINK@ +5% to xmonad.hs"
        sed -i '/"<XF86AudioRaiseVolume>"/d' $HOME/.config/xmonad/xmonad.hs
        sed -i '/"<XF86AudioNext>"/a\  , ("<XF86AudioRaiseVolume>", addName "Raise vol"    $ logCmd "printf \' %s \' $(pactl -- set-sink-volume @DEFAULT_SINK@ +5% && pactl -- get-sink-volume @DEFAULT_SINK@ | grep -o \'[0-9]*%\' | head -1)" >>= flashText myTextConfig 1 . fromMaybe "")' $HOME/.config/xmonad/xmonad.hs
    end
    if grep -R 'pactl -- set-sink-volume @DEFAULT_SINK@ -5%' $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool pactl -- set-sink-volume @DEFAULT_SINK@ -5% is already in xmonad.hs."
    else
        echo "Adding pactl -- set-sink-volume @DEFAULT_SINK@ -5% to xmonad.hs"
        sed -i '/"<XF86AudioLowerVolume>"/d' $HOME/.config/xmonad/xmonad.hs
        sed -i '/"<XF86AudioNext>"/a\  , ("<XF86AudioLowerVolume>", addName "Lower vol"    $ logCmd "printf \' %s \' $(pactl -- set-sink-volume @DEFAULT_SINK@ -5% && pactl -- get-sink-volume @DEFAULT_SINK@ | grep -o \'[0-9]*%\' | head -1)" >>= flashText myTextConfig 1 . fromMaybe "")' $HOME/.config/xmonad/xmonad.hs
    end
end

if [ $CHOICE -eq 41 ]
    # Disable NaturalScrolling direction.
    if [ -f /etc/X11/xorg.conf.d/30-touchpad.conf ]
        echo "Setting NaturalScrolling to false."
        sudo sed -i 's/"NaturalScrolling" "true"/"NaturalScrolling" "false"/' /etc/X11/xorg.conf.d/30-touchpad.conf
    else
        echo "TouchPad config file not found. Generate it first."
    end
end

if [ $CHOICE -eq 42 ]
    # Fix tearing for amd gpus.
    echo "Generate /etc/X11/xorg.conf.d/20-amdgpu.conf."
    sudo bash -c 'cat << EOF > /etc/X11/xorg.conf.d/20-amdgpu.conf
Section "Device"
    Identifier "AMD"
    Driver "amdgpu"
    Option "EnablePageFlip" "on"
    Option "TearFree" "true"
EndSection
EOF'
    echo "You may need to reboot to see changes."
end

if [ $CHOICE -eq 43 ]
    # Fix tearing for intel gpus.
    echo "Generate /etc/X11/xorg.conf.d/20-intel.conf."
    sudo bash -c 'cat << EOF > /etc/X11/xorg.conf.d/20-intel.conf
Section "Device"
    Identifier "Intel Graphics"
    Driver "intel"
    Option "TearFree" "true"
    Option "TripleBuffer" "true"
EndSection
EOF'
    echo "You may need to reboot to see changes."
end

if [ $CHOICE -eq 1 ] || [ $CHOICE -eq 23 ] || [ $CHOICE -eq 24 ] || [ $CHOICE -eq 27 ] || [ $CHOICE -eq 29 ] || [ $CHOICE -eq 40 ]
    xmonad --restart
end

if [ $CHOICE -eq 50 ]
    # Exit script.
    exit
end

echo ""
echo "Press any key to continue."
read
fish (status filename) && exit
