{ config, pkgs, userSettings, inputs, lib, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "benjamintalbi";
    userEmail = "b.talbi@jst.ag";
  };

  imports = [
    ../../home/shared/packages.nix
    ../../home/nixvim
    ../../home/shell
    ../../home/nvim
  ];

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = userSettings.editor;
  };

  home.packages = with pkgs; [
    nodePackages_latest.nodejs
  ];

  # # Some DRY functions and variables
  # helpers = {
  #   # This path will be used to resolve mkHotReloadSymlink path. It's prepended to the paramenter path. 
  #   configFolder = "${config.home.homeDirectory}/my-nixos";
  #   # This takes a path (not a string) to create a symlink for a regular .config folder.
  #   # Use this when you want/need hot reloading or need to use the config on Windows where Nix can't be used
  #   mkHotReloadSymlink = path: (config.helpers.configFolder + lib.strings.removePrefix (toString inputs.self) (toString path));
  # };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

}
