{config, ...}: let
  domain = "gregpass";
in {
  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    # in order to avoid having  ADMIN_TOKEN in the nix store it can be also set with the help of an environment file
    # be aware that this file must be created by hand (or via secrets management like sops)
    environmentFile = "/var/lib/vaultwarden/vaultwarden.env";
    config = {
      DOMAIN = "https://${domain}.gregoirelayet.com";

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;

      SIGNUPS_ALLOWED = "false";

      LOG_FILE = "/data/vaultwarden.log";
      LOG_LEVEL = "warn";
      EXTENDED_LOGGING = "true";

      PUSH_ENABLED = "true";

      SMTP_SECURITY = "starttls";
    };
  };

  services.caddy.virtualHosts."bitwarden.example.com".extraConfig = ''
    encode zstd gzip

    reverse_proxy :${toString config.services.vaultwarden.config.ROCKET_PORT} {
        header_up X-Real-IP {remote_host}
    }
  '';
}
