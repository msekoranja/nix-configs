{
  programs.fzf = {
    enable = true;
    # CTRL+T (shamefully assumes bat, exa)
    fileWidgetOptions = [
      "--preview '(bat -p --color=always {} || exa --tree --level=4 --color=always {}) 2> /dev/null | head -200'"
      "--bind 'ctrl-t:change-preview-window(down|hidden|)'"
    ];
  };
}
