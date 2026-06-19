{
  config,
  hostname,
  ...
}: {
  programs.git = {
    package = pkgs.gitFull;
    settings.user = {
      name = "Grégoire Layet";
      email = "git@gregoirelayet.com";
    };
    signing = {
      key = "${config.home.homeDirectory}/.ssh/${hostname}.pub";
      signByDefault = true;
    };
    settings = {
      gpg = {
        format = "ssh";
      };
    };
  };
}
