{pkgs, ...}: {
  system.activationScripts = {
    goaccessPermissions = ''
      mkdir -p /var/www/stats.gregoirelayet.com
      chown caddy:caddy /var/www/stats.gregoirelayet.com
      chmod 750 /var/www/stats.gregoirelayet.com
    '';
  };

  systemd.services.goaccess = {
    description = "Run goaccess to generate website statistics";
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.goaccess}/bin/goaccess -f /var/log/caddy/gregoirelayet.log -f /var/log/caddy/enoraguiot.log --log-format=CADDY -o /var/www/stats.gregoirelayet.com/index.html --persist'";
      User = "caddy";
    };
  };

  systemd.timers.goaccess = {
    description = "Run goaccess every 2 hours";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "1h";
    };
  };
}
