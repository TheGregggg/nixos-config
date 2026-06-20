{pkgs, ...}: {
  home.packages = with pkgs; [
    starship
  ];

  programs.bash = {
    enable = true; # you always want a shell activated :)
    enableCompletion = true;
    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      HISTCONTROL=ignoreboth

      eval "$(starship init bash)"
    '';

    shellAliases = {
      ll = "ls -alh";
      vi = "nvim";
      gcm = "git commit -s -m";
      gca = "git commit --amend";
      ydl = "yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 320k -o \"%(title)s.%(ext)s\"";
      rebootwindob = "systemctl reboot --boot-loader-entry=windows_10.conf";
    };
  };
}
