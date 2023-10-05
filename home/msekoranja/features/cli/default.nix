{ pkgs, ... }: {
  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    #./fish.nix
    ./fzf.nix
    #./gh.nix
    ./git.nix
    ./nix-index.nix
    ./screen.nix
    ./ssh.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    wget
    curl

    comma # Install and run programs by sticking a , before them
    #distrobox # Nice escape hatch, integrates docker images with my environment

    bc # Calculator
    bottom # System viewer
    ncdu # TUI disk usage
    eza # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    difftastic # Better diff
    jq # JSON pretty printer and manipulator
    neofetch # Get OS info (fastfech is not lightweight)
    magic-wormhole # File transfer

    nvd # Nix profile diff tool
    #nil # Nix LSP
    nixfmt # Nix formatter
    
    # zip tools for Windows env. compatibility
    zip
    unzip 

    #inputs.nh.default # nixos-rebuild and home-manager CLI wrapper
  ];
}
