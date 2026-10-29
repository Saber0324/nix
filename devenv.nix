{ pkgs, ... }: {
  languages.nix.enable = true;

  packages = with pkgs; [
    nixd # language server (alternative: nil)
    nixfmt # formatter
    statix # linter: anti-patterns and style
    deadnix # finds unused bindings
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
  };
}
