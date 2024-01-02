#!/bin/fish

clear
echo "   ---------- DTOS Theme 1.6 ----------"
echo "1  1080x1920 14in Font/Theme Preset."
echo "2  768x1366 14in Fonts/Theme Preset."
echo "3  Reset DTOS from /etc/dtos folder."
echo "   -------- THEME & FONT SETUP --------"
echo "10 Install full set of fonts."
echo "11 Install Theme addons for QT, GTK2/3/4."
echo "12 Create config files for QT, GTK2/3/4."
echo "13 Set Systems fonts to Noto Sans & Hack"
echo "14 Switch Adwaita to breeze_cursors."
echo "15 Let qt5ct handle QT themes."
echo "16 Remove Notify, Kernel, Uptime from Xmobar." 
echo "17 Set Trayer Size to 24."
echo "   ----------- CHANGE CONKY -----------"
echo "20 Switch to Advanced Conky."
echo "21 Advanced Conky with Hotkeys."
echo "22 Switch to Original Conky."
echo "   ------- CHANGE QT/GTK THEME --------"
echo "30 Set Doom One Theme."
echo "31 Set Doom Dracula Theme."
echo "32 Set Doom Gruvbox Theme."
echo "33 Set Doom Monokai Pro Theme."
echo "34 Set Doom Nord Theme."
echo "35 Set Doom Oceanic Next Theme."
echo "36 Set Doom Palenight Theme."
echo "37 Set Doom Solarized Dark Theme."
echo "38 Set Doom Tomorrow Night Theme."
echo "   -------- CHANGE FONTS SIZE ---------"
echo "40 Increase Xmobar/Dmenu font size."
echo "41 Decrease Xmobar/Dmenu font size."
echo "42 Increase Conky font size."
echo "43 Decrease Conky font size."
echo "44 Set the Systems font size."
echo "45 Set the Console font size."
echo "   -------------- QUIT ----------------"
echo "50 Quit"

read CHOICE
echo ""

if [ ! $CHOICE ]
    set CHOICE 0
    echo "Choose a number between 1 and 50."
end

if [ $CHOICE -eq 1 ]
    # Preset for 1080x1920 14inch
    set NEWFONTSIZE 14
    set NEW_XMOBAR_SIZE 12
    set CFONTSIZE1 11
    set VCFONTSIZE 24
end

if [ $CHOICE -eq 2 ]
    # Preset for 768x1366 14inch
    set NEWFONTSIZE 10
    set NEW_XMOBAR_SIZE 9
    set CFONTSIZE1 8
    set VCFONTSIZE 18
end

if [ $CHOICE -eq 3 ]
    # Reset DTOS from /etc/dtos.
    echo "Resetting DTOS from /etc/dtos folder."
    /bin/cp -r /etc/dtos/.* $HOME/
    /bin/cp $HOME/.config/xmonad/xmonad-example-configs/xmonad-with-xmobar.hs $HOME/.config/xmonad/xmonad.hs
end

