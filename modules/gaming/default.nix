{ self, ... }: {
  flake.nixosModules.gaming = {
    imports = with self.nixosModules; [
      steam
    ];

    environment.systemPackages = { pkgs, ... }: [
      (pkgs.prismlauncher.override {
        jdks = [
          pkgs.jdk21
          pkgs.jdk17
        ];
      })
    ];
  };
}
