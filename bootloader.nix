{ config, pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = false;
    
    grub = {
      enable = true;
      device = "nodev";              # EFI (removable SSD)
      efiSupport = true;
      useOSProber = false;           # CRITICAL: No other OS detection
      # No extraEntries - keeps it clean/portable
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
