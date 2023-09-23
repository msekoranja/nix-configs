{ pkgs, lib, config, ... }:
  programs.git = {
    enable = true;
    aliases = {
      pushall = "!git remote | xargs -L1 git push --all";
      graph = "log --decorate --oneline --graph";
      add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
      fast-forward = "merge --ff-only";
    };
    userName = "Matej Sekoranja"; # TODO
    userEmail = "matej.sekoranja@gmail.com"; # TODO
    extraConfig = {
      #user.signing.key = "";
      #commit.gpgSign = true;
      #gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
