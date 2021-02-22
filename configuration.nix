# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{


  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader = {
    grub.enable = true;
    grub.version = 2;
    grub.device = "/dev/sda"; # or "nodev" for efi only
    grub.useOSProber = true; # Find other OS
  };

  networking = {
    hostName = "nixos";
    # wireless.enable = true;  # Wireless via wpa_supplicant. incompatible with networkmanager
    networkmanager.enable = true;

    firewall.enable = false;

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
        exportConfiguration = true;

	## Configure keymap in X11
        # layout = "us,it";
        layout = "es";
	xkbVariant = "cat";
        xkbOptions = "eurosign:e, compose:menu, grp:alt_space_toggle";
	
	# Enable the plasma 5 Desktop Environment. 
	enable = true;
	# displayManager.sddm.enable = true;         
	# desktopManager.plasma5.enable = true;
	displayManager.lightdm.enable = true;         
        windowManager.awesome.enable = true;
      };

      # Enable CUPS to print documents.
      printing.enable = true;

      # Performance
      # Only keep the last 500MiB of systemd journal.
      journald.extraConfig = "SystemMaxUse=500M";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eloi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };
  security.doas.enable = true;

  # PACKAGES 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    time
    doas # Root provileges
    #nox # Package manager
    wget neovim
    git curl
    tree htop
    #neofetch
    rg #ripgrep
    lf # file explorer
    home-manager

# Internet
    brave qutebrowser

# Terminal
    alacritty
    zsh dash fish
#    r-mathpix
    zathura # minimalist PDF viewer

    sxhkd # Hotkey daemon
    
  ];

  programs = {
    zsh.ohMyZsh = {
      enable = true;
      plugins = [ "man" ];
      theme = "agnoster";
    };
    fish.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

