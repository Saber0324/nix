_: {
  flake.nixosModules.steam = { pkgs, ... }: {
    programs.steam = {
      enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      gamescopeSession.enable = true;

      extraCompatPackages = [ pkgs.proton-ge-bin ];
      protontricks.enable = true;
    };

    gamemode.enable = true;
    gamescope.enable = true;
  };
}
