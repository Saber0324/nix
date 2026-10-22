{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.nvim =
      (inputs.nix-wrapper-modules.lib.evalModule {
        inherit pkgs;

        imports = [
          inputs.nix-wrapper-modules.wrapperModules.neovim
        ];

        # Neovim wrapper options directly
        package = pkgs.neovim-unwrapped;
        binName = "nvim";

        # Define plugins/specs
        specs = {
          core = {
            data = [
              pkgs.vimPlugins.lazy-nvim
              pkgs.vimPlugins.telescope-nvim
              pkgs.vimPlugins.nvim-treesitter
            ];
          };
        };

        # Dependencies exposed in PATH for Neovim's LSPs and tools
        runtimePkgs = with pkgs; [
          git
          ripgrep
          fd
          bash-language-server
        ];
      }).config.wrapper;
  };

  flake.nixosModules.neovim = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.system}.nvim
    ];
    system.userActivationScripts.link-nvim = ''
      mkdir -p $HOME/.config
      ln -sfn ${./nvim} $HOME/.config/nvim
    '';
  };
}
