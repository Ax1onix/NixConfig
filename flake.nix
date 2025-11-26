{
  description = "A very basic flake for configuring NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem{
      modules = [
	./configuration.nix
	nvf.nixosModules.default
      ];
    };
  };
}
