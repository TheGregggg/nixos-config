{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.gregConfig.brave;
in {
  options.gregConfig.brave = {
    enable = mkEnableOption "Enable Brave";
    bitwarden = mkOption {
      type = lib.types.bool;
      default = true;
    };
    catpuccin-macchiato-theme = mkOption {
      type = lib.types.bool;
      default = true;
    };

    gestnote-ranking = mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.brave = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        (mkIf cfg.bitwarden {id = "nngceckbapebfimnlniiiahkandclblb";})
        (mkIf cfg.gestnote-ranking {id = "nnghgmgfiemkbmbfdiacfceanmpdgbcd";})
        (mkIf cfg.catpuccin-macchiato-theme {id = "cmpdlhmnmjhihmcfnigoememnffkimlk";})
      ];
      commandLineArgs = ["--password-store=gnome-libsecret"];
    };
  };
}
