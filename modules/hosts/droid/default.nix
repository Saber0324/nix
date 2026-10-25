{ self, inputs, ... }: {
  flake.nixOnDroidConfigurations.default =
    inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "aarch64-linux";
        config.allowUnfree = true;
        overlays = [ inputs.nix-on-droid.overlays.default ];
      };

      home-manager-path = inputs.home-manager.outPath;

      modules = [
        self.nixOnDroidModules.config

        {
          system.stateVersion = "24.05";

          home-manager = {
            useGlobalPkgs = true;
            backupFileExtension = "bak";
            config = {
              imports = with self.homeModules; [ cli ];
              home.stateVersion = "24.05";
            };
          };
        }
      ];
    };
}
