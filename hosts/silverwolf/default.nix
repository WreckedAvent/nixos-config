{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.silverwolf = with inputs;
    nixpkgs.lib.nixosSystem {
      modules = [
        ./conf.nix
        ./hardware.nix

        catppuccin.nixosModules.catppuccin

        self.nixosModules.flake-nixpkgs

        nixos-hardware.nixosModules.framework-amd-ai-300-series

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs;};
            # backupFileExtension = "hm-backup" # enable for conflict resolution

            users.rileycat.imports = [
              self.homeModules.users-rileycat

              catppuccin.homeModules.catppuccin

              self.homeModules.unstable-packages
            ];
          };
        }
      ];
    };
}
