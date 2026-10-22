{ self, ... }: {
  flake.nixosModules.cli = { pkgs, ... }: {
    imports = with self.nixosModules; [
      git
      zsh
      ssh

      env
    ];

    environment.systemPackages = with pkgs; [
      eza
      fd
      ripgrep
      bat
      zoxide
      unzip
      wl-clipboard
      fastfetch
      wget
    ];

    programs.fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };
  };
}
