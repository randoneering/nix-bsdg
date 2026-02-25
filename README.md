# nix-bsdg

Nix flake for Boise Software Development Group infrastructure.

## Quick start

```bash
nix flake check "path:."
sudo nixos-rebuild switch --flake .#nix-bsdg
```

## Layout

- `hosts/nix-bsdg/default.nix`: host entrypoint
- `modules/`: shared NixOS modules
- `modules/services/discourse.nix`: Discourse + nginx + ACME settings

## Discourse notes

- Set `services.discourse.hostname` to the real public hostname.
- Keep `backendSettings.force_hostname` set to that same hostname string.
- Ensure DNS points to this server and ports `80`/`443` are reachable.

## BSDG links

- https://bsdg.dev/
- https://www.meetup.com/bsdg-meetup/
- https://boisecodecamp.com/
