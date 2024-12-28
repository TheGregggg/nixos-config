{config, ...}: let
  configPath = "${config.home.homeDirectory}/nix-config/home/config";
  nvimPath = "${configPath}/nvim";
  kittyPath = "${configPath}/kitty";
  vscodiumPath = "${configPath}/vscodium/settings.json";
in {
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink nvimPath;
    recursive = true; # link recursively
    executable = true; # make all files executable
  };

  home.file.".config/kitty" = {
    source = config.lib.file.mkOutOfStoreSymlink kittyPath;
    recursive = true; # link recursively
    executable = true; # make all files executable
  };

  home.file.".config/VSCodium/User/settings.json" = config.lib.file.mkOutOfStoreSymlink vscodiumPath;
}
