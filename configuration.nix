# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./filesystems.nix             # Your custom portable mounts (overrides)
      ./bootloader.nix              # GRUB EFI/removable
      ./kdee.nix
      ./graphics.nix
      ./proxyy.nix
    ];


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  #Import other config files
  kdee.enable = true;
  graphics.enable = true;
  proxyy.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.axionix = {
    isNormalUser = true;
    description = "Axionix";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  

  programs.git = {
    enable = true;
    config = {
      user.name = "Ax1onix";
      user.email = "yanio.tut@gmail.com";
    };
  };
  # Install firefox.
  programs.firefox = {
    enable = true;
    policies.Homepage.StartPage = "https://search.nixos.org";
    policies.DisableTelemetry = true;

  };
  


  programs.zsh = {
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "z"
      ];
      theme = "darkblood";
    };
  };

  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings = {
      vim.theme = {
	enable = true;
	name = "tokyonight";
        style = "moon";
      };
      vim.statusline.lualine.enable = true;
      vim.telescope.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;

      vim.languages = {
	enableTreesitter = true;

	nix.enable = true;
	python.enable = true;
	rust.enable = true;
      };
    };
  };
  programs.obs-studio.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     fastfetch
     cmatrix
     tmux
     seclists
     wget
     thc-hydra
     hashcat
     burpsuite
     nuclei
     nuclei-templates
     wireshark
     netcat
     nmap
     gobuster
     gowitness
     telegram-desktop
     vesktop
     sherlock
     libreoffice-qt6-fresh
     vlc
     nodejs
     ghidra-bin
     python314
     zoom-us
     wezterm
     openvpn
     go 
     httpie
     jq
     qbittorrent
     obsidian
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  #NIXOS EXPERIMENTAL
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  
}
