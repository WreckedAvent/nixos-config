{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.blackjack = with inputs;
    nixpkgs.lib.nixosSystem {
      modules =
        [
          ./conf.nix
          ./hardware.nix
        ]
        ++ config.rcat.flake.nixosDefaults;
    };
}
