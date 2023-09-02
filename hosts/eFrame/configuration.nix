{ pkgs, nixos-hardware, ... }: {
  imports = [
    nixos-hardware.nixosModules.framework-12th-gen-intel
  ];

  # networking.useDHCP = true;
  networking.networkmanager.enable = true;

  # Enable sound.
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.logind = {
    powerKey = "ignore";
  };

  services.udev.extraHwdb = ''
  evdev:atkbd:dmi:bvn*:bvr*:bd*:svnFramework:pnLaptop*12thGenIntelCore*:pvr*
    KEYBOARD_KEY_3a=esc
    KEYBOARD_KEY_01=capslock
  '';

  environment.systemPackages = with pkgs; [
    bitwarden
    bluetuith
    chromium
    cider
    figlet
    fira
    fira-code
    fira-mono
    firefox
    gh
    gimp
    go
    gomuks
    helix
    inkscape
    k9s
    kind
    krita
    kubectl
    lf
    libwebp
    lolcat
    mattermost-desktop
    mpv
    nodejs
    pandoc
    pulumi-bin
    pw-volume
    ripgrep
    stow
    tdesktop
    tmate
    transmission
    trivy
    vhs
    virt-manager
    wget
    wireshark
    wluma
    xdg-utils
    yt-dlp
    zathura
    zellij
  ];
}
