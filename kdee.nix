{ config, pkgs, lib, ... }:

{
  options = {
    kdee.enable = lib.mkEnableOption "enable KDE Plasma";
  };
  config = lib.mkIf config.kdee.enable {
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.Plasma.default = [ "gtk" ];
      config.common.default = [ "gtk" ];
    };


    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
