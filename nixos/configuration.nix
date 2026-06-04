{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "24.11";

  boot = {
    initrd.luks.devices.cryptlvm = {
      device = "/dev/disk/by-uuid/60049681-51bc-4d65-bde2-bcdfff045e8b";
      bypassWorkqueues = true;
    };
    kernelParams = [ "mem_sleep_default=deep" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    resumeDevice = "/dev/disk/by-uuid/fd3689dc-10cd-411f-8d3a-adf2cfef4f82";
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
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${lib.getExe (pkgs.procps)} --no-header --pid=$PPID --format=comm) != "fish" \
        && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${lib.getExe (pkgs.fish)} $LOGIN_OPTION
      fi
    '';
  };

  programs.fish.enable = true;

  services.logind.settings.Login = {
    IdleAction = "suspend-then-hibernate";
    IdleActionSec = "10m";
  };

  programs.steam.enable = true;

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

  systemd.sleep.settings.Sleep = {
    SuspendState = "mem";
    HibernateMode = "shutdown";
    HibernateDelaySec = "20m";
  };

  time.timeZone = "Europe/Vienna";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.marc = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
