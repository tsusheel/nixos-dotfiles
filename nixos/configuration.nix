# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "sushi" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable Hyprland
  services.xserver.enable = true;
  programs.hyprland.enable = true;
  services.libinput.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "elarun";
  services.displayManager.defaultSession = "hyprland";
  
  # Enable Hypridle
  services.hypridle.enable = true;

  # Enabling for nautilus
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.dbus.enable = true; # ineed for nautilus

  users.groups.i2c = { };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sushi = {
    isNormalUser = true;
    description = "Sushil Thakur";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "disk" "storage" "i2c" ];
    packages = with pkgs; [];
  };

  # Allow ddcutil to run without sudo
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # ineed
    wget # ineed
    hyprland # ineed
    waybar # ineed
    alacritty # ineed
    rofi-wayland # ineed for menu
    swww # ineed for wallpapers
    networkmanagerapplet # ineed for wifi
    blueman # ineed for bluetooth
    gammastep # ineed for adjusting brightness temp
    brightnessctl # ineed for adjusting brightness
    ddcutil # ineed for adjusting monitor brightness
    pavucontrol # ineed for audio input output
    alsa-utils # ineed for audio input output
    wl-clipboard
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    bluez # ineed for bluetooth
    brave # ineed
    zsh # ineed
    git # ineed
    curl # ineed
    neovim # ineed
    hyprlock # ineed
    hyprcursor # ineed
    hyprshot # ineed
    capitaine-cursors # ineed
    chromium # ineed
    nautilus # ineed
    gvfs # ineed for nautilus
    glib # ineed for nautilus
    fuse3 # ineed for nautilus
    hyprpolkitagent # ineed for nautilus
    gnome-themes-extra # ineed for themes
    util-linux # ineed for calendar
    fzf # ineed for fuzzy finding
    jq # ineed for json querying
    htop # ineed for checking processes
    vlc # ineed as a media player
    sysstat # ineed for cpu core details
    tmux # ineed
    imv # ineed as image viewer
    swaynotificationcenter # ineed for notification
    stylua # ineed for nvim config
    gcc # ineed for nvim config and could be used even elsewhere
    unzip # ineed for nvim config
    gnumake # ineed for nvim config
    cmake # ineed for nvim config
    pkg-config # ineed for nvim config
    libtool # ineed for nvim config
    autoconf # ineed for nvim config
    automake # ineed for nvim config
    lua-language-server # ineed for nvim lua config
    ripgrep # ineed for nvim config
    fd # ineed for nvim config
    webcamoid # ineed for web cam
    obsidian # ineed for note taking
    nodejs_22 # ineed for development
    direnv # ineed for flake env setup
    nix-direnv # ineed for flake env setup
    inetutils # ineed for telnet
    postgresql # ineed for psql
    postman # ineed for postman
    dbeaver-bin # ineed for database client
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Set environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.variables = {
    XCURSOR_THEME = "capitaine-cursors";
    XCURSOR_SIZE = "24";
    GTK_THEME = "Adwaita-dark";
  };

  # Enable pipewire for audio
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # For input and hardware acceleration
  hardware.graphics.enable = true;
  services.pulseaudio.enable = false;
  services.printing.enable = false;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # auto-cpufreq for power management and power saving
  services.auto-cpufreq.enable = true;

  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
