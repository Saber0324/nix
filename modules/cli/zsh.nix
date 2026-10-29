_: {
  flake.homeModules.zsh = { pkgs, ... }: {
    home.packages = with pkgs; [
      eza
      bat
      fd
      ripgrep
      fastfetch
    ];

    programs.zoxide.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        if [[ -n "$SNACKS_TERM" ]]; then
          clear
        else
          fastfetch
        fi
        eval "$(devenv hook zsh)"
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "colored-man-pages"
          "extract"
        ];
        theme = "agnoster";
      };

      shellAliases = {
        nixconf = "nvim ~/.config/nix/";
        flakeupdate = "cd ~/.config/nix/ && nix flake update && cd -";
        ls = "eza --icons=auto --color=auto --group-directories-first --git";
        cd = "z";
        cdi = "zi";
        cat = "bat -p";
        find = "fd";
        grep = "rg";
      };
    };
  };
  flake.nixosModules.zsh = { pkgs, ... }: {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
  };
}
