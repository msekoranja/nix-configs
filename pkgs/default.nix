{ pkgs ? null }: {
  # My wallpaper collection
  wallpapers = pkgs.callPackage ./wallpapers { };

  # Packages with an actual source
  apgdiff = pkgs.callPackage ./apgdiff { };
  apgdiff-docker = pkgs.callPackage ./apgdiff/docker.nix { };
  argononed = pkgs.callPackage ./argononed { };
  clematis = pkgs.callPackage ./clematis { };
  gtklock = pkgs.callPackage ./gtklock { };
  rgbdaemon = pkgs.callPackage ./rgbdaemon { };
  shellcolord = pkgs.callPackage ./shellcolord { };
  swayfader = pkgs.callPackage ./swayfader { };
  trekscii = pkgs.callPackage ./trekscii { };

  # Personal scripts
  minicava = pkgs.callPackage ./minicava { };
  pass-wofi = pkgs.callPackage ./pass-wofi { };
  primary-xwayland = pkgs.callPackage ./primary-xwayland { };
  wl-mirror-pick = pkgs.callPackage ./wl-mirror-pick { };
  lyrics = pkgs.callPackage ./lyrics { };
}
