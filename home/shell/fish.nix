{config, pkgs, username, ...}: {
  programs.fish = {
    enable = true;
    package = pkgs.unstable.fish;
    interactiveShellInit = ''
      eval ssh-agent
      export PATH="/home/${username}.local/bin:$PATH"
    '';
  };
}