if [ $CHOICE -eq 10 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    # Install full set of fonts.
    echo "Installing a full set of fonts."
    sudo pacman -S --needed adobe-source-sans-pro-fonts adobe-source-code-pro-fonts gnu-free-fonts ttf-hack noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-roboto
end

if [ $CHOICE -eq 11 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    # Install added themes for QT, GTK2, GKT3 and GTK4
    echo "Install breeze and breeze-gtk."
    sudo pacman -S --needed breeze breeze-gtk kde-gtk-config plasma-framework5
    if [ ! -d $HOME/.config/conky/xmonad ]
        mkdir -p $HOME/.config/conky/xmonad
    end
    echo "Copying contents of conky to $HOME/.config/conky/xmonad"
    /bin/cp -f conky/* $HOME/.config/conky/xmonad
    if [ ! -d $HOME/.local/bin ]
        mkdir -p $HOME/.local/bin
    end
    echo "Copying contents of bin to $HOME/.local/bin"
    /bin/cp -f bin/* $HOME/.local/bin
    if [ ! -d $HOME/.local/share/color-schemes ]
        mkdir -p $HOME/.local/share/color-schemes
    end
    echo "Copying contents of color-schemes to $HOME/.local/share/color-schemes"
    /bin/cp -rf color-schemes/* $HOME/.local/share/color-schemes
    if [ ! -d $HOME/.themes ]
        mkdir -p $HOME/.themes
    end
    echo "Copying contents of themes to $HOME/.themes"
    /bin/cp -rf themes/* $HOME/.themes
end

if [ $CHOICE -eq 12 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    # Generate theme configs.

    # Generate KDE theme config.
    echo "Generating KDE theme config."
    /bin/cp /usr/share/plasma/desktoptheme/breeze-dark/colors $HOME/.config/kdeglobals
    sed -i "/\KDE\]/a LookAndFeelPackage=org.kde.breezedark.desktop" $HOME/.config/kdeglobals

    if [ ! -f $HOME/.config/qt5ct/qt5ct.conf ]
    end
    # Qt5ct theme $HOME/.config/qt5ct/qt5ct.conf.
    if [ ! -d $HOME/.config/qt5ct ]
        mkdir $HOME/.config/qt5ct
    end
    echo "Generating qt5ct theme config."
    echo '[Appearance]' > $HOME/.config/qt5ct/qt5ct.conf
    echo 'color_scheme_path=/usr/share/qt5ct/colors/airy.conf' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'custom_palette=false' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'icon_theme=breeze-dark' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'standard_dialogs=default' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'style=Breeze' >> $HOME/.config/qt5ct/qt5ct.conf
    echo '' >> $HOME/.config/qt5ct/qt5ct.conf
    echo '[Interface]' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'activate_item_on_single_click=1' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'buttonbox_layout=0' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'cursor_flash_time=1000' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'dialog_buttons_have_icons=1' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'double_click_interval=400' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'gui_effects=@Invalid()' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'keyboard_scheme=2' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'menus_have_icons=true' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'show_shortcuts_in_context_menus=true' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'stylesheets=@Invalid()' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'toolbutton_style=4' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'underline_shortcut=1' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'wheel_scroll_lines=3' >> $HOME/.config/qt5ct/qt5ct.conf
    echo '' >> $HOME/.config/qt5ct/qt5ct.conf
    echo '[SettingsWindow]' >> $HOME/.config/qt5ct/qt5ct.conf
    echo "geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\x10\0\0\0(\0\0\x3\xb7\0\0\x4'\0\0\0\x12\0\0\0*\0\0\x3\xb5\0\0\x4%\0\0\0\0\0\0\0\0\a\x80\0\0\0\x12\0\0\0*\0\0\x3\xb5\0\0\x4%)" >> $HOME/.config/qt5ct/qt5ct.conf
    echo '' >> $HOME/.config/qt5ct/qt5ct.conf
    echo '[Troubleshooting]' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'force_raster_widgets=1' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'ignored_applications=@Invalid()' >> $HOME/.config/qt5ct/qt5ct.conf
    echo '' >> $HOME/.config/qt5ct/qt5ct.conf
    echo '[Fonts]' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
    echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf

    # GTK 4.0 Theme $HOME/.config/gtk-4.0/settings.ini
    if [ ! -d $HOME/.config/gtk-4.0 ]
        mkdir $HOME/.config/gtk-4.0
    end
    echo "Generating GTK 4 theme config."
    echo "[Settings]" > $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-application-prefer-dark-theme=true" >> $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-button-images=true" >> $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-cursor-theme-name=breeze_cursors" >> $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-cursor-theme-size=24" >> $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-decoration-layout=icon:minimize,maximize,close" >> $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-enable-animations=true" >> $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-font-name=Noto Sans,  10" >> $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-icon-theme-name=breeze-dark" >> $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-menu-images=true" >> $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-primary-button-warps-slider=false" >> $HOME/.config/gtk-4.0/settings.ini
    echo "gtk-toolbar-style=3" >> $HOME/.config/gtk-4.0/settings.ini

    # GTK 3.0 Theme $HOME/.config/gtk-3.0/settings.ini
    if [ ! -d $HOME/.config/gtk-3.0 ]
        mkdir $HOME/.config/gtk-3.0
    end
    echo "Generating GTK 3 theme config."
    echo "[Settings]" > $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-application-prefer-dark-theme=true" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-button-images=true" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-cursor-theme-name=breeze_cursors" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-cursor-theme-size=24" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-decoration-layout=icon:minimize,maximize,close" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-enable-animations=true" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-font-name=Noto Sans,  10" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-icon-theme-name=breeze-dark" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-menu-images=true" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-primary-button-warps-slider=false" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-toolbar-style=3" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-modules=colorreload-gtk-module" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-theme-name=Breeze-Dark" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-enable-event-sounds=1" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-enable-input-feedback-sounds=1" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-xft-antialias=1" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-xft-hinting=1" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-xft-hintstyle=hintfull" >> $HOME/.config/gtk-3.0/settings.ini
    echo "gtk-xft-rgba=rgb" >> $HOME/.config/gtk-3.0/settings.ini

    # GTK 2.0 Theme $HOME/.gtkrc-2.0.
    echo "Generating GTK 2 theme config."
    echo 'gtk-button-images=1' > $HOME/.gtkrc-2.0
    echo 'gtk-cursor-theme-name="breeze_cursors"' >> $HOME/.gtkrc-2.0
    echo 'gtk-cursor-theme-size=24' >> $HOME/.gtkrc-2.0
    echo 'gtk-enable-animations=1' >> $HOME/.gtkrc-2.0
    echo 'gtk-font-name="Noto Sans,  10"' >> $HOME/.gtkrc-2.0
    echo 'gtk-icon-theme-name="breeze-dark"' >> $HOME/.gtkrc-2.0
    echo 'gtk-menu-images=1' >> $HOME/.gtkrc-2.0
    echo 'gtk-primary-button-warps-slider=0' >> $HOME/.gtkrc-2.0
    echo 'gtk-toolbar-style=3' >> $HOME/.gtkrc-2.0
    echo 'gtk-theme-name="Breeze-Dark"' >> $HOME/.gtkrc-2.0
    echo 'gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR' >> $HOME/.gtkrc-2.0
    echo 'gtk-enable-event-sounds=1' >> $HOME/.gtkrc-2.0
    echo 'gtk-enable-input-feedback-sounds=1' >> $HOME/.gtkrc-2.0
    echo 'gtk-xft-antialias=1' >> $HOME/.gtkrc-2.0
    echo 'gtk-xft-hinting=1' >> $HOME/.gtkrc-2.0
    echo 'gtk-xft-hintstyle="hintfull"' >> $HOME/.gtkrc-2.0
    echo 'gtk-xft-rgba="rgb"' >> $HOME/.gtkrc-2.0

    # Xwindows theme $HOME/.config/xsettingsd/xsettingsd.conf.
    if [ ! -d $HOME/.config/xsettingsd ]
        mkdir $HOME/.config/xsettingsd
    end
    echo "Generating Xwindows theme config."
    echo 'Gtk/EnableAnimations 1' > $HOME/.config/xsettingsd/xsettingsd.conf
    echo 'Gtk/DecorationLayout "icon:minimize,maximize,close"' >> $HOME/.config/xsettingsd/xsettingsd.conf
    echo 'Gtk/PrimaryButtonWarpsSlider 0' >> $HOME/.config/xsettingsd/xsettingsd.conf
    echo 'Gtk/ToolbarStyle 3' >> $HOME/.config/xsettingsd/xsettingsd.conf
    echo 'Gtk/MenuImages 1' >> $HOME/.config/xsettingsd/xsettingsd.conf
    echo 'Gtk/ButtonImages 1' >> $HOME/.config/xsettingsd/xsettingsd.conf
    echo 'Gtk/CursorThemeSize 24' >> $HOME/.config/xsettingsd/xsettingsd.conf
    echo 'Gtk/CursorThemeName "breeze_cursors"' >> $HOME/.config/xsettingsd/xsettingsd.conf
    echo 'Net/IconThemeName "breeze-dark"' >> $HOME/.config/xsettingsd/xsettingsd.conf
    echo 'Gtk/FontName "Noto Sans,  10"' >> $HOME/.config/xsettingsd/xsettingsd.conf
    echo 'Net/ThemeName "Breeze-Dark"' >> $HOME/.config/xsettingsd/xsettingsd.conf
end

if [ $CHOICE -eq 13 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    # Setting fonts to Noto Sans and Hack.

    # Settig Dmenu font to Noto Sans
    if [ -f $HOME/.config/dmscripts/config ]
        echo "Setting font Noto Sans in $HOME/.config/dmscripts/config"
        sed -i 's/Ubuntu/NotoSans/' $HOME/.config/dmscripts/config
    else
        echo "$HOME/.config/dmscripts/config file not founds, skipping."
    end
    if [ -f $HOME/.local/bin/dm-run ]
        echo "Setting font Noto Sans in $HOME/.local/bin/dm-run"
        sed -i 's/Ubuntu/NotoSans/' $HOME/.local/bin/dm-run
    else
        echo "$HOME/.local/bin/dm-run file not founds, skipping."
    end
    if [ -f $HOME/.config/xmonad/xmonad.hs ]
        echo "Setting font Noto Sans in $HOME/.config/xmonad/xmonad.hs"
        sed -i 's/Ubuntu/NotoSans/' $HOME/.config/xmonad/xmonad.hs
    else
        echo "$HOME/.config/xmonad/xmonad.hs file not founds, skipping."
    end

    # Setting Alacritty fonts to Hack.
    if [ -f $HOME/.config/alacritty/alacritty.yml ]
        echo "Setting font Noto Sans in $HOME/.config/alacritty/alacritty.yml"
        sed -i 's/    family: Source Code Pro/    # family: Source Code Pro/' $HOME/.config/alacritty/alacritty.yml
        sed -i 's/    # family: Hack/    family: Hack/' $HOME/.config/alacritty/alacritty.yml
    else
        echo "$HOME/.config/alacritty/alacritty.yml file not founds, skipping."
    end

    # Setting Xmobar fonts to Noto Sans.
    if [ -f $HOME/.config/xmobar/doom-one-xmobarrc ]
        echo "Setting Xmobar fonts to Noto Sans."
        sed -i 's/Ubuntu/Noto Sans/' $HOME/.config/xmobar/*-xmobarrc
    else
        echo "Xmobar theme files not found."
    end

    # Setting Conky fonts to Noto Sans.
    if [ -f $HOME/.config/conky/xmonad/doom-one-01.conkyrc ]
        echo "Setting Conky fonts to Noto Sans."
        sed -i 's/Source Code Pro/Noto Sans/' $HOME/.config/conky/xmonad/*.conkyrc
        sed -i 's/Raleway/Noto Sans/' $HOME/.config/conky/xmonad/*.conkyrc
        sed -i 's/Ubuntu/Noto Sans/' $HOME/.config/conky/xmonad/*.conkyrc
    else
        echo "Conky theme files not found."
    end

    # Setting font Noto Sans in $HOME/.gtkrc-2.0.
    if [ -f $HOME/.gtkrc-2.0 ]
        echo "Setting font Noto Sans in $HOME/.gtkrc-2.0."
        set OLDFONT (grep -R "gtk-font-name=" $HOME/.gtkrc-2.0 | cut -d '"' -f 2 | cut -d "," -f 1)
        sed -i "s/$OLDFONT/Noto Sans/" $HOME/.gtkrc-2.0
    else
        echo "$HOME/.gtkrc-2.0 file not founds, skipping."
    end

    # Setting font Noto Sans in $HOME/.config/gtk-3.0/settings.ini.
    if [ -f $HOME/.config/gtk-3.0/settings.ini ]
        echo "Setting font Noto Sans in $HOME/.config/gtk-3.0/settings.ini."
        set OLDFONT (grep -R "gtk-font-name=" $HOME/.config/gtk-3.0/settings.ini | cut -d "=" -f 2 | cut -d "," -f 1)
        sed -i "s/$OLDFONT/Noto Sans/" $HOME/.config/gtk-3.0/settings.ini
    else
        echo "$HOME/.config/gtk-3.0/settings.ini file not founds, skipping."
    end

    # Setting font Noto Sans in $HOME/.config/gtk-4.0/settings.ini.
    if [ -f $HOME/.config/gtk-4.0/settings.ini ]
        echo "Setting font Noto Sans in $HOME/.config/gtk-4.0/settings.ini."
        set OLDFONT (grep -R "gtk-font-name=" $HOME/.config/gtk-4.0/settings.ini | cut -d "=" -f 2 | cut -d "," -f 1)
        sed -i "s/$OLDFONT/Noto Sans/" $HOME/.config/gtk-4.0/settings.ini
    else
        echo "$HOME/.config/gtk-4.0/settings.ini file not founds, skipping."
    end
end

if [ $CHOICE -eq 14 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    if [ -f /usr/share/icons/default/index.theme ]
        if grep -R "Adwaita" /usr/share/icons/default/index.theme > /dev/null
            echo "Setting breeze_cursors cursor theme."
            sudo sed -i 's/Adwaita/breeze_cursors/' /usr/share/icons/default/index.theme
        else
            echo "Cool breeze_cursors theme already set."
        end
    else
        echo "/usr/share/icons/default/index.theme not found, skipping."
    end
end

if [ $CHOICE -eq 15 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    # Let QT apps use the KDE theme and font.
    if grep -R "QT_QPA_PLATFORMTHEME=qt5ct" /etc/environment > /dev/null
        echo "Cool QT_QPA_PLATFORMTHEME=qt5ct is already in /etc/environment."
    else
        echo "Adding QT_QPA_PLATFORMTHEME=qt5ct to /etc/environment."
        sudo fish -c "echo 'QT_QPA_PLATFORMTHEME=qt5ct' >> /etc/environment"
        echo "A reboot is probably needed."
    end
end

if [ $CHOICE -eq 16 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    echo "Removing Notify, Kernel and Uptime from Xmobar."
    sed -i "s@<box type=Bottom width=2 mb=2 color=#98be65><fc=#98be65>%messages%  <action=`alacritty -e nvim .log/notify.log`>%notify-log%</action></fc></box>    @@" $HOME/.config/xmobar/doom-one-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#51afef><fc=#51afef>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/doom-one-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#98be65><fc=#98be65>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/doom-one-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#bd93f9><fc=#bd93f9>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/dracula-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#ff79c6><fc=#ff79c6>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/dracula-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#d3869b><fc=#d3869b>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/gruvbox-dark-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#b16286><fc=#b16286>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/gruvbox-dark-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#FF6188><fc=#FF6188>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/monokai-pro-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#AB9DF2><fc=#AB9DF2>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/monokai-pro-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#8FBCBB><fc=#8FBCBB>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/nord-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#B48EAD><fc=#B48EAD>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/nord-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#EC5f67><fc=#EC5f67>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/oceanic-next-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#c594c5><fc=#c594c5>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/oceanic-next-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#82aaff><fc=#82aaff>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/palenight-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#c3e88d><fc=#c3e88d>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/palenight-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#dc322f><fc=#dc322f>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/solarized-dark-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#d33682><fc=#d33682>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/solarized-dark-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#dc322f><fc=#dc322f>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/solarized-light-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#d33682><fc=#d33682>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/solarized-light-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#f7768e><fc=#f7768e>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/tokyo-night-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#bb9af7><fc=#bb9af7>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/tokyo-night-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#cc6666><fc=#cc6666>%penguin%  %kernel%</fc></box>    @@" $HOME/.config/xmobar/tomorrow-night-xmobarrc
    sed -i "s@<box type=Bottom width=2 mb=2 color=#b294bb><fc=#b294bb>%uparrow%  %uptime%</fc></box>    @@" $HOME/.config/xmobar/tomorrow-night-xmobarrc
end

if [ $CHOICE -eq 17 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    if grep -R "--height 24" $HOME/.config/xmonad/xmonad.hs > /dev/null
        echo "Cool Trayer size already set to 24."
    else
        echo "Setting Trayer size to 24."
        sed -i 's/--height 22/--height 24/' $HOME/.config/xmonad/xmonad.hs > /dev/null
    end
end

if [ $CHOICE -eq 20 ] || [ $CHOICE -eq 21 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    # Switch to Advanced conky.
    if [ $CHOICE -eq 20 ]
        echo "Switching to Advanced Conky."
    end
    sed -i 's/-01.conkyrc/-02.conkyrc/' $HOME/.config/xmonad/xmonad.hs
end

if [ $CHOICE -eq 21 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    # Add Hotkey conkys.
    echo "Switching to Advanced Conky with Hotkey Conkys."
    sed -i '\#-02.conkyrc#a\  spawn ("sleep 2 && conky -c $HOME/.config/conky/xmonad/" ++ colorScheme ++ "-04.conkyrc")' $HOME/.config/xmonad/xmonad.hs
    sed -i '\#-02.conkyrc#a\  spawn ("sleep 2 && conky -c $HOME/.config/conky/xmonad/" ++ colorScheme ++ "-03.conkyrc")' $HOME/.config/xmonad/xmonad.hs
end

if [ $CHOICE -eq 22 ]
    # Switch to original conky.
    echo "Switching to Original Conky."
    sed -i 's/-02.conkyrc/-01.conkyrc/' $HOME/.config/xmonad/xmonad.hs
end

if [ $CHOICE -eq 20 ] || [ $CHOICE -eq 22 ]
    # Remove Hotkey conkys.
    sed -i '/-03.conkyrc/d' $HOME/.config/xmonad/xmonad.hs
    sed -i '/-04.conkyrc/d' $HOME/.config/xmonad/xmonad.hs
end

if [ $CHOICE -eq 30 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    # Set variables for theme.
    set GTKTHEME "Doom-One"
    set KDETHEME "DoomOne.colors"
end

if [ $CHOICE -eq 31 ]
    # Set variables for theme.
    set GTKTHEME "Doom-Dracula"
    set KDETHEME "DoomDracula.colors"
end

if [ $CHOICE -eq 32 ]
    # Set variables for theme.
    set GTKTHEME "Doom-Gruvbox"
    set KDETHEME "DoomGruvbox.colors"
end

if [ $CHOICE -eq 33 ]
    # Set variables for theme.
    set GTKTHEME "Doom-Monokai-Pro"
    set KDETHEME "DoomMonokaiPro.colors"
end

if [ $CHOICE -eq 34 ]
    # Set variables for theme.
    set GTKTHEME "Doom-Nord"
    set KDETHEME "DoomNord.colors"
end

if [ $CHOICE -eq 35 ]
    # Set variables for theme.
    set GTKTHEME "Doom-Oceanic-Next"
    set KDETHEME "DoomOceanicNext.colors"
end

if [ $CHOICE -eq 36 ]
    # Set variables for theme.
    set GTKTHEME "Doom-Palenight"
    set KDETHEME "DoomPalenight.colors"
end

if [ $CHOICE -eq 37 ]
    # Set variables for theme.
    set GTKTHEME "Doom-Solarized-Dark"
    set KDETHEME "DoomSolarizedDark.colors"
end

if [ $CHOICE -eq 38 ]
    # Set variables for theme.
    set GTKTHEME "Doom-Tomorrow-Night"
    set KDETHEME "DoomTomorrowNight.colors"
end

if [ $CHOICE -ge 30 ] && [ $CHOICE -le 38 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    if [ -f $HOME/.gtkrc-2.0 ]
        echo "Settings GTK2 theme to $GTKTHEME."
        sed -i "s/^gtk-theme-name=.*/gtk-theme-name=\"$GTKTHEME\"/" $HOME/.gtkrc-2.0
    else
        echo "$HOME/.gtkrc-2.0 file not founds, skipping."
    end
    if [ -f $HOME/.config/gtk-3.0/settings.ini ]
        echo "Settings GTK3 theme to $GTKTHEME"
        sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTKTHEME/" $HOME/.config/gtk-3.0/settings.ini
    else
        echo "$HOME/.config/gtk-3.0/settings.ini file not found, skipping."
    end
    if [ -f $HOME/.local/share/color-schemes/$KDETHEME ]
        echo "Settings QT theme to $KDETHEME"
        /bin/cp -f $HOME/.local/share/color-schemes/$KDETHEME $HOME/.config/kdeglobals
    else
        echo "$HOME/.local/share/color-schemes/$KDETHEME file not found skipping."
    end
end

if [ $CHOICE -eq 40 ]
    # Increase Xmobar font size.
    if [ -f $HOME/.config/xmobar/doom-one-xmobarrc ]
        set OLD_XMOBAR_SIZE ( grep 'Config { font' $HOME/.config/xmobar/doom-one-xmobarrc | grep -o '[0-9]*[0-9]"' | cut -d '"' -f 1 )
        set NEW_XMOBAR_SIZE ( echo $OLD_XMOBAR_SIZE + 1 | bc )
    else
        echo "Xmobar theme file not found."
    end
end

if [ $CHOICE -eq 41 ]
    # Decrease Xmobar font size.
    if [ -f $HOME/.config/xmobar/doom-one-xmobarrc ]
        set OLD_XMOBAR_SIZE ( grep 'Config { font' $HOME/.config/xmobar/doom-one-xmobarrc | grep -o '[0-9]*[0-9]"' | cut -d '"' -f 1 )
        set NEW_XMOBAR_SIZE ( echo $OLD_XMOBAR_SIZE - 1 | bc )
    else
        echo "Xmobar theme file not found."
    end
end

if [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ] || [ $CHOICE -eq 40 ] || [ $CHOICE -eq 41 ]
    # Xmobar font size for presets.
    if [ $NEW_XMOBAR_SIZE -le 20 ]
        if [ $NEW_XMOBAR_SIZE -ge 8 ]
            echo "Setting font size $NEW_XMOBAR_SIZE for Xmobar."
            set OLD_XMOBAR_FONT ( sed '/Config { font/,/]/!d' $HOME/.config/xmobar/doom-one-xmobarrc | grep '"' | cut -d '"' -f 2 )
            set NEW_XMOBAR_FONT ( sed '/Config { font/,/]/!d' $HOME/.config/xmobar/doom-one-xmobarrc | grep '"' | cut -d '"' -f 2 | grep -o "[a-Z]*[a-Z0-9 ]*[a-Z]" )
            set DMENU_SIZE ( echo "$NEW_XMOBAR_SIZE * 1.35" | bc | cut -d "." -f 1 )
            sed -i "s/$OLD_XMOBAR_FONT[1]/$NEW_XMOBAR_FONT[1] $NEW_XMOBAR_SIZE/" $HOME/.config/xmobar/*-xmobarrc
            sed -i "s/$OLD_XMOBAR_FONT[2]/$NEW_XMOBAR_FONT[2] $NEW_XMOBAR_SIZE/" $HOME/.config/xmobar/*-xmobarrc
            sed -i "s/$OLD_XMOBAR_FONT[3]/$NEW_XMOBAR_FONT[3] $NEW_XMOBAR_SIZE/" $HOME/.config/xmobar/*-xmobarrc
            sed -i "s/$OLD_XMOBAR_FONT[4]/$NEW_XMOBAR_FONT[4] $NEW_XMOBAR_SIZE/" $HOME/.config/xmobar/*-xmobarrc
            

            # Dmenu Font Size
            echo "Setting font size $DMENU_SIZE for dmenu."
            if grep -R "swn_font" $HOME/.config/xmonad/xmonad.hs | grep "Ubuntu" > /dev/null
                set DMENU_FONT "Ubuntu"
            else
                set DMENU_FONT "NotoSans"
            end
            if grep -R "pixelsize=" $HOME/.config/dmscripts/config > /dev/null
                sed -i "s/pixelsize=[0-9]*/pixelsize=$DMENU_SIZE/" $HOME/.config/dmscripts/config
            else
                sed -i "s/dmenu -i -l 20 -p/dmenu -fn xft:$DMENU_FONT:weight=bold:pixelsize=$DMENU_SIZE:antialias=true:hinting=true -i -l 20 -p/" $HOME/.config/dmscripts/config
            end

            if grep -R "pixelsize=" $HOME/.local/bin/dm-run > /dev/null
                sed -i "s/pixelsize=[0-9]*/pixelsize=$DMENU_SIZE/" $HOME/.local/bin/dm-run
            else
                sed -i "s/dmenu -l 20 -g/dmenu -fn xft:$DMENU_FONT:weight=bold:pixelsize=$DMENU_SIZE:antialias=true:hinting=true -l 20 -g/" $HOME/.local/bin/dm-run
            end

            if grep -R "passmenu -p" $HOME/.config/xmonad/xmonad.hs > /dev/null
                sed -i "s/passmenu -p/passmenu -fn xft:$DMENU_FONT:weight=bold:pixelsize=$DMENU_SIZE:antialias=true:hinting=true -p/" $HOME/.config/xmonad/xmonad.hs
            else
                sed -i "s/pixelsize=[0-9]*/pixelsize=$DMENU_SIZE/" $HOME/.config/xmonad/xmonad.hs
            end
        else
            echo "Xmobar font limited to $OLD_XMOBAR_SIZE."
            echo "Font size unchanged."
        end
    else
        echo "Xmobar font limited to $OLD_XMOBAR_SIZE."
        echo "Font size unchanged."
    end
end

if [ $CHOICE -eq 42 ]
    # Increase Conky font size.
    if [ -f $HOME/.config/conky/xmonad/doom-one-01.conkyrc ]
        set OLDCFONTSIZE (grep size= $HOME/.config/conky/xmonad/doom-one-01.conkyrc | cut -f 3 -d "=" | cut -f 1 -d "'" | head -1)
        set CFONTSIZE1 ( echo $OLDCFONTSIZE + 1 | bc )
    else
        echo "Conky theme files not found."
    end
end

if [ $CHOICE -eq 43 ]
    # Decrease Conky font size.
    if [ -f $HOME/.config/conky/xmonad/doom-one-01.conkyrc ]
        set OLDCFONTSIZE (grep size= $HOME/.config/conky/xmonad/doom-one-01.conkyrc | cut -f 3 -d "=" | cut -f 1 -d "'" | head -1)
        set CFONTSIZE1 ( echo $OLDCFONTSIZE - 1 | bc )
    else
        echo "Conky theme files not found."
    end
end

if [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ] || [ $CHOICE -eq 42 ] || [ $CHOICE -eq 43 ]
    if [ $CFONTSIZE1 -ge 4 ] && [ $CFONTSIZE1 -le 20 ]
        echo "Setting font size $CFONTSIZE1 for Conky."
        set LINENUMBERS ( grep -n size= $HOME/.config/conky/xmonad/doom-one-01.conkyrc | cut -f 1 -d ":" )
        set CFONTSIZE2 (printf %.0f (echo "$CFONTSIZE1 * 3.5" | bc))
        set CFONTSIZE3 (printf %.0f (echo "$CFONTSIZE1 * 1.5" | bc))
        set CFONTSIZE4 (printf %.0f (echo "$CFONTSIZE1 * 1.1" | bc))
        sed -i "$LINENUMBERS[1] s/size=[0-9]*/size=$CFONTSIZE1/" $HOME/.config/conky/xmonad/*.conkyrc
        sed -i "$LINENUMBERS[2] s/size=[0-9]*/size=$CFONTSIZE2/" $HOME/.config/conky/xmonad/*.conkyrc
        sed -i "$LINENUMBERS[3] s/size=[0-9]*/size=$CFONTSIZE3/" $HOME/.config/conky/xmonad/*.conkyrc
        sed -i "$LINENUMBERS[4] s/size=[0-9]*/size=$CFONTSIZE4/" $HOME/.config/conky/xmonad/*.conkyrc
    else
        echo "Conky font size limited to range 4 to 20."
        echo "Font size unchanged."
    end
end

if [ $CHOICE -eq 44 ]
    set NEWFONTSIZE 0
    while [ $NEWFONTSIZE -lt 6 ] || [ $NEWFONTSIZE -gt 20 ] || [ $NEWFONTSIZE -eq 13 ] || [ $NEWFONTSIZE -eq 15 ] || [ $NEWFONTSIZE -eq 17 ] || [ $NEWFONTSIZE -eq 19 ]
        echo "Choose a font size: 6, 7, 8, 9, 10, 11, 12, 14, 16, 18, 20."
        read NEWFONTSIZE
        echo ""
    end

end

if [ $CHOICE -eq 44 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    # Set Systems font size.

    # Xterm font size in $HOME/.Xresources
    sed -i "s/size=[0-9]*/size=$NEWFONTSIZE/" $HOME/.Xresources
    sed -i "s/faceSize: [0-9]*/faceSize: $NEWFONTSIZE/" $HOME/.Xresources

    # Xmonad font size.
    echo "Setting font size $NEWFONTSIZE in $HOME/.config/xmonad/xmonad.hs"
    set LINENUMBER (grep -n "myFont" $HOME/.config/xmonad/xmonad.hs | grep "size=" | cut -f 1 -d ":")
    sed -i "$LINENUMBER s/size=[0-9]*/size=$NEWFONTSIZE/" $HOME/.config/xmonad/xmonad.hs

    # Alacritty font size.
    if [ -f $HOME/.config/alacritty/alacritty.yml ]
        echo "Setting font size $NEWFONTSIZE in $HOME/.config/alacritty/alacritty.yml"
        sed -i "s/size: [0-9]*.0/size: $NEWFONTSIZE.0/" $HOME/.config/alacritty/alacritty.yml
    else
        echo "$HOME/.config/alacritty/alacritty.yml file not founds, skipping."
    end

    # Set GTK 2.0 font size.
    if [ -f $HOME/.gtkrc-2.0 ]
        echo "Setting font size $NEWFONTSIZE in $HOME/.gtkrc-2.0."
        set LINENUMBER (grep -n "gtk-font-name=" $HOME/.gtkrc-2.0 | cut -d ":" -f 1)
        set OLDFONTSIZE (grep "gtk-font-name=" $HOME/.gtkrc-2.0 | cut -d "," -f 2 | cut -d "\"" -f 1)
        sed -i "$LINENUMBER s/$OLDFONTSIZE/  $NEWFONTSIZE/" $HOME/.gtkrc-2.0
    else
        echo "$HOME/.gtkrc-2.0 file not founds, skipping."
    end

    # Set GTK 3.0 font size.
    if [ -f $HOME/.config/gtk-3.0/settings.ini ]
        echo "Setting font size $NEWFONTSIZE in $HOME/.config/gtk-3.0/settings.ini."
        set LINENUMBER (grep -n "gtk-font-name=" $HOME/.config/gtk-3.0/settings.ini | cut -d ":" -f 1)
        set OLDFONTSIZE (grep "gtk-font-name=" $HOME/.config/gtk-3.0/settings.ini | cut -d "," -f 2)
        sed -i "$LINENUMBER s/$OLDFONTSIZE/  $NEWFONTSIZE/" $HOME/.config/gtk-3.0/settings.ini
    else
        echo "$HOME/.config/gtk-3.0/settings.ini file not founds, skipping."
    end

    # Set GTK 4.0 font size.
    if [ -f $HOME/.config/gtk-4.0/settings.ini ]
        echo "Setting font size $NEWFONTSIZE in $HOME/.config/gtk-4.0/settings.ini."
        set LINENUMBER (grep -n "gtk-font-name=" $HOME/.config/gtk-4.0/settings.ini | cut -d ":" -f 1)
        set OLDFONTSIZE (grep "gtk-font-name=" $HOME/.config/gtk-4.0/settings.ini | cut -d "," -f 2)
        sed -i "$LINENUMBER s/$OLDFONTSIZE/  $NEWFONTSIZE/" $HOME/.config/gtk-4.0/settings.ini
    else
        echo "$HOME/.config/gtk-4.0/settings.ini file not founds, skipping."
    end

    # Set Xwindows font size.
    if [ -f $HOME/.config/xsettingsd/xsettingsd.conf ]
        echo "Setting font size $NEWFONTSIZE in $HOME/.config/xsettingsd/xsettingsd.conf"
        set LINENUMBER (grep -n "FontName" $HOME/.config/xsettingsd/xsettingsd.conf | cut -d ":" -f 1)
        set OLDFONTSIZE (grep "FontName" $HOME/.config/xsettingsd/xsettingsd.conf | cut -d "," -f 2 | cut -d '"' -f 1)
        sed -i "$LINENUMBER s/$OLDFONTSIZE/  $NEWFONTSIZE/" $HOME/.config/xsettingsd/xsettingsd.conf
    else
        echo "$HOME/.config/xsettingsd/xsettingsd file not founds, skipping."
    end

    # Set qt5ct font size.
    if [ -f $HOME/.config/xsettingsd/xsettingsd.conf ]
        echo "Setting font size $NEWFONTSIZE in $HOME/.config/qt5ct/qt5ct.conf."
        sed -i '/\[Fonts\]/d' $HOME/.config/qt5ct/qt5ct.conf
        sed -i '/fixed=/d' $HOME/.config/qt5ct/qt5ct.conf
        sed -i '/general=/d' $HOME/.config/qt5ct/qt5ct.conf
        echo '[Fonts]' >> $HOME/.config/qt5ct/qt5ct.conf

        if [ $NEWFONTSIZE -eq 6 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@\x18\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@\x18\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
        if [ $NEWFONTSIZE -eq 7 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@\x1c\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@\x1c\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
        if [ $NEWFONTSIZE -eq 8 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@ \0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@ \0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
        if [ $NEWFONTSIZE -eq 9 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@\"\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@\"\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
        if [ $NEWFONTSIZE -eq 10 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
        if [ $NEWFONTSIZE -eq 11 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@&\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@&\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
        if [ $NEWFONTSIZE -eq 12 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@(\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@(\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
        if [ $NEWFONTSIZE -eq 14 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@,\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@,\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
        if [ $NEWFONTSIZE -eq 16 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@0\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@0\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
        if [ $NEWFONTSIZE -eq 18 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@2\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@2\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
        if [ $NEWFONTSIZE -eq 20 ]
            echo 'fixed=@Variant(\0\0\0@\0\0\0\b\0H\0\x61\0\x63\0k@4\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
            echo 'general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@4\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)' >> $HOME/.config/qt5ct/qt5ct.conf
        end
    else
        echo "$HOME/.config/qt5ct/qt5ct.conf file not found, skipping."
    end

    # Set QT/KDE font size.
    if [ -f $HOME/.config/kdeglobals ]
        echo "Setting font size $NEWFONTSIZE in $HOME/.config/kdeglobals."
        set SMALLFONTSIZE (printf %.0f (echo "$NEWFONTSIZE * 0.8" | bc))
        if not grep -R "\[General\]" $HOME/.config/kdeglobals > /dev/null
            echo "" >> $HOME/.config/kdeglobals
            echo "[General]" >> $HOME/.config/kdeglobals
        end
        if grep -R "toolBarFont=" $HOME/.config/kdeglobals > /dev/null
            set LINENUMBER (grep -n "toolBarFont=" $HOME/.config/kdeglobals | cut -d ":" -f 1)
            set OLDFONTSIZE (grep "toolBarFont=" $HOME/.config/kdeglobals | cut -d "," -f 2)
            sed -i "$LINENUMBER s/$OLDFONTSIZE/$NEWFONTSIZE/1" $HOME/.config/kdeglobals
        else
            sed -i "/\[General\]/a toolBarFont=Noto Sans,$NEWFONTSIZE,-1,5,50,0,0,0,0,0" $HOME/.config/kdeglobals
        end
        if grep -R "smallestReadableFont=" $HOME/.config/kdeglobals > /dev/null
            set LINENUMBER (grep -n "smallestReadableFont=" $HOME/.config/kdeglobals | cut -d ":" -f 1)
            set OLDFONTSIZE (grep "smallestReadableFont=" $HOME/.config/kdeglobals | cut -d "," -f 2)
            sed -i "$LINENUMBER s/$OLDFONTSIZE/$SMALLFONTSIZE/1" $HOME/.config/kdeglobals
        else
            sed -i "/\[General\]/a smallestReadableFont=Noto Sans,$SMALLFONTSIZE,-1,5,50,0,0,0,0,0" $HOME/.config/kdeglobals
        end
        if grep -R "menuFont=" $HOME/.config/kdeglobals > /dev/null
            set LINENUMBER (grep -n "menuFont=" $HOME/.config/kdeglobals | cut -d ":" -f 1)
            set OLDFONTSIZE (grep "menuFont=" $HOME/.config/kdeglobals | cut -d "," -f 2)
            sed -i "$LINENUMBER s/$OLDFONTSIZE/$NEWFONTSIZE/1" $HOME/.config/kdeglobals
        else
            sed -i "/\[General\]/a menuFont=Noto Sans,$NEWFONTSIZE,-1,5,50,0,0,0,0,0" $HOME/.config/kdeglobals
        end
        if grep -R "font=" $HOME/.config/kdeglobals > /dev/null
            set LINENUMBER (grep -n "font=" $HOME/.config/kdeglobals | cut -d ":" -f 1)
            set OLDFONTSIZE (grep "font=" $HOME/.config/kdeglobals | cut -d "," -f 2)
            sed -i "$LINENUMBER s/$OLDFONTSIZE/$NEWFONTSIZE/1" $HOME/.config/kdeglobals
        else
            sed -i "/\[General\]/a font=Noto Sans,$NEWFONTSIZE,-1,5,50,0,0,0,0,0" $HOME/.config/kdeglobals
        end
        if grep -R "fixed=" $HOME/.config/kdeglobals > /dev/null
            set LINENUMBER (grep -n "fixed=" $HOME/.config/kdeglobals | cut -d ":" -f 1)
            set OLDFONTSIZE (grep "fixed=" $HOME/.config/kdeglobals | cut -d "," -f 2)
            sed -i "$LINENUMBER s/$OLDFONTSIZE/$NEWFONTSIZE/1" $HOME/.config/kdeglobals
        else
            sed -i "/\[General\]/a fixed=Hack,$NEWFONTSIZE,-1,5,50,0,0,0,0,0" $HOME/.config/kdeglobals
        end
        if grep -R "activeFont=" $HOME/.config/kdeglobals > /dev/null
            set LINENUMBER (grep -n "activeFont=" $HOME/.config/kdeglobals | cut -d ":" -f 1)
            set OLDFONTSIZE (grep "activeFont=" $HOME/.config/kdeglobals | cut -d "," -f 2)
            sed -i "$LINENUMBER s/$OLDFONTSIZE/$NEWFONTSIZE/1" $HOME/.config/kdeglobals
        else
            sed -i "/\[WM\]/a activeFont=Noto Sans,$NEWFONTSIZE,-1,5,50,0,0,0,0,0" $HOME/.config/kdeglobals
        end
    else
        echo "$HOME/.config/kdeglobals file not found, skipping."
    end
end

if [ $CHOICE -eq 45 ]
    # Choose a Console font size.
    set VCFONTLIST ter-112 ter-114 ter-116 ter-118 ter-120 ter-122 ter-124 ter-128 ter-132
    set VCFONTSIZE 0
    while not echo $VCFONTLIST | grep "ter-1$VCFONTSIZE" > /dev/null
        echo "Enter a Console font size."
        echo "12 14 16 18 20 22 24 28 32"
        read VCFONTSIZE
        echo ""
    end
end

if [ $CHOICE -eq 45 ] || [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ]
    # Set Console font size to VCFONTSIZE.
    echo "Setting font size $VCFONTSIZE for the console."
    if [ -f /etc/vconsole.conf ]
        if grep -R "FONT=" /etc/vconsole.conf > /dev/null
            sudo sed -i '/FONT=/d' /etc/vconsole.conf
        end
        if grep -R "FONT_MAP=" /etc/vconsole.conf > /dev/null
            sudo sed -i '/FONT_MAP=/d' /etc/vconsole.conf
        end
    end
    sudo fish -c "echo "FONT=ter-1"$VCFONTSIZE"n" >> /etc/vconsole.conf"
    sudo fish -c "echo "FONT_MAP=8859-2" >> /etc/vconsole.conf"
end

if [ $CHOICE -eq 1 ] || [ $CHOICE -eq 2 ] || [ $CHOICE -eq 4 ] || [ $CHOICE -eq 20 ] || [ $CHOICE -eq 21 ] || [ $CHOICE -eq 22 ] || [ $CHOICE -eq 40 ] || [ $CHOICE -eq 41 ] || [ $CHOICE -eq 42 ] || [ $CHOICE -eq 43 ]
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
