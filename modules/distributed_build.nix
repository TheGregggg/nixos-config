{pkgs, ...}: {
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  nix.settings.max-jobs = "auto"; # local build slots
  nix.settings.cores = 0;

  nix.buildMachines = [
    {
      hostName = "gregbox";
      sshUser = "remotebuild";
      sshKey = "/root/.ssh/remotebuild";
      system = pkgs.stdenv.hostPlatform.system;
      supportedFeatures = ["nixos-test" "kvm"];
    }
  ];
}
