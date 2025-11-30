{
  description = "A very basic flake for configuring NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
  };

  outputs = { self, nixpkgs, nvf, zapret-discord-youtube }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem{
      system = "x86_64-linux";  # Add this line (required)
    
    
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
