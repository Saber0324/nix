{ inputs, lib, ... }: {
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  # 2. Configuración general de argumentos para los módulos
  perSystem = { system, pkgs, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };

  flake = {
    nixosModules = {
    };
  };
}
