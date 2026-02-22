{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/system.nix
    ../../modules/networking
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-c871bb59-eb54-4c23-9f32-f17ce20cf2d9".device =
    "/dev/disk/by-uuid/c871bb59-eb54-4c23-9f32-f17ce20cf2d9";
  networking.hostName = "nix-bsdg"; # Define your hostname.

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      443
      80
    ];
  };
  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
