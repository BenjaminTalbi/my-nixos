{ lib, config, inputs, ... }:
# Some DRY functions and variables
let
  # This path will be used to resolve mkHotReloadSymlink path. It's prepended to the paramenter path. 
  configFolder = "${config.home.homeDirectory}/my-nixos";
in
{
  # This takes a path (not a string) to create a symlink for a regular .config folder.
  # Use this when you want/need hot reloading or need to use the config on Windows where Nix can't be used
  getPath = path: (configFolder + lib.strings.removePrefix (toString inputs.self) (toString path));
}
