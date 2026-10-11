{ config, pkgs, inputs, system, ... }: {

  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
  };

  home.packages = with pkgs; [
    xwayland-satellite
    wl-clipboard
    nautilus
  ];

  # symlink de niri
  xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-config/dotfiles/niri/config.kdl";

  # config de noctalia (v5, TOML)
  xdg.configFile."noctalia/config.toml".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-config/dotfiles/noctalia/config.toml";
}
