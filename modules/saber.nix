{ ... }: {
  flake.nixosModules.saber = { pkgs, ... }: {
    users.users."saber" = {
      isNormalUser = true;
      description = "saber";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.zsh;
    };

    system.stateVersion = "26.05";

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    networking = {
      networkmanager.enable = true;
    };

    time.timeZone = "America/Santo_Domingo";

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "es_DO.UTF-8";
        LC_IDENTIFICATION = "es_DO.UTF-8";
        LC_MEASUREMENT = "es_DO.UTF-8";
        LC_MONETARY = "es_DO.UTF-8";
        LC_NAME = "es_DO.UTF-8";
        LC_NUMERIC = "es_DO.UTF-8";
        LC_PAPER = "es_DO.UTF-8";
        LC_TELEPHONE = "es_DO.UTF-8";
        LC_TIME = "es_DO.UTF-8";
      };
    };

    security.sudo.extraConfig = ''
      Defaults env_keep += "SSH_AUTH_SOCK"
    '';

    nixpkgs.config.allowUnfree = true;
  };
}
