{ pkgs, lib, ... }:
let
  discourseHost = "discourse.example.org";
in
{
  security.acme = {
    acceptTerms = lib.mkDefault true;
    defaults.email = lib.mkDefault "infra@example.org";
  };

  services.postgresql.package = pkgs.postgresql_15;

  services.discourse = {
    enable = true;
    hostname = discourseHost;
    enableACME = true;

    admin.skipCreate = true;

    database = {
      createLocally = true;
      pool = 20;
    };

    redis.host = "127.0.0.1";

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
    virtualHosts.${discourseHost}.extraConfig = ''
      add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;
      add_header X-Content-Type-Options "nosniff" always;
      add_header X-Frame-Options "SAMEORIGIN" always;
      add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
