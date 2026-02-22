{
  config,
  username,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    package = pkgs.unstable.bash;
    bashrcExtra = ''
      eval $(ssh-agent)
      export PATH="/home/${username}/.local/bin:$PATH"
    '';
  };
}
