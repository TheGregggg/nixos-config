{config, ...}: let
  nixConfigPath = "${config.home.homeDirectory}/nixos-config/home/config";
  nvimPath = "${nixConfigPath}/nvim";
  # kittyPath = "${nixConfigPath}/kitty";
  vscodiumPath = "${nixConfigPath}/vscodium/settings.json";
in {
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
  # xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink kittyPath;
  xdg.configFile."VSCodium/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink vscodiumPath;
  home.file.".ssh/config".source = config.lib.file.mkOutOfStoreSymlink "${nixConfigPath}/.ssh/config";
}
