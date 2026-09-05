# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
  ];

  # Use GRUB boot loader.
  boot = {
    loader.grub = {
      enable = true;
      useOSProber = true;
    };
    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
  };
  # Git Configuration
  programs = {
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account.
  users.users."saber" = {
    isNormalUser = true;
    description = "saber";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  security.sudo.extraConfig = ''
    Defaults env_keep += "SSH_AUTH_SOCK"
  '';

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    noctalia = {
      enable = true;
      systemd.enable = true;
    };

    noctalia-greeter = {
      enable = true;
    };

    zoxide.enable = true;

    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };
    git = {
      enable = true;
      config = {
        "url \"git@github.com:\"".pushInsteadOf = "https://github.com/";
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      interactiveShellInit = ''
        eval "$(zoxide init zsh)"
        eval "$(uv generate-shell-completion zsh)"


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
        nixconf = "nvim ~/.config/nix/configuration.nix";
        flakeconf = "nvim ~/.config/nix/flake.nix";
        flakeupdate = "(cd ~/.config/nix/ && nix flake update)";

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

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "bat";
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Apps
    neovim
    brave
    ghostty
    steam

    # From flake
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # C
    gnumake
    gcc

    # Rust toolchain
    rustc
    cargo
    rustfmt
    clippy

    # Utils
    ripgrep
    fd
    eza
    bat
    unzip
    zoxide
    fzf
    tree-sitter
    wget
    git
    fastfetch
    wl-clipboard

    # Nix LSP and tools
    nixd
    statix
    deadnix
    nixfmt
  ];

  # Manage dotfiles
  hjem.users.saber = {
    directory = "/home/saber";

    files = {
      ".zshrc".text = "";
      ".ssh/config".text = ''
        Host github.com
          HostName github.com
          User git
          IdentityFile ~/.ssh/id_ed25519
          AddKeysToAgent yes
      '';
    };
  };

  system.userActivationScripts.syncDotfiles.text = ''
    sync_repo() {
      local name="$1"
      local remote_url="$2"
      local flake_store_path="$3"
      local src="$HOME/dotfiles/$name"
      local dst="$HOME/.config/$name"

      mkdir -p "$HOME/dotfiles" "$HOME/.config"

      if [ ! -d "$src/.git" ]; then
        ${pkgs.git}/bin/git clone "$flake_store_path" "$src" || true
        ${pkgs.git}/bin/git -C "$src" remote set-url origin "$remote_url" || true
      else
        ${pkgs.git}/bin/git -C "$src" pull --rebase || true
      fi

      rm -rf "$dst"
      ln -sfn "$src" "$dst"
    }

    sync_repo "nvim" "https://github.com/Saber0324/nvimconf.git" "${inputs.nvim-config}"
    sync_repo "hypr" "https://github.com/Saber0324/hypr-config.git" "${inputs.hypr-config}"
  '';

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  networking = {
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Santo_Domingo";

  # Select internationalisation properties.
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
  system.stateVersion = "26.05"; # Did you read the comment?

}
