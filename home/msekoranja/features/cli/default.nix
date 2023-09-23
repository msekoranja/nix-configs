{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./bat.nix
    ./direnv.nix
    #./fish.nix
    #./gh.nix
    ./git.nix
    #./nix-index.nix
    ./pfetch.nix
    ./screen.nix
    ./shellcolor.nix
    ./ssh.nix
    ./starship.nix
  ];
  home.packages = with pkgs; [
    wget
    curl

    comma # Install and run programs by sticking a , before them
    #distrobox # Nice escape hatch, integrates docker images with my environment

    bc # Calculator
    bottom # System viewer
    ncdu # TUI disk usage
    #eza # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    diffsitter # Better diff
    jq # JSON pretty printer and manipulator

    nil # Nix LSP
    nixfmt # Nix formatter

    inputs.nh.default # nixos-rebuild and home-manager CLI wrapper
  ];
}
