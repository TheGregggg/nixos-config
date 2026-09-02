{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.gregConfig.brave;
in {
  options.gregConfig.ydl = {
    enable = mkEnableOption "Enable youtube dl";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yt-dlp
    ];

    programs.bash.shellAliases = {
      ydl = "yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 320k -o \"%(title)s.%(ext)s\"";
    };
  };
}
