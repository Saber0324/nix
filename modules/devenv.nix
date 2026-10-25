flake.homeModules.devenv = { pkgs, ... }: {
  home.packages = [ pkgs.devenv ];

  programs.zsh.initContent = ''
    eval "$(devenv hook zsh)"
  '';
}
