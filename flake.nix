{
  description = "A very basic flake for configuring NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
  };

  outputs = { self, nixpkgs, nvf, zen-browser, zapret-discord-youtube }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem{
      system = "x86_64-linux";  # Add this line (required)
    
      specialArgs = { inherit zen-browser; };  # Add this line (passes zen-browser to config)
    
      modules = [
	./configuration.nix
	nvf.nixosModules.default
        zapret-discord-youtube.nixosModules.default
        {
          services.zapret-discord-youtube = {
            enable = true;
            config = "general(ALT7)";  # Или любой конфиг из папки configs (general, general(ALT), general (SIMPLE FAKE) и т.д.)
          };
        }
      ];
    };
  };
}
