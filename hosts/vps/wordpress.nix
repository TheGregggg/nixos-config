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
}
