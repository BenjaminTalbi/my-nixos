{ inputs, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../system/core
    ../../system/wm/hyprland.nix
    ../../system/stylix
    ../../system/boot/systemd.nix
    ../../system/stylix
    ../../system/security/automount.nix
    ../../system/optimization/store.nix
    ../../system/vm/virt-manager.nix
  ];

  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(custom, esc)";
        rightalt = "oneshot(custom)";
      };
      custom = {
        h = "left";
        k = "up";
        j = "down";
        l = "right";
        a = "macro(compose a \")";
        o = "macro(compose o \")";
        u = "macro(compose u \")";
        s = "macro(compose s s)";
      };
      "custom+shift" = { };
    };
  };

  networking = {
    useDHCP = false;
    bridges.br0.interfaces = [ "enp11s0" ];
    interfaces.br0.useDHCP = true;
    # interfaces.eth0.useDHCP = true;
    # interfaces.enp11s0.ipv4.addresses = [ ];
    # interfaces.enp11s0.ipv6.addresses = [ ];
  };

  environment.systemPackages = with pkgs; [
    google-chrome
    keyd
  ];

  fonts.packages = with pkgs; [
    inter
    (nerdfonts.override {
      fonts = [ "FiraCode" "JetBrainsMono" ];
    })
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";
}
