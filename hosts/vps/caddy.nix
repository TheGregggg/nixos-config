{...}: {
  networking.firewall.allowedTCPPorts = [80 443];

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
              precompressed gzip
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
    '';
  };
}
