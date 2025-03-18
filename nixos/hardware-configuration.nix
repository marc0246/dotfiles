{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9c1388be-82e8-47fa-b29d-70248a1d8012";
    fsType = "btrfs";
    options = [ "noatime" "compress=lzo" "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/9c1388be-82e8-47fa-b29d-70248a1d8012";
    fsType = "btrfs";
    options = [ "noatime" "compress=lzo" "subvol=@home" ];
  };

  fileSystems."/opt" = {
    device = "/dev/disk/by-uuid/9c1388be-82e8-47fa-b29d-70248a1d8012";
    fsType = "btrfs";
    options = [ "noatime" "compress=lzo" "subvol=@opt" ];
  };

  fileSystems."/srv" = {
    device = "/dev/disk/by-uuid/9c1388be-82e8-47fa-b29d-70248a1d8012";
    fsType = "btrfs";
    options = [ "noatime" "compress=lzo" "subvol=@srv" ];
  };

  fileSystems."/tmp" = {
    device = "/dev/disk/by-uuid/9c1388be-82e8-47fa-b29d-70248a1d8012";
    fsType = "btrfs";
    options = [ "noatime" "compress=lzo" "subvol=@tmp" ];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/9c1388be-82e8-47fa-b29d-70248a1d8012";
    fsType = "btrfs";
    options = [ "noatime" "compress=lzo" "subvol=@var" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/73A6-5BE0";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/fd3689dc-10cd-411f-8d3a-adf2cfef4f82"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp31s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
