{ pkgs, lib, config, inputs, ... }:



let
  # Function to resolve the path to the real .config folder
  getPath = (pkgs.callPackage ../helpers.nix { inherit inputs config lib; }).getPath;
  configPath = getPath ./.config;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
        vimPlugins.nvim-treesitter.withAllGrammars
        nixd
        svelte-language-server
        lua-language-server        
      ];
  };

  xdg.configFile.neovim = {
    enable = true;
    # `config.lib.file.mkOutOfStoreSymlink` creates a symbolic link  TODO: Deepdive and describe the exact mechanisms
    source = config.lib.file.mkOutOfStoreSymlink configPath;
    target = "nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NVIM_HOME_MANAGER = 1;
  };

}
