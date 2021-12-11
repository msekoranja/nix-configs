{ pkgs, config, lib, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ls = "exa";
      top = "btm";

      jqless = "jq -C | less -r";

      snrs = "sudo nixos-rebuild switch --flake /dotfiles";
      nrs = "nixos-rebuild switch --flake /dotfiles";
      hms = "home-manager switch --flake /dotfiles";

      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      m = "neomutt";
      mutt = "neomutt";

      s = "base16-shell";
    };
    shellAliases = {
      # Get ip
      getip = "curl ifconfig.me";
    };
    functions = {
      fish_greeting = "${pkgs.fortune}/bin/fortune -s";
      wh = "readlink -f (which $argv)";
      ssh = let shellcolor = "${pkgs.shellcolord}/bin/shellcolor"; in
        ''
          ${shellcolor} disable $fish_pid
          command ssh $argv
          ${shellcolor} enable $fish_pid
          ${shellcolor} apply $fish_pid
        '';
    };
    interactiveShellInit =
      # Use vim bindings and cursors
      ''
        fish_vi_key_bindings
        set fish_cursor_default     block      blink
        set fish_cursor_insert      line       blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual      block
      '' +
      # Use terminal colors
      ''
        set -U fish_color_autosuggestion      brblack
        set -U fish_color_cancel              -r
        set -U fish_color_command             brgreen
        set -U fish_color_comment             brmagenta
        set -U fish_color_cwd                 green
        set -U fish_color_cwd_root            red
        set -U fish_color_end                 brmagenta
        set -U fish_color_error               brred
        set -U fish_color_escape              brcyan
        set -U fish_color_history_current     --bold
        set -U fish_color_host                normal
        set -U fish_color_match               --background=brblue
        set -U fish_color_normal              normal
        set -U fish_color_operator            cyan
        set -U fish_color_param               brblue
        set -U fish_color_quote               yellow
        set -U fish_color_redirection         bryellow
        set -U fish_color_search_match        'bryellow' '--background=brblack'
        set -U fish_color_selection           'white' '--bold' '--background=brblack'
        set -U fish_color_status              red
        set -U fish_color_user                brgreen
        set -U fish_color_valid_path          --underline
        set -U fish_pager_color_completion    normal
        set -U fish_pager_color_description   yellow
        set -U fish_pager_color_prefix        'white' '--bold' '--underline'
        set -U fish_pager_color_progress      'brwhite' '--background=cyan'
      '' +
      # Start shellcolor daemon
      ''
        ${pkgs.shellcolord}/bin/shellcolord $fish_pid &
      '';

  };
  xdg.configFile."shellcolor.conf" = {
    text = let colors = config.colorscheme.colors; in ''
      base00=${colors.base00}
      base01=${colors.base01}
      base02=${colors.base02}
      base03=${colors.base03}
      base04=${colors.base04}
      base05=${colors.base05}
      base06=${colors.base06}
      base07=${colors.base07}
      base08=${colors.base08}
      base09=${colors.base09}
      base0A=${colors.base0A}
      base0B=${colors.base0B}
      base0C=${colors.base0C}
      base0D=${colors.base0D}
      base0E=${colors.base0E}
      base0F=${colors.base0F}
    '';
    onChange = ''
      timeout 1 ${pkgs.shellcolord}/bin/shellcolor apply || true
    '';
  };
}
