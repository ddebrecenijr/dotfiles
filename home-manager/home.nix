{ inputs, lib, config, pkgs, ... }: {
  imports  = [ ];

  home.username = "dave";
  home.homeDirectory = "/home/dave";

  programs.git = {
    enable = true;
    userName = "Dave Debreceni";
    userEmail = "davidjr@debreceni.net";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  home.packages = with pkgs; [
    firefox
    alacritty
    vim
    
    pciutils
    virt-manager
    scream
    looking-glass-client
    gnomeExtensions.appindicator
    openrazer-daemon
    polychromatic
  ];

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;
  home.stateVersion = "22.05";
}
