{ inputs, config, ... }: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = with config.nixosModules; [
      ./_hardware.nix
      desktop
      devenv
      gaming
      cli
      neovim
      nvidia
    ];
  };
}
