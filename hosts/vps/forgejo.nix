{
  config,
  lib,
  ...
}: let
  cfg = config.services.forgejo;
  settings = cfg.settings;
  server = settings.server;
in {
  services.caddy.virtualHosts."${server.DOMAIN}".extraConfig = ''
    reverse_proxy 127.0.0.1:${lib.toString server.HTTP_PORT}
  '';

  systemd.tmpfiles.rules = [
    "d '${cfg.customDir}/public' - forgejo forgejo - -"
    "d '${cfg.customDir}/public/assets' - forgejo forgejo - -"
    "d '${cfg.customDir}/public/assets/img' - forgejo forgejo - -"
    "d '${cfg.customDir}/public/assets/css' - forgejo forgejo - -"
    "C+ '${cfg.customDir}/public/assets/css/theme-custom.css' - forgejo forgejo - ${./forgejo/theme-custom.css}"
    "L+ '${cfg.customDir}/public/assets/img/logo.svg' - forgejo forgejo - ${./forgejo/logo.svg}"
  ];

  services.openssh.settings.AllowUsers = [cfg.user];

  services.forgejo = {
    enable = true;
    database.type = "sqlite3";
    lfs.enable = true;
    settings = {
      DEFAULT = {
        APP_NAME = "La Forge de Greg";
      };
      server = {
        DOMAIN = "git.gregoirelayet.com";
        ROOT_URL = "https://${server.DOMAIN}/";
        HTTP_PORT = 3000;
        SSH_PORT = lib.head config.services.openssh.ports;
      };

      service.DISABLE_REGISTRATION = true;

      "ui.meta" = {
        AUTHOR = settings.DEFAULT.APP_NAME;
        DESCRIPTION = "Selfhosted, running Forgejo on NixOs";
        KEYWORDS = "gregggg,git,forge,forgejo";
      };
      ui = {
        DEFAULT_THEME = "custom";
        THEMES = "forgejo-auto,forgejo-light,forgejo-dark,custom";
      };

      # mailer = {
      #   ENABLED = true;
      #   SMTP_ADDR = "mail.example.com";
      #   FROM = "no-reply@gregoirelayet.com";
      #   USER = "no-reply@gregoirelayet.com";
      # };
    };
    # secrets = {
    #   mailer.PASSWD = config.age.secrets.forgejo-mailer-password.path;
    # };
  };

  # age.secrets.forgejo-mailer-password = {
  #   file = ../secrets/forgejo-mailer-password.age;
  #   mode = "400";
  #   owner = "forgejo";
  # };
}
