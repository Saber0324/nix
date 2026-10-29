_: {
  flake.nixosModules.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Apps
      brave
      ghostty
    ];
  };
}
