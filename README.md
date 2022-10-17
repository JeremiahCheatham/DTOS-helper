# DTOS-helper
```
git clone https://github.com/jeremiahcheatham/dtos-helper.git
cd dtos-helper
fish dtos-helper.sh
fish dtos-theme.sh
```
```
   --------- DTOS Helper 1.5 ---------
1  Run all DTOS Fixes.
2  Reset DTOS from /etc/dtos folder.
   --------- ArchLinux Fixes ---------
10 Let sudo use wheel group.
11 Enable ParallelDownloads.
12 Install git, nano, ntfs-3g and pacman-contrib.
13 Configure lz4 zram with double size.
14 Disable annoying pcspkr beeps.
   ----------- DTOS Fixes ------------
20 Install missing packages.
21 Fix volumeicon & missing alsa-utils.
22 Enable bluetooth with blueman-applet.
23 Enable Backlight keys with flashText.
24 Adding flashText support for amixer.
25 Enable notification-daemon.
26 Touchpad support with Naturalscrolling.
27 Set Firefox as default browser.
28 Fix dm-translate typo & switch to lingva.
29 Fix dm-colpick typo.
   ------- GridSelect Menu Apps ------
30 Install needed Games packages.
31 Install needed Education packages.
32 Install needed Internet packages.
33 Install needed Multimedia packages.
34 Install needed Office packages.
35 Install needed Settings packages.
36 Install needed System packages.
37 Install needed Utilities packages.
   -------------- Other ----------------
40 Use pulseaudio for extended volume.
41 Disable NaturalScrolling direction.
42 Fix tearing for amd gpus.
43 Fix tearing for intel gpus.
   -------------- QUIT ----------------
50 Quit
```
```
   ---------- DTOS Theme 1.5 ----------
1  1080x1920 14in Font/Theme Preset.
2  768x1366 14in Fonts/Theme Preset.
3  Reset DTOS from /etc/dtos folder.
   -------- THEME & FONT SETUP --------
10 Install full set of fonts.
11 Install Theme addons for QT, GTK2/3/4.
12 Create config files for QT, GTK2/3/4.
13 Set Systems fonts to Noto Sans & Hack
14 Switch Adwaita to breeze_cursors.
15 Let qt5ct handle QT themes.
   ----------- CHANGE CONKY -----------
20 Switch to Advanced Conky.
21 Advanced Conky with Hotkeys.
22 Switch to Original Conky.
   ------- CHANGE QT/GTK THEME --------
30 Set Doom One Theme.
31 Set Doom Dracula Theme.
32 Set Doom Gruvbox Theme.
33 Set Doom Monokai Pro Theme.
34 Set Doom Nord Theme.
35 Set Doom Oceanic Next Theme.
36 Set Doom Palenight Theme.
37 Set Doom Solarized Dark Theme.
38 Set Doom Tomorrow Night Theme.
   -------- CHANGE FONTS SIZE ---------
40 Increase Xmobar/Dmenu font size.
41 Decrease Xmobar/Dmenu font size.
42 Increase Conky font size.
43 Decrease Conky font size.
44 Set the Systems font size.
45 Set the Console font size.
   -------------- QUIT ----------------
50 Quit
```
# Firefox
## about:config
`network.trr.default_provider_uri    https://94.140.14.14/dns-query`    Used adguards dns over https, blocks ads & trackers. \
`network.trr.mode    3`    Force only dns over https. No fallback to unsecured dns. \
`gfx.webrender.all    true`    Firefox Compositing WebRender hardware acceleration. \
`media.ffmpeg.vaapi.enabled    true`
## Add-ons and themes
set theme to dark.
## Extensions
uBlock Origins (block ads even youtube) \
SponsorBlock (block youtube sponsors) \
I still don't care about cookies (Automatically denies cookies and stops popups EU) \
h264ify (force h264 video codec youtube for older hardware)
