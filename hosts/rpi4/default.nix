{ pkgs, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.raspberry-pi-4

    ./hardware-configuration.nix

    ../common/global
    ../common/users/msekoranja
  ];

  networking = {
    hostName = "rpi4";
    useDHCP = true;
    interfaces.eth0 = {
      useDHCP = true;
      wakeOnLan.enable = true;

      # Static IP address
      #ipv4.addresses = [{
      #  address = "192.168.1.123";
      #  prefixLength = 24;
      #}];
    };
  };

  # Workaround for https://github.com/NixOS/nixpkgs/issues/154163
  nixpkgs.overlays = [(final: prev: {
    makeModulesClosure = x: prev.makeModulesClosure (x // { allowMissing = true; });
  })];

  nixpkgs.hostPlatform.system = "aarch64-linux";
  system.stateVersion = "23.11";
}