{config, ...}: let
  domain = "gregpass";
in {
  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    # in order to avoid having  ADMIN_TOKEN in the nix store it can be also set with the help of an environment file
    # be aware that this file must be created by hand (or via secrets management like sops)
    environmentFile = config.age.secrets.vaultwardenEnv.path;
    config = {
      DOMAIN = "https://${domain}.gregoirelayet.com";

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;

      SIGNUPS_ALLOWED = "false";

      PUSH_ENABLED = "true";

      SMTP_HOST = "ssl0.ovh.net";
      SMTP_PORT = "587";
      SMTP_FROM = "no-reply@gregoirelayet.com";
      SMTP_SECURITY = "starttls";

      SMTP_USERNAME = "no-reply@gregoirelayet.com";
    };
  };

  services.caddy.virtualHosts."${domain}.gregoirelayet.com".extraConfig = ''
    encode zstd gzip

    reverse_proxy :${toString config.services.vaultwarden.config.ROCKET_PORT} {
        header_up X-Real-IP {remote_host}
    }
  '';
}
