{ config, pkgs, ... }:

{
  fileSystems."/nix" = {
    device = "/dev/disk/by-label/NIXOS-SYSTEM";  # Your ext4 boot partition
    fsType = "ext4";
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-label/SHARED-DATA";   # Your exFAT shared partition
    fsType = "exfat";
    options = [ "defaults" "uid=1000" "gid=1000" "dmask=022" "fmask=133" ];
  };

  swapDevices = [ ];  # No swap on external SSD
}
