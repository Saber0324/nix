{ self, ... }: {
  flake.nixosModules.desktop = { ... }: {
    imports = with self.nixosModules; [
      hyprland
      noctalia
      apps
    ];
  };
}
