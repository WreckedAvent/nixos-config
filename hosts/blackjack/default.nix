{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.blackjack = with inputs;
    nixpkgs.lib.nixosSystem {
      modules = [
        ./conf.nix
        ./hardware.nix

        catppuccin.nixosModules.catppuccin

        self.nixosModules.flake-nixpkgs
      ];
    };
}
