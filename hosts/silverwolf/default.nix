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
      ];
    };
}
