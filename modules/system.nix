{
  pkgs,
  lib,
  username,
  ...
}: {

  home-manager.backupFileExtension = "backup";

  nix.settings.trusted-users = [username];
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };
  environment.localBinInPath = true;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  #settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Allow electron garbage
  #
  nixpkgs.config.permittedInsecurePackages = ["electron-39.2.3"];
  # Set your time zone.
  time.timeZone = "America/Boise";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no"; # disable root login
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;

    };
  };
  services.fail2ban.enable = false;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
  ];
}
