{
  config,
  lib,
  hostname,
  ...
}: let
  workprefix =
    if hostname == "gregwork"
    then "gregwork/"
    else "";

  nixConfigPath = "${config.home.homeDirectory}/nixos-config/home/config";
  vscodiumPath = "${nixConfigPath}/vscodium/${workprefix}settings.json";
  swayPath = "${nixConfigPath}/sway";
  ludusaviPath = "${nixConfigPath}/ludusavi/config.yaml";
  footPath = "foot/foot.ini";
in {
  xdg.configFile."VSCodium/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink vscodiumPath;
  xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${nixConfigPath}/starship.toml";
  xdg.configFile."sway".source = config.lib.file.mkOutOfStoreSymlink swayPath;
  xdg.configFile."ludusavi/config.yaml".source = config.lib.file.mkOutOfStoreSymlink ludusaviPath;
  xdg.configFile.${footPath}.source = config.lib.file.mkOutOfStoreSymlink "${nixConfigPath}/${footPath}";
  home.file.".ssh/config".source = config.lib.file.mkOutOfStoreSymlink "${nixConfigPath}/.ssh/${workprefix}config";
}
