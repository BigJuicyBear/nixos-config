{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./normalConfig.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Los_Angeles";

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

  # Display manager (el autologin de wini está en normalConfig.nix)
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.defaultSession = "niri";

  # Impresión
  services.printing.enable = true;
  services.upower.enable = true;

  # Usuario
  users.users."wini" = {
    isNormalUser = true;
    description = "wini";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      git
      neovim
      ghostty
    ];
 };

  programs.firefox.enable = true;

  # NO cambies esto después de la instalación inicial
  system.stateVersion = "26.05";

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ 41641 ];
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.zsh.enable = true;
  users.users.wini.shell = pkgs.zsh;

virtualisation.virtualbox.host.enable = true;
users.extraGroups.vboxusers.members = [ "wini" ];

}
