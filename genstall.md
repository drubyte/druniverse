# Gentoo UEFI Install 
> status : ongoing
> (not an install script)



System Specs
- Intel Pentium N4200 (4)
- 4GB RAM / 500GB HDD

> used to install on an i5 with 12gb RAM, but it has to stay on Windows.

Expected that you have read the [Gentoo Wiki](
https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/About)

* Prequities
    - A flashdrive
    - The Gentoo ISO
    - A brain
 

# 0.1 : Booting | Wi-Fi
Again, This tutorial is for (at least) experienced linux user.

### Connecting through [wpa_supplicant](https://wiki.archlinux.org/title/Wpa_supplicant)

This is straightforward and should be fast. If you're using Ethernet, skip this (problems may occur after install, I don't have ethernet cable so rely to the Wiki if it persists.)

# 0.2 : Disk Partition
I'll use `fdisk` for this, I'm mostly used to this one and also recommend from the Wiki.

> [!NOTE]
> Check which disk is to be partitioned, you might nuke your other drive, you're stupid if that is.

### Usually, you'll need `boot`, `swap`, and `root`, In this case I will also use `ext4` (butterfs haha loooool)

### Boot
- Proceed as follows :
   - fdisk /dev/sdaX (substitute X from the disk of your pc)
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

>[!NOTE]
> Before we begin, idk, let's just go

# 0.3 : Stage Tarball, Emerge
Wow that was quick, already into ~~balls~~ tarballs, let's get it 

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

-will continue-
    

