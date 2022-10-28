{ inputs, lib, config, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchefiVariables = ture;

  networking.hostName = "balvenie";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  services.xserver = {
    enable = true;
    displayManager.gmd.enable = ture;
    desktopManager.gnome.enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.openrazer = {
    enable = true;
    users = [ "dave" ];
  }; 

  users.users = {
    dave = {
      description = "Dave Debreceni";
      isNormalUser = true;
      extraGroups = [ "wheel" "libvirtd" "plugdev" "openrazer"]; 
    };
  };

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
    };
    spiceUSBRedirection.enable = true;
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/scream 0660 dave qemu-libvirtd -"
    "f /dev/shm/looking-glass 0660 dave qemu-libvirtd -"
  ];
  
  systemd.user.services.scream-ivshmem = {
    enable = true;
    description = "Scream IVSHMEM";
    serviceConfig = {
      ExecStart = "${pkgs.scream}/bin/scream-ivshmem-pulse /dev/shm/scream";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
    requires = [ "pulseaudio.service" ];
  };

  system.stateVersion = "22.05";
}

