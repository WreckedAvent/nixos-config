{pkgs, ...}: {
  imports = [
    ../audio.nix
    ../boot.nix
    ../coding.nix
    ../gaming.nix
    ../i18n.nix
    ../kde.nix
    ../networking.nix
    ../utils.nix
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = "nix-command flakes";

  services.printing.enable = true;

  users.users.rileycat = {
    isNormalUser = true;
    description = "riley k";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
  };

  catppuccin.enable = true;

  rcat = {
    boot = {
      systemd-boot = true;
      useLatestKernel = false;
    };

    coding = {
      lsp = true;
    };

    gaming = {
      steam = true;
      nvidia = true;
      gamescope = true;
      recorder = true;
    };

    networking = {
      hostName = "blackjack";
    };
  };

  # the version this file was generated with
  system.stateVersion = "25.05";
}
