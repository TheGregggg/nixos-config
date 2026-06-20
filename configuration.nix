# This use the HOSTNAME env variable to determine which configuration to built
# It import the base modules and the machine configuration.
{lib, ...}: let
  sources = import ./npins;

  pkgs = import sources.nixpkgs {};

  home-manager = sources.home-manager {};
  lanzaboote = import sources.lanzaboote {inherit pkgs;};

  hostnameEnv = builtins.getEnv "HOSTNAME";
  hostname =
    if hostnameEnv == ""
    then throw "HOSTNAME is not set."
    else hostnameEnv;

  modules =
    [
      ./modules
      ./hosts/${hostname}
      (import "${home-manager}/nixos")

      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit hostname;};
          users.gregoire = import ./home;
        };
      }
    ]
    ++ lib.optionals (hostname == "gregwork") [lanzaboote.nixosModules.lanzaboote];
in {
  imports = modules;
}
