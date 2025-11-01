{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "24.11";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices.cryptlvm = {
      device = "/dev/disk/by-uuid/60049681-51bc-4d65-bde2-bcdfff045e8b";
      bypassWorkqueues = true;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  environment.systemPackages = with pkgs; [
    lshw
    wl-clipboard
  ];

  fonts.packages = with pkgs; [
    fira-code
    fira-sans
    nerd-fonts.symbols-only
    noto-fonts-cjk-sans
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement.enable = false;
  };

  networking = {
    firewall.enable = false;
    hostName = "nixos";
    networkmanager.enable = true;
  };

  nix = {
    channel.enable = false;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" \
        && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.fish.enable = true;

  programs.sway.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  services.openssh.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  time.timeZone = "Europe/Vienna";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.marc = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
