_: {
  flake.nixosModules.noctalia = {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
    };
  };
}
