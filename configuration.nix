# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{ imports = [ ./hardware-configuration.nix ]; # Include results of the hardware scan.

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; # or "nodev" for efi only
    useOSProber = true; # Find other OS
  };
 # services.acpid.enable = true;

  networking = {
    hostName = "nixos";
    # wireless.enable = true;  # Wireless via wpa_supplicant. incompatible with networkmanager
    networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp5s0.useDHCP = true;
    interfaces.wlo1.useDHCP = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "ca_ES.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "es";
  };

  services = {
      xserver = {
	enable = true;
        exportConfiguration = true;

	## Configure keymap in X11
        layout = "es,ara";
	xkbVariant = "cat,buckwalter";
        xkbOptions = "eurosign:e, compose:menu, grp:alt_space_toggle";
	
	# Choose Display Manager / Window Manager / Desktop Environment. 
	# displayManager.sddm.enable = true;         
	displayManager.lightdm.enable = true;         
        windowManager.awesome.enable = true;
        desktopManager.xfce.enable = true;
      };

      # Enable CUPS to print documents.
      printing.enable = true;

      # Only keep the last 50MiB of systemd journal.
      journald.extraConfig = "SystemMaxUse=50M";
  };
  nix.autoOptimiseStore = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable xbacklight for users in the video group
  hardware.acpilight.enable = true;

  # Enable touchpad support (enabled by default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eloi_nix = {
    home = "/home/eloi_nix";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "shared" "video" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    uid = 1000;
  };
  users.groups.shared.gid = 1001; # I use this id for the group shared in all distros

  security.doas.enable = true;
  # security.sudo.enable = false;

  # PACKAGES 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    acpilight # xbacklight - Not needed in version 21.5
    time wget neovim git curl tree htop ripgrep
    lf                # File manager
    brave qutebrowser
    kitty             # Terminal
    zsh dash fish     # Shells
  ];
  environment.sessionVariables.EDITOR = "nvim";

  programs = { 
    zsh = {
      ohMyZsh = {
        enable = true;
        plugins = [ "man" ];
        theme = "agnoster"; 
      };
      syntaxHighlighting.enable = true;
      enableCompletion = true; 
      autosuggestions.strategy = "match_prev_cmd";
    };
    fish.enable = true;
  };
  
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Terminus" ]; })
    cozette
    dina-font
    noto-fonts
    cascadia-code
    noto-fonts-cjk
    noto-fonts-emoji
    terminus_font_ttf
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
