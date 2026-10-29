_: {
  flake.nixosModules.hyprland = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    system.userActivationScripts.link-hypr = ''
      mkdir -p $HOME/.config
      ln -sfn ${./hypr} $HOME/.config/hypr
    '';
  };
}
