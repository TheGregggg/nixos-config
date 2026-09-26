{pkgs, ...}: let
  wordpress-theme-erma = pkgs.stdenv.mkDerivation rec {
    name = "erma";
    version = "1.0.11";
    src = pkgs.fetchzip {
      url = "https://downloads.wordpress.org/theme/erma.${version}.zip";
      hash = "sha256-EI8hCx19mz2PrGbH3EUJ/MIv7+zNgNPbMj7DTThHI4o=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };
in {
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
        WP_DEFAULT_THEME = "erma";
      };

      themes = {
        inherit wordpress-theme-erma;
      };

      extraConfig = ''
        $_SERVER['HTTPS']='on';
      '';
    };
  };
}
