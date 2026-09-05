{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
  ];

  networking.hostName = "vm";

  boot.loader.grub.device = "/dev/vda";

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
