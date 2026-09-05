{
  description = "Saber's Rawring NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Dotfiles
    hypr-config = {
      url = "github:Saber0324/hypr";
      flake = false;
    };

    nvim-config = {
      url = "github:Saber0324/nvimconf";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      hjem,
      noctalia,
      noctalia-greeter,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            hjem.nixosModules.default
            noctalia-greeter.nixosModules.default
            ./hosts/vm/default.nix
          ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            hjem.nixosModules.default
            noctalia-greeter.nixosModules.default
            ./hosts/desktop/default.nix
          ];
        };
      };
    };
}
