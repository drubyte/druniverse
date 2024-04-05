# Installing Sway

![image](https://github.com/dru-oss/druniverse/assets/116711909/a68e5e4f-9efa-4df4-8540-510bbfdf6076)

[Credits](https://github.com/polina4096/dots.git) (Has an install script, but quite outdated)

> This is a minimal Sway installation, you'd pretty much get a very vanilla sway look, so you have to piece up lego bricks to rice it and make it look nice.

### Read and remove packages if not needed.
 ## Assuming you're on root :
`xbps-install --yes rsync wget git sway Waybar wob pulseaudio wireplumber pavucontrol elogind dbus-elogind polkit-elogind rtkit eudev chrony xorg-minimal mpv imv foot font-iosevka font-awesome6 micro vscode rustup firefox neofetch libvirt qemu virt-manager xtools fzf light slop ImageMagick ffmpeg yt-dlp grim wl-clipboard slurp pcmanfm dunst SwayNotificationCenter`
> > If you have no idea what the other packages does, check it [here](https://voidlinux.org/packages/)
> > > I probably forgot some other packages, Maybe I'll update this if I get back to Void.

### If rust is installed ;
`rustup-init -y --default-toolchain nightly`
`cargo install exa`

### Add users to group, note that kvm is a part of qemu, if not needed, remove
`usermod -a -G (I think -aG also works, but whatever) users,wheel,audio,video,cdrom,optical,storage,scanner,kvm,input,plugdev,usbmon,kmem,libvirt`

### Enable Services ( This ain't SystemD, so no `systemctl enable xx.service`)
`ln -s /etc/sv/chronyd /var/service/`

`ln -s /etc/sv/libvirtd /var/service/`
`ln -s /etc/sv/virtlockd /var/service/`
`ln -s /etc/sv/virtlogd /var/service/`
`ln -s /etc/sv/wireplumber /var/service/`

`ln -s /etc/sv/dbus /var/service/`
`ln -s /etc/sv/polkitd /var/service/`
`ln -s /etc/sv/rtkit /var/service/`

### Some [bonus](https://dev.to/karyan40024/void-linux-gnome--4p3j#recommended_packs)



