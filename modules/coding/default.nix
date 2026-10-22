{ ... }: {
  flake.nixosModules.coding = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git

      # C
      gnumake
      gcc

      # Rust toolchain
      rustc
      cargo
      rustfmt
      clippy

      # Nix LSP and tools
      nixd
      statix
      deadnix
      nixfmt
    ];
  };
}
