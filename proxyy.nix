{ config, pkgs, lib, ... }:

{
  options = {
    proxyy.enable = lib.mkEnableOption "enable le proxies >:)";
  };
  config = lib.mkIf config.proxyy.enable {
    programs.proxychains = {
      enable = true;
      chain.type = "dynamic";
      proxies = 
      { myproxy1 = { 
          enable = true;
          type = "socks5";
          host = "188.191.164.55";
          port = "4890";
        };
        myproxy2 = {
          enable = true;
          type = "http";
          host = "95.66.244.250";
          port = "443";
        };
        myproxy3 = {
          enable = true;
          type = "http";
          host = "46.28.88.19";
          port = "8080";
        };
      };
    };
  };
}
