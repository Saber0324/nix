{ ... }: {
  flake.nixosModules.zsh = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      interactiveShellInit = ''
        eval "$(zoxide init zsh)"

        if [[ -n "$SNACKS_TERM" ]]; then
          clear
        else
          fastfetch
        fi

      '';

      ohMyZsh = {
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
        # Nix
        nixswitch-vm = "sudo nixos-rebuild switch --flake ~/.config/nix#vm";
        nixswitch = "sudo nixos-rebuild switch --flake ~/.config/nix#desktop";
        nixconf = "nvim ~/.config/nix/";
        flakeupdate = "cd ~/.config/nix/ && nix flake update && cd -";

        # Eza
        ls = "eza --icons=auto --color=auto --group-directories-first --git";

        # Zoxide
        cd = "z";
        cdi = "zi";

        # Bat
        cat = "bat -p";

        # Fd
        find = "fd";

        # Ripgrep
        grep = "rg";
      };
    };

  };
}
