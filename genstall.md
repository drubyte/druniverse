# Gentoo UEFI Install 
> [!NOTE]
> This is my guide for a Gentoo UEFI install, Since the Wiki includes `DOS/MBR` + other configuration, I only took what I needed for the minimal install.

> This is a work in progress. It's recommend to not follow this for now.

> [!CAUTION]
> NOT AN INSTALL SCRIPT! Gentoo is best installed from scratch, knowing what you do and how it happens.



System Specs
- Intel Pentium N4200 (4)
- 4GB RAM / 500GB HDD

> used to install on an i5 with 12gb RAM, but it has to stay on Windows.

Expected that you have the basic knowledge of Linux and has an experience installing from a console. (or anything that isn't an installer)

# 0.1 : Introduction to the Guide
 This guide will help you for a minimal gentoo install with a binhost config. After the initial install, you are recommended to checkout the Gentoo Wiki for more information.

# 0.2 : Booting on the ISO

**Recommended** utility for keeping ISO'S : Ventoy

Ventoy is great especially for external hard drives. You can keep your ISO's and keep your files, all in one. 
> I won't cover the Ventoy install on this one. It's easy though, you'll be fine.

At initial boot, you'll see tuxes on the left side of the screen
> They'll appear on how many cores do you have, In my case, 4

### Connecting through wpa_supplicant
> Assuming you're using wireless connection for the wifi

 - First, we need to check your wireless interface (e.g `wlan0, wlp2s0, wlp3s0f0`)
   - `ip link`
   - It's usually listed as the last part on the list.

### We will be using `wpa_cli` to establish the connection.

 - Let's enable `wpa_supplicant` so it can detect networks.
    - `nano /etc/wpa_supplicant/wpa_supplicant.conf`
    - Add `ctrl_interface=/run/wpa_supplicant` on the first line, then `update_config=1` on the second line.
    - Hit `ctrl + s` and then `ctrl + x` to save and exit from nano.

    Just in case you forgot the wireless interface, use `ip link` again to list it.

Now, we need to enable the interface with `wpa_supplicant`.
`wpa_supplicant -B -i interface -c /etc/wpa_supplicant/wpa_supplicant.conf`

There should be an output message that it has been initialized.

### Now, we're gonna go to `wpa_cli` to connect on our wifi.

> [!NOTE]
> Read the outputs, especially when connecting.

- Run `wpa_cli`
   - `scan`
   - `scan_results` (Find your SSID)
   - `add_network` (Number 0 will appear, and the saved connection will be on this number.)
   - `set_network 0 ssid "SSID"` (include the quotings.)
   - `set_network 0 psk "Your SSID's password"` (again, include the quoting.)
   - `enable_network 0` (If you read the line `CTRL_EVENT_CONNECTED`, you have successfully connected to the internet.
   - `save_config`
   - `quit`

 - To check if you have an internet connection:
   - `ping -c (this commands how many times do you want to check the ping) 3 google.com`

* If all is good, proceed partitioning the disks.

# 0.2 : Disk Partition
I'll use `fdisk` for this, I'm mostly used to this one and also recommend from the Wiki.

> [!NOTE]
> Check which disk is to be partitioned, you might nuke your other drive, you're stupid if that is.

### Usually, you'll need `boot`, `swap`, and `root`, In this case I will also use `ext4` (butterfs haha loooool)

### Boot
- Proceed as follows :
   - fdisk /dev/sdX (substitute X from the disk of your pc)
    - `p` (list partition)
    - (assuming you have not deleted them yet) `d` (delete partition)
    - (disks deleted, make a new one) `g` (creates a gpt partition)
    - `n` (new partition, click enter until last sector)
    - (create efi partition) `+1G` (recommended, but not lower than `300mb`)
    - `t` (mark partition)
    - `1` (you have now created the boot partition)

  ### Swap
- Don't quit yet, we're not done partitioning just yet
   - `n` (new parti)
   - Enter again until last sector
   - `+[your swap size]` deciding to add or not, your choice, then again, it's highly recommended.
   - `t` (check partition number, you did boot earlier, and that's listed as 1, so check if its selected as 2)
   - `19` (you have now created your swap)

  ### Root
  - The easiest lol
    - `n`
    - spam enter
    - done

>[!NOTE]
> It's a good idea to check your partitions again if they are listed and correctly assigned to the right partitions.

(If satisfied, append `w` and it will automatically exit `fdisk`)

>[!IMPORTANT]
> Before we begin, we need to format our partitions we made.

> [!IMPORTANT]
> Double check the partitions with `lsblk`, don't be stupid to format the wrong partition.

- To format our root partition with Ext4
   - `mkfs.ext4 /dev/sdX` (replace X with root partition)
     
- Format our efi partition to FAT32
  - `mkfs.vfat -F 32 /dev/sdX` (replace X with EFI partition)
 
- Create and Activate Swap
   - `mkswap /dev/sdX`
   - `swapon /dev/sdX` (wherein X is the swap partition, duh)

### Mounting Partitions

 Now that we have formatted our partitions, we need to mount them so we can install our Gentoo System on our pc.

 - Create a directory w/ efi
    - `mkdir --parents /mnt/gentoo`
    - `mkdir --parents /mnt/gentoo/efi`

 - Mount the root partition
    - `mount /dev/sdXn` (Where X is the root partition, N for the number of the partition, e.g /dev/sda3)

# 0.3 : Stage Tarball, Emerge
 This section covers downloading the tarball, extracting, setting up portage and performing system update.

### I took the OpenRC w/ Desktop Profile. This includes some stuff (llvm etc) and whatever shit you don't compile (for now, oh and to get you started for installing a DE or a WM after install)
> I'll prob research on this bit, but thanks to Alx, he did say go for desktop profiles, u da man

Alright, since you're on tty, no GUI, how do we get our tarball? We use `links`, `wget` works, but with `links` you can access the Gentoo Website even on a tty.

>[!NOTE]
> Beforehand, we set the date first. You don't want a system that has a 2009 date set do you?

- Append as follows:
   - `date mm/dd/hh/mm/yy` (e.g 040112002024)
   - Note that the clock uses Military Time. 12nn past uses 1300 and so on.

  Alright, got the date set, now we sleep.

>[!NOTE]
>cd into `/mnt/gentoo` beforehand so our tarball will be downloaded there.

 Alright, let's use links to get our tarball

 - Make sure you have changed directory.
 -  `links https://www.gentoo.org/downloads/#amd64-advanced`
 -  Find "Stage Archives", "Stage 3", and then enter on `desktop profile | openrc`

   ### A prompt will appear that it's a downloadable link, follow what it says, and wait for the tarball to complete.

   Suppose you're done with downloading it, click `q` to exit links.

## Extracting the Tarball
  >[!NOTE]
> Make sure you're into `/mnt/gentoo`, to make sure you have the downloaded tarball, use `ls` (This will list all the files in the directory, as of now, it should only have a folder called `lost+found`, and the tarball we downloaded)

  - To extract the tarball ;
  - `tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner`
  - Depending on your system, this would take a bit. But hey, the beefier, the better.

## Chrooting into the system
>[!NOTE]
> Before we proceed, it's necessary to copy the dns info so that we still have our internet upon chrooting.

- Do so by passing `--dereference` option to the `cp` command.
  - `cp --dereference /etc/resolv.conf /mnt/gentoo/etc/`

# Mounting Filesystems
- Before we chroot, let's mount our filesystem first do that everything we do from this point will be saved on our new gentoo install.

> [!TIP]
> Assuming you have used the Gentoo ISO, simply do `arch-chroot /mnt/gentoo`.

  
  Finally, let's source `/etc/profile` and also to make sure we are chrooted.

  
  - `source /etc/profile`
  - `export PS1="(chroot) ${PS1}"`

> [!IMPORTANT]
> wait i forgot
  

### Configuring `make.conf`

>[!CAUTION]
> You should know what are you doing with configuring your compile options, failure to do so may end in an unexpected outcome.


    

