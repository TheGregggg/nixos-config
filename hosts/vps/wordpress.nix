{pkgs, ...}: {
  services.wordpress = {
    webserver = "caddy";

    sites."romaneguillemard.fr" = {
      package = pkgs.wordpress_7_0;
      languages = [pkgs.wordpressPackages.languages.fr_FR];
      settings = {
        WPLANG = "fr_FR";
        FORCE_SSL_ADMIN = true;
        WP_HOME = "https://romaneguillemard.fr";
        WP_SITEURL = "https://romaneguillemard.fr";
        WP_DEFAULT_THEME = "twentytwentyone";
      };

      themes = {
        inherit
          (pkgs.wordpressPackages.themes)
          twentytwentyone
          ;
      };

      extraConfig = ''
        $_SERVER['HTTPS']='on';
      '';
    };
  };

  systemd.services."wordpress-backup-tar" = {
    path = [
      pkgs.gnutar
      pkgs.gzip
    ];
    description = "Backup wordpress files to a tarball";
    # no need to stop wordpress, DB backup is locked as one operation and files are copied afterwards
    script = ''
      #!${pkgs.runtimeShell}
      dir_name=$(date +"%Y-%m-%d_%H-%M-%S")
      filename=$dir_name.tar.gz
      sql_filename=$dir_name.sql
      mkdir -p /home/gregoire/backup-wordpress/$dir_name

      # dump DB
      mariadb-dump --lock-tables --databases wordpress > /home/gregoire/backup-wordpress/$dir_name/$sql_filename

      # copy files
      cp -R /var/lib/wordpress/ /home/gregoire/backup-wordpress/$dir_name

      # tar everything
      tar --remove-files -C /home/gregoire/backup-wordpress/$dir_name -czf /home/gregoire/backup-wordpress/$filename .
      chown -R gregoire /home/gregoire/backup-wordpress

      ### delete all backups older than 3 days which are not made on a sunday
      find /home/gregoire/backup-wordpress/ -mtime +3 -exec ${pkgs.bash}/bin/bash -c '[ $(date -r "{}" +%w) != 0 ] && rm "{}"' \;

      ### delete all backups older than 30 days which are not from the first week
      find /home/gregoire/backup-wordpress/ -mtime +30 -exec ${pkgs.bash}/bin/bash -c '[ $(date -r "{}" +%d) -gt 7 ] && rm "{}"' \;

      ### delete all backups older than 365 days which are not from the first month
      # find /home/gregoire/backup-wordpress/ -mtime +365 -exec ${pkgs.bash}/bin/bash  -c '[ $(date -r "{}" +%m) -gt 1 ] && rm "{}"' \;
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ProtectSystem = "full";
      NoNewPrivileges = true;
      ReadWritePaths = "/home/gregoire/backup-wordpress";
    };
  };
}
