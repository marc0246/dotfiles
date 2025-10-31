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
    alacritty
    anki
    clang
    coreutils
    discord
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
    mold
    mpv
    obs-studio
    pavucontrol
    prismlauncher
    qbittorrent
    renderdoc
    ripgrep
    slurp
    ungoogled-chromium
    unzip
    wireguard-tools
    zip
  ];

  home.file."${config.home.homeDirectory}/.cargo/config.toml".text = ''
    [build]
    target-dir = "${config.home.homeDirectory}/.cargo/target"

    [target.x86_64-unknown-linux-gnu]
    linker = "${pkgs.clang}/bin/clang"
    rustflags = [
      "-Clink-arg=-fuse-ld=${pkgs.mold}/bin/mold",
      "-Clink-arg=-Wl,--no-rosegment",
      "-Ctarget-cpu=native",
    ]

    [profile.dev.build-override]
    opt-level = 3
    codegen-units = 1

    [profile.dev.package."*"]
    debug = "line-tables-only"

    [profile.rust-analyzer]
    inherits = "dev"
  '';

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

  programs.direnv = {
    enable = true;
    config = {
      whitelist.prefix = [ "/" ];
    };
    nix-direnv.enable = true;
  };

  programs.home-manager.enable = true;

  services.gnome-keyring.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 86400;
    pinentry.package = pkgs.pinentry-gtk2;
  };
}
