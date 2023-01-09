{
  description = "Zach's Nix config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
  let 
    system = "x86_64-linux";
    
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in {
    homeConfigurations = {
        zach = home-manager.lib.homeManagerConfiguration {
          stateVersion = "22.11";
          inherit system pkgs;
          username = "zach";
          homeDirectory = "/home/zach";
          configuration = {
            imports = [
              ./user/zach/home.nix
            ];
          };
        };
      };

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;

        modules = [
          ./system/configuration.nix
        ];

      };
    };
  };
}
