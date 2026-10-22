{ ... }: {
  flake.nixosModules.env = {
    environment.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "bat";
    };
  };
}
