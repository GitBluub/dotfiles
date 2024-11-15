{pkgs, ...}: {
  programs.dconf.enable = true;
  services.dbus.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    git
    man-pages
    man-pages-posix
    vim
    tmux
    jq
    yq
    mosh
  ];
}
