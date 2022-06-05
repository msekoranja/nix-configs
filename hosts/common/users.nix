{ pkgs, config, lib, homeConfig, ... }:
let
  inherit (lib) mkIf;
  hasSway = homeConfig.wayland.windowManager.sway.enable or false;
in
{
  users.users.misterio = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ]
    ++ (if config.hardware.i2c.enable then [ "i2c" ] else [ ])
    ++ (if config.services.deluge.enable then [ "deluge" ] else [ ])
    ++ (if config.services.minecraft-server.enable then [ "minecraft" ] else [ ])
    ++ (if config.services.mysql.enable then [ "mysql" ] else [ ])
    ++ (if config.virtualisation.docker.enable then [ "docker" ] else [ ])
    ++ (if config.virtualisation.podman.enable then [ "podman" ] else [ ]);

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDci4wJghnRRSqQuX1z2xeaUR+p/muKzac0jw0mgpXE2T/3iVlMJJ3UXJ+tIbySP6ezt0GVmzejNOvUarPAm0tOcW6W0Ejys2Tj+HBRU19rcnUtf4vsKk8r5PW5MnwS8DqZonP5eEbhW2OrX5ZsVyDT+Bqrf39p3kOyWYLXT2wA7y928g8FcXOZjwjTaWGWtA+BxAvbJgXhU9cl/y45kF69rfmc3uOQmeXpKNyOlTk6ipSrOfJkcHgNFFeLnxhJ7rYxpoXnxbObGhaNqn7gc5mt+ek+fwFzZ8j6QSKFsPr0NzwTFG80IbyiyrnC/MeRNh7SQFPAESIEP8LK3PoNx2l1M+MjCQXsb4oIG2oYYMRa2yx8qZ3npUOzMYOkJFY1uI/UEE/j/PlQSzMHfpmWus4o2sijfr8OmVPGeoU/UnVPyINqHhyAd1d3Iji3y3LMVemHtp5wVcuswABC7IRVVKZYrMCXMiycY5n00ch6XTaXBwCY00y8B3Mzkd7Ofq98YHc= (none)"
    ];
    passwordFile = config.sops.secrets.misterio-password.path;
  };

  sops.secrets.misterio-password = {
    sopsFile = ./secrets/passwords.yaml;
    neededForUsers = true;
  };

  security.pam.services.swaylock = lib.mkIf hasSway { };
}