# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "amd_iommu=on" "iommu=pt" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [ "amdgpu" "radeon" ];
  boot.extraModprobeConfig = "options vfio-pci ids=1002:731f,1002:ab38";
  boot.initrd.preDeviceCommands = ''
    DEVS="0000:0e:00.0 0000:0e:00.1"
    for DEV in $DEVS; do
      echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    done
    modprobe -i vfio-pci
  '';

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/feb20cd4-eecc-4325-9985-bc030ae17cfe";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1A46-8AA7";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/fe55143d-e84d-4647-bcb7-1d10f0180e7d"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.video.hidpi.enable = lib.mkDefault true;

  nixpkgs.hostPlatform.system = "x86_64-linux";
}
