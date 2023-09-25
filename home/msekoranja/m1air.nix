{ inputs, outputs, ... }: {
  imports = [
    ./global
  ];

  #colorscheme = inputs.nix-colors.colorschemes.tokyo-night-storm;
  home.homeDirectory = "/Users/msekoranja";
}
