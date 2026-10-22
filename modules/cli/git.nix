{ ... }: {
  flake.nixosModules.git = {
    programs.git = {
      enable = true;
      config = {
        "url \"git@github.com:\"".pushInsteadOf = "https://github.com/";
      };
    };
  };
}
