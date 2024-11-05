{ userSettings, ... }:
# Home manager half for system/vms/default.nix
# See https://nixos.wiki/wiki/Virt-manager 
{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
