{ pkgs, lib, config, inputs, ... }:

{
  xdg.configFile.neovim = {
    enable = true;
    # This symlinks our actual lua files instead of being created or copied to the read-only store 
    # This approch has the upside that we can edit files without rebuilding with HM and 
    # profit from hot reloading. This is not the nix-way but in this case we need to use Neovim on Windows where nix isn't available (yet?) 
    source = (pkgs.callPackage ../helpers.nix {inherit inputs config lib;}).mkHotReloadSymlink ./.config;
    # Kind of proud that I made that work. Kind of cool.
    target = "mvim";
  };
}
