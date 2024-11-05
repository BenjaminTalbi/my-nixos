{ pkgs, userSettings, ... }:

# Make sure virtualisation was enabled in EFI/BIOS
# Check with `egrep -c '(svm|vmx)' /proc/cpuinfo`
# Relevant documentation https://nixos.wiki/wiki/Virt-manager
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            # csmSupport = false;
            httpSupport = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;
  users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];
  # environment.systemPackages = with pkgs; [ spice-gtk ]; 
  # security.wrappers.spice-client-glib-usb-acl-helper.source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";
}
