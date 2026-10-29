{ inputs, self, ... }: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };

    modules = [
      inputs.home-manager.nixosModules.home-manager

      self.nixosModules.config
      self.nixosModules.cli
      self.nixosModules.neovim
      self.nixosModules.desktop
      self.nixosModules.gaming
      self.nixosModules.nvidia

      ./_hardware.nix

      {
        networking.hostName = "desktop";
        system.stateVersion = "26.05";

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "bak";
          users.saber = {
            imports = with self.homeModules; [
              cli
              devenv
            ];
            home.stateVersion = "26.05";
          };
        };
      }
    ];
  };
}
