{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [
    ./programs/bat.nix
    ./programs/firefox.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/helix.nix
    ./programs/kitty.nix
    ./programs/lazygit.nix
    ./programs/vifm.nix
    ./wayland/windowManager/sway.nix
  ];

  home.homeDirectory = "/home/marc";
  home.username = "marc";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    coreutils
    ffmpeg
    gdb
    gimp
    gnupg
    grim
    htop
    imagemagick
    inkscape
    jq
    libreoffice
    mpv
    obs-studio
    pavucontrol
    qbittorrent
    ripgrep
    slurp
    unzip
    zip
  ];

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  programs.home-manager.enable = true;

  services.gnome-keyring.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 86400;
    pinentryPackage = pkgs.pinentry-gtk2;
  };
}
