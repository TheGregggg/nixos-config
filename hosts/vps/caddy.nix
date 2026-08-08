{config, ...}: {
  networking.firewall.allowedTCPPorts = [80 443];

  systemd.services.caddy.serviceConfig.EnvironmentFile = [config.age.secrets.caddyEnv.path];

  services.caddy = {
    enable = true;
    email = "acme@gregoirelayet.com";
    virtualHosts."gregoirelayet.com".extraConfig = ''
      header {
          X-Content-Type-Options nosniff
          X-Frame-Options SAMEORIGIN
          -Server
      }
      @cachedFiles {
          path *.ico *.css *.js *.gif *.webp *.avif *.jpg *.jpeg *.png *.svg *.woff *.woff2 *.ttf
      }
      header @cachedFiles {
          Cache-Control "public, max-age=31536000, immutable"
      }

      route {
          file_server * {
              root /var/www/ssg
              precompressed br gzip
          }
      }

      log {
        output file /var/log/caddy/gregoirelayet.log
        format filter {
            wrap json
            fields {
                request>remote_ip ip_mask {
                    ipv4 16
                    ipv6 32
                }
            }
        }
      }
    '';

    virtualHosts."enoraguiot.fr".extraConfig = ''
      header {
          X-Content-Type-Options nosniff
          X-Frame-Options SAMEORIGIN
          -Server
      }
      @cachedFiles {
          path *.ico *.css *.js *.gif *.webp *.avif *.jpg *.jpeg *.png *.svg *.woff *.woff2 *.ttf
      }
      header @cachedFiles {
          Cache-Control "public, max-age=31536000, immutable"
      }

      route {
          file_server * {
              root /var/www/enora
              precompressed gzip
          }
      }

      log {
        output file /var/log/caddy/enoraguiot.log
        format filter {
            wrap json
            fields {
                request>remote_ip ip_mask {
                    ipv4 16
                    ipv6 32
                }
            }
        }
      }
    '';

    virtualHosts."stats.gregoirelayet.com".extraConfig = ''
      root * /var/www/stats.gregoirelayet.com
      file_server

      basicauth argon2id {
          gregoire {$STATS_AUTH_HASH}
      }
    '';
  };
}
