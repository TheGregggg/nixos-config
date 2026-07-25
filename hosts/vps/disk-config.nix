{lib, ...}: {
  disko.devices.disk.main = {
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        bios = {
          name = "bios";
          size = "4M";
          type = "EF02";
          priority = 1;
        };

        esp = {
          name = "ESP";
          size = "106M";
          type = "EF00"; # EFI System
          priority = 2;
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot/efi";
            mountOptions = ["umask=0077"];
          };
        };

        boot = {
          name = "boot";
          size = "913M";
          priority = 3;
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/boot";
          };
        };

        root = {
          name = "root";
          size = "100%";
          priority = 4;
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
