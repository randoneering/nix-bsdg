# nix-bsdg

Nix flake for Boise Software Development Group servers.

## What this repo does

- Defines NixOS host configuration for `nix-bsdg`
- Organizes shared modules under `modules/`
- Includes a Discourse service module with ACME HTTPS support

## BSDG links

- Website: https://bsdg.dev/
- Meetup: https://www.meetup.com/bsdg-meetup/
- Boise Code Camp: https://boisecodecamp.com/#/

## Discourse HTTPS

The Discourse module is configured to use ACME certificates via nginx.

For valid certificates, ensure:

- `services.discourse.hostname` is a real public domain
- DNS points that domain to this server
- Ports `80` and `443` are reachable
- `security.acme.acceptTerms = true`
- `security.acme.defaults.email` is set to a real email

## Validate and deploy

```bash
nix flake check "path:."
sudo nixos-rebuild switch --flake .#nix-bsdg
```
