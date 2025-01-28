{ ... }:

{
  programs.nushell = {
    enable = true;
    configFile.text = ''
      $env.config = {
          show_banner: false,
      }
    '';
    shellAliases = {
      cdnix = "cd ~/my-nixos/";
    };
    environmentVariables = {
      NVIM_HOME_MANAGER = 1;
    };
  };
}
