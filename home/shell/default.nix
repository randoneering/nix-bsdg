{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./fish.nix
    ./atuin.nix
    ./bash.nix
    ./starship.nix
    ./neovim.nix
  ];
}
