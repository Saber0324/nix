{ self, inputs, ... }: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      inputs.home-manager.nixosModules.home-manager

      self.nixosModules.config
      self.nixosModules.cli
      self.nixosModules.neovim
      self.nixosModules.desktop

      ./_hardware.nix

      {
        networking.hostName = "vm";
        system.stateVersion = "26.05";

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "bak";
          users.saber = {
            imports = with self.homeModules; [ cli devenv ];
            home.stateVersion = "26.05";
          };
        };
      }
    ];
  };
}
