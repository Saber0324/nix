{ pkgs, ... }: {
  languages.nix.enable = true;

  packages = with pkgs; [
    nixd
    nixfmt
    statix
    deadnix
  ];

  git-hooks.hooks = {
    nixfmt = {
      enable = true;
      excludes = [ "_hardware\\.nix$" ];
    };
    statix = {
      enable = true;
      excludes = [ "_hardware\\.nix$" ];
    };
    deadnix.enable = true;

    flake-check = {
      enable = true;
      name = "nix flake check";
      entry = "nix flake check";
      language = "system";
      pass_filenames = false;
      always_run = true;
      stages = [ "pre-push" ];
    };
  };
}
