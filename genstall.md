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
