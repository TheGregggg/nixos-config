{
  description = "I use NixOS btw";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    lanzaboote,
    ...
  } @ inputs: let
    modulesTemplate = hostname: [
      ./hosts/${hostname}

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit hostname;};

          users.gregoire = import ./home;
        };
      }
    ];
  in {
    nixosConfigurations.gregtop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = modulesTemplate "gregtop";
    };
    nixosConfigurations.gregwork = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = modulesTemplate "gregwork" ++ [lanzaboote.nixosModules.lanzaboote];
    };
    nixosConfigurations.gregpc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = modulesTemplate "gregpc";
    };
  };
}
