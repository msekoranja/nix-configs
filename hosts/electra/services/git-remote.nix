{ config, lib, persistence, pkgs, ... }:
{

  environment.persistence = lib.mkIf persistence {
    "/persist".directories = [
      "/srv/git"
    ];
  };

  users = {
    users.git = {
      home = "/srv/git";
      createHome = true;
      homeMode = "755";
      isSystemUser = true;
      shell = "${pkgs.git}/bin/git-shell";
      group = "git";
      packages = [ pkgs.git ];
      openssh.authorizedKeys.keys = config.users.users.misterio.openssh.authorizedKeys.keys;
    };
    groups.git = { };
  };
}