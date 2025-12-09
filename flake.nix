{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    
    catppuccin.url = "github:catppuccin/nix/release-25.05"; 
    
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ({ withSystem, ... }: {
    systems = [ "x86_64-linux" "aarch64-linux" ];

    perSystem = { system, ... }: {
      # override nixpkgs with a configured one
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    };

    flake = {
      # add in packages from inputs
      homeModules.unstable-packages = { pkgs, ... }: {
        home.packages = [
          inputs.unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.zed-editor
        ];
      };

      # make sure our configurations use our nixpkgs
      nixosModules.flake-nixpkgs = { config, ... }: {
        nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system (
          { pkgs, ... }: # perSystem module arguments
          pkgs
        );
      };
    };
    
    imports = [
      # allow merging of hm configurations per flake part
      inputs.home-manager.flakeModules.home-manager

      # users
      ./users/rileycat
  
      # hosts
      ./hosts/silverwolf
      ./hosts/blackjack
    ];
  });
}
