# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  
  # Boot and kernel.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Locale and time.
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Desktop environment.
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    kate
    konsole
    plasma-browser-integration
    qrca
  ];

  # Networking and hardware.
  networking.hostName = "binraider";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  hardware.bluetooth.enable = true;

  # Services.
  services.flatpak.enable = true;
  services.printing.enable = true;
  virtualisation.docker = { enable = true; };

  # Audio stack.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Shell and CLI tools.
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--cmd cd" ];
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [ "HIST_IGNORE_ALL_DUPS" ];

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "essembeh";
    };
  };

  # Fonts.
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Users.
  users.defaultUserShell = pkgs.zsh;
  users.users."opossum" = {
    description = "Sera Cutler";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    isNormalUser = true;
    packages = with pkgs; [];
  };

  # Nix settings.
  nixpkgs.config.allowUnfree = true;

  # System packages.
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    fastfetch
    git
    ghostty
    kdePackages.sddm-kcm # KDE SDDM Manager
    vscode
    zoxide # Improved CD command
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
