{ config, pkgs, ... }:
let
in
{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;

    extraConfig = /* vim */ ''
      "Tabs
      set tabstop=4 "4 char-wide tab
      set expandtab "Use spaces
      set softtabstop=0 "Use same length as 'tabstop'
      set shiftwidth=0 "Use same length as 'tabstop'
      "2 char-wide overrides
      augroup two_space_tab
        autocmd!
        autocmd FileType json,html,nix setlocal tabstop=2
      augroup END
    '';
  };
}
