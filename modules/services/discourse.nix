{ config, pkgs, lib, ... }:
let
  discourseHost = "discourse.bsdg.dev";
in
{
  security.acme = {
    acceptTerms = lib.mkDefault true;
    defaults.email = lib.mkDefault "justin@randoneering.tech";
  };

  services.discourse.database.host = "ep-damp-sound-akvk9hsd-pooler.c-3.us-west-2.aws.neon.tech";
  services.discourse.database.username = "discourse";
  services.discourse.database.passwordFile = "/apps/discourse/db_password";

  services.discourse = {
    enable = true;
    hostname = discourseHost;
    enableACME = true;
    secretKeyBaseFile = "/apps/discourse/secret_key_base";

    admin = {
      email = "admin@${discourseHost}";
      username = "admin";
      fullName = "BSDG Administrator";
      passwordFile = "/apps/discourse/admin_password";
    };

    redis = {
      host = "127.0.0.1";
      useSSL = false;
    };

    mail = {
      notificationEmailAddress = "noreply@${discourseHost}";
      contactEmailAddress = "admin@${discourseHost}";
    };

    backendSettings = {
      force_hostname = discourseHost;
      refresh_maxmind_db_during_precompile_days = 0;
      maxmind_backup_path = "/var/lib/discourse/maxmind";
      max_reqs_per_ip_per_minute = 120;
      max_reqs_per_ip_per_10_seconds = 30;
      max_asset_reqs_per_ip_per_10_seconds = 120;
      max_reqs_per_ip_mode = "block";
      force_https = true;
    };

    siteSettings = {
      required = {
        title = "Boise Software Development Group";
        site_description = "Boise SDG discussion forum";
      };
      security = {
        login_required = true;
      };
    };
  };

  services.nginx = {
    clientMaxBodySize = "64m";
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/discourse/maxmind 0750 discourse discourse -"
  ];

  systemd.services.discourse.serviceConfig.BindReadOnlyPaths = [
    "/var/lib/discourse/maxmind:${config.services.discourse.package}/share/discourse/vendor/data"
  ];

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
