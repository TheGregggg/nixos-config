Here are the findings on ubuntu before installing nixos:

```bash
# lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda       8:0    0   30G  0 disk 
├─sda1    8:1    0   29G  0 part /
├─sda14   8:14   0    4M  0 part 
├─sda15   8:15   0  106M  0 part /boot/efi
└─sda16 259:0    0  913M  0 part /boot
sr0      11:0    1 1024M  0 rom  
sr1      11:1    1    4M  0 ro
```

```bash
fdisk -l
Disk /dev/sda: 30 GiB, 32212254720 bytes, 62914560 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: EA4ABF59-D802-467D-8B53-F851754FDA36

Device       Start      End  Sectors  Size Type
/dev/sda1  2099200 62914526 60815327   29G Linux filesystem
/dev/sda14    2048    10239     8192    4M BIOS boot
/dev/sda15   10240   227327   217088  106M EFI System
/dev/sda16  227328  2097152  1869825  913M Linux extended boot

Partition table entries are not in disk order.
```