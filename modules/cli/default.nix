{ self, ... }: {
  flake.homeModules.cli = { pkgs, ... }: {
    imports = with self.homeModules; [
      git
      zsh
      ssh
      env
    ];

    home.packages = with pkgs; [
      eza
      fd
      ripgrep
      bat
      unzip
      fastfetch
      wget
    ];

    programs.fzf.enable = true;
  };

  flake.nixosModules.cli = { pkgs, ... }: {
    imports = with self.nixosModules; [
      zsh
      ssh
    ];

    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];
  };
}
