_: {
  flake.homeModules.git = { config, ... }: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Saber";
          email = "250929174+Saber0324@users.noreply.github.com";
          signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILb5qJfy5AmjkRsaNVYerVW1JEhX/tWC5ZWmQ+anMbFu";
        };
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
        };
        commit.gpgsign = true;
      };
    };
  };
}
