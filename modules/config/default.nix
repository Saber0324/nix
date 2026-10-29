{ self, ... }: {
  flake.nixosModules.config = {
    imports = with self.nixosModules; [
      saber
      locale
      networking
      nix-settings
    ];
  };

  flake.nixOnDroidModules.config = { pkgs, ... }: {
    user.shell = "${pkgs.zsh}/bin/zsh";
    time.timeZone = "America/Santo_Domingo";

    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';

    environment.packages = with pkgs; [
      procps
      findutils
      gnugrep
      gnused
      gnutar
      gzip
      xz
      unzip
      openssh
    ];
  };
}
