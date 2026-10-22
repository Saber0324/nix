{ self, ... }: {
  flake.nixosModules.desktop = { config, ... }: {
    imports = with self.nixosModules; [
      hyprland
      noctalia
      apps
    ];
  };
}
