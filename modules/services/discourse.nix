{ pkgs, lib, ... }:
let
  discourseHost = "discourse.bsdg.org";
in
{
  security.acme = {
    acceptTerms = lib.mkDefault true;
    defaults.email = lib.mkDefault "justin@randoneering.tech";
  };

  services.discourse.database.host = "ep-damp-sound-akvk9hsd-pooler.c-3.us-west-2.aws.neon.tech";
  services.discourse.database.username = "discourse";
  services.discourse.database.passwordFile = "/apps/discourse/bsdg_pass";

  services.discourse = {
    enable = true;
    hostname = discourseHost;
    enableACME = true;

    admin.skipCreate = true;

    redis = {
      host = "127.0.0.1";
      useSSL = false;
    };

    mail = {
      notificationEmailAddress = "noreply@${discourseHost}";
      contactEmailAddress = "admin@${discourseHost}";
    };

    backendSettings = {
      force_hostname = true;
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
    appendHttpConfig = ''
      server_tokens off;
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
