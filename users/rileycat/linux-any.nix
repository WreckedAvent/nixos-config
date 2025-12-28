{pkgs, ...}: {
  # settings that need a linux native host
  rcat.terminal.alacritty = true;

  home.packages = with pkgs; [
    easyeffects
    usbimager
  ];
}
