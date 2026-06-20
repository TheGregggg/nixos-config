{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.gregConfig.nvim;
  nixConfigPath = "${config.home.homeDirectory}/nixos-config/home/config";
in {
  options.gregConfig.nvim = {
    enable = mkEnableOption "Enable NeoVim with dotfile symlink";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      sideloadInitLua = true; # home manager will not create init.lua
      withPython3 = false;
      withRuby = false;
    };

    # home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${nixConfigPath}/nvim";
      recursive = true;
    };
  };
}
