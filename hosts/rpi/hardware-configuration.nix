{lib, ...}: {
  boot.initrd.availableKernelModules = [];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  hardware.enableRedistributableFirmware = true;

  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 1 * 1024; # 1 GB
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
