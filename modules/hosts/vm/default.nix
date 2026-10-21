{ inputs, ... }: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ./_configuration.nix
      ./_hardware.nix
      { networking.hostName = "vm"; }
    ];
  };
}
