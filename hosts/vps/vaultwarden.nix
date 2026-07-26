{
  config,
  pkgs,
  ...
}: let
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

  systemd.timers.backup-vaultwarden.timerConfig.OnCalendar = "*-*-* 01:00:00 Europe/Paris";

  systemd.timers."vaultwarden-backup-tar" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "*-*-* 02:00:00 Europe/Paris";
      Persistent = true; # run if missed last activation
      Unit = "vaultwarden-backup-tar.service";
    };
  };

  systemd.services."vaultwarden-backup-tar" = {
    path = [
      pkgs.gnutar
      pkgs.gzip
    ];
    description = "Backup vaultwarden files to a tarball";
    # no need to stop vaultwarden as this create an archive from the backup directory
    script = ''
      #!${pkgs.runtimeShell}
      filename=$(date +"%Y-%m-%d_%H-%M-%S")_vw.tar.gz
      mkdir -p /home/gregoire/backup-vaultwarden
      tar -C ${config.services.vaultwarden.backupDir} -czf /home/gregoire/backup-vaultwarden/$filename .
      chown -R gregoire /home/gregoire/backup-vaultwarden

      ## To test in one month
      ### delete all backups older than 7 days which are not made on a sunday
      # find /home/gregoire/backup-vaultwarden/ -mtime +7 -exec sh -c '[ $(date -r "{}" +%w) != 0 ] && rm "{}"' \;

      ### delete all backups older than 30 days which are not from the first week
      # find /home/gregoire/backup-vaultwarden/ -mtime +30 -exec sh -c '[ $(date -r "{}" +%d) -gt 7 ] && rm "{}"' \;

      ### delete all backups older than 365 days which are not from the first month
      # find /home/gregoire/backup-vaultwarden/ -mtime +365 -exec sh -c '[ $(date -r "{}" +%m) -gt 1 ] && rm "{}"' \;
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ProtectSystem = "full";
      NoNewPriviliges = true;
      ReadWritePaths = "/home/gregoire/backup-vaultwarden";
    };
  };
}
