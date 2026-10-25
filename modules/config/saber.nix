{ ... }: {
  flake.nixosModules.saber = { pkgs, ... }: {
    users.users.saber = {
      isNormalUser = true;
      description = "saber";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };

    security.sudo.extraConfig = ''
      Defaults env_keep += "SSH_AUTH_SOCK"
    '';
  };
}
