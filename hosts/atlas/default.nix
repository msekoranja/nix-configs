{ pkgs, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/msekoranja

    ../common/optional/quietboot.nix
  ];

  networking = {
    hostName = "atlas";
    useDHCP = true;
    interfaces.enp8s0 = {
      useDHCP = true;
      wakeOnLan.enable = true;

      ipv4 = {
        addresses = [{
          address = "192.168.0.12";
          prefixLength = 24;
        }];
      };
      ipv6 = {
        addresses = [{
          address = "2804:14d:8084:a484::2";
          prefixLength = 64;
        }];
      };
    };
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  services.hardware.openrgb.enable = true;
  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
    opentabletdriver.enable = true;
  };

  system.stateVersion = "22.05";
}
