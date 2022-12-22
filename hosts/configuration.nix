# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  # Configure keymap in X11
  services.xserver.layout = "us,ru";
  services.xserver.xkbOptions = "grp:escape,grp_led:caps";

  # Disabling default display manager
  services.xserver.displayManager.startx.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };


  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Remap x220 jap keyboar
  #   Input driver version is 1.0.1
  #   Input device ID: bus 0x11 vendor 0x1 product 0x1 version 0xab54
  # Currently doesn't work an activated by an actual /etc/udev/hwdb.d/98-local.hwdb file
  services.udev.extraHwdb = ''
    evdev:atkbd:dmi:bvnLENOVO:bvr*:bd*:svnLENOVO:pn42914CG:pvr*
      KEYBOARD_KEY_79=backspace
      KEYBOARD_KEY_7b=leftmeta
      KEYBOARD_KEY_38=leftctrl
      KEYBOARD_KEY_db=leftalt
      KEYBOARD_KEY_70=rightalt
      KEYBOARD_KEY_3a=escape
      KEYBOARD_KEY_01=capslock
    '';

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ejiek = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    bitwarden
    bitwarden-cli
    fira
    fira-code
    fira-mono
    firefox
    helix
    i3lock-color
    nodejs-16_x
    qutebrowser
    stow
    wget
    xorg.xmodmap
    zathura
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = false;

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
  system.stateVersion = "22.11"; # Did you read the comment?

  networking.networkmanager.enable = true;
}
