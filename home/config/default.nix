{
  config,
  lib,
  ...
}: let
  nixConfigPath = "${config.home.homeDirectory}/nixos-config/home/config";
  nvimPath = "${nixConfigPath}/nvim";
  vscodiumPath = "${nixConfigPath}/vscodium/settings.json";
  swayPath = "${nixConfigPath}/sway";
  ludusaviPath = "${nixConfigPath}/ludusavi/config.yaml";
in {
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
  xdg.configFile."VSCodium/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink vscodiumPath;
  xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${nixConfigPath}/starship.toml";
  xdg.configFile."sway".source = config.lib.file.mkOutOfStoreSymlink swayPath;
  xdg.configFile."ludusavi/config.yaml".source = config.lib.file.mkOutOfStoreSymlink ludusaviPath;
  home.file.".ssh/config".source = config.lib.file.mkOutOfStoreSymlink "${nixConfigPath}/.ssh/config";
}
