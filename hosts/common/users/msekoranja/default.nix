{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = true; #TODO false;
  users.users.msekoranja = {
    isNormalUser = true;
    initialPassword = "changeme!";  # TODO
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
    ] ++ ifTheyExist [
      "video"
      "audio"
      "network"
      "wireshark"
      "i2c"
      "mysql"
      "docker"
      "podman"
      "git"
      "libvirtd"
    ];

    #openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/msekoranja/ssh.pub) ];
    packages = [ pkgs.home-manager ];
  };
  
  programs.zsh.enable = true;

  home-manager.users.msekoranja = import ../../../../home/msekoranja/${config.networking.hostName}.nix;
}
