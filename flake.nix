{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix/release-25.05"; 
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, unstable, home-manager, catppuccin, nixos-hardware }@inputs:
  let
    system = "x86_64-linux";
    pkgs-unstable = unstable.legacyPackages.${system};
  in {
    nixosConfigurations.silverwolf = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit pkgs-unstable; }; 
      modules = [
        ./configuration.nix

        catppuccin.nixosModules.catppuccin
        nixos-hardware.nixosModules.framework-amd-ai-300-series

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          #
          # enable with weird hm errors, grep for this extension to see what the problem is
          # home-manager.backupFileExtension = "hm-backup";
          # 
          home-manager.users.rileycat.imports = [
            ./rileycat.nix
            catppuccin.homeModules.catppuccin
          ];
        }
      ];
    };
  };
}
