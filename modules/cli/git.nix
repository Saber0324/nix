{ ... }: {
  flake.homeModules.git = {
    programs.git = {
      enable = true;
      settings = {
        "url \"git@github.com:\"".pushInsteadOf = "https://github.com/";
      };
    };
  };
}
