{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.wsl = self.nixosConfigurations.rileyrose;
  flake.nixosConfigurations.rileyrose = with inputs;
    nixpkgs.lib.nixosSystem {
      modules = [
        ./conf.nix
        ./hardware.nix

        nixos-wsl.nixosModules.default
        {
          system.stateVersion = "24.05";
          wsl = {
            enable = true;
            defaultUser = "rileycat";
            startMenuLaunchers = true;
          };
        }

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            users."rileycat".imports = self.homeImports."rileycat";
          };
        }
      ];
    };
}
