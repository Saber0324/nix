{ self, inputs, ... }: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = with self.nixosModules; [
      cli
      coding
      neovim
      desktop
      saber

      ./_hardware.nix

      { networking.hostName = "vm"; }
    ];
  };
}
