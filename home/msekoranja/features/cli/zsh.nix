{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster"; # make sure you have powerline fonts installed
    };

    plugins = [ { name = "fzf-tab"; src = "${pkgs.zsh-fzf-tab}/share/fzf-tab"; } ];

    shellAliases = {
      extract = ''
        () {
          if [ -f $1 ] ; then
            case $1 in
              *.tar.bz2)   tar xvjf $1    ;;
              *.tar.gz)    tar xvzf $1    ;;
              *.tar.xz)    tar Jxvf $1    ;;
              *.bz2)       bunzip2 $1     ;;
              *.rar)       rar x $1       ;;  
              *.gz)        gunzip $1      ;;
              *.tar)       tar xvf $1     ;;
              *.tbz2)      tar xvjf $1    ;;
              *.tgz)       tar xvzf $1    ;;
              *.zip)       unzip -d `echo $1 | sed 's/\(.*\)\.zip/\1/'` $1;;
              *.Z)         uncompress $1  ;;
              *.7z)        7z x $1        ;;
              *)           echo "don't know how to extract '$1'" ;;
            esac
          else
            echo "'$1' is not a valid file!"
          fi
        }'';
    };

    envExtra = ''
      ### Fix slowness of pastes with zsh-syntax-highlighting.zsh
      pasteinit() {
        OLD_SELF_INSERT=''${''${(s.:.)widgets[self-insert]}[2,3]}
        zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
      }

      pastefinish() {
        zle -N self-insert ''$OLD_SELF_INSERT
      }
      zstyle :bracketed-paste-magic paste-init pasteinit
      zstyle :bracketed-paste-magic paste-finish pastefinish
      ### Fix slowness of pastes
    '';

    initExtra = ''
      zstyle ':completion:*:descriptions' format '[%d]' 
    '';

  };
}
