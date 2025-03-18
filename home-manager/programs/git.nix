{ inputs, outputs, config, lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = with outputs.lib.palette; {
        dark = true;
        file-decoration-style = "white ol ul";
        file-style = "white";
        hunk-header-decoration-style = "none";
        hunk-header-style = "bright-black";
        line-numbers = true;
        line-numbers-left-format = " {nm:>4} ";
        line-numbers-minus-style = "red";
        line-numbers-plus-style = "green";
        line-numbers-right-format = " {np:>4} ";
        line-numbers-zero-style = "bright-black";
        minus-emph-style = "syntax '${diffMinusEmph}'";
        minus-empty-line-marker-style = "normal";
        minus-style = "syntax '${diffMinus}'";
        plus-emph-style = "syntax '${diffPlusEmph}'";
        plus-empty-line-marker-style = "normal";
        plus-style = "syntax '${diffPlus}'";
        syntax-theme = "city-lights";
      };
    };
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
    signing = {
      key = "7C39D3F6447830F2";
      signByDefault = true;
    };
    userEmail = "40955683+marc0246@users.noreply.github.com";
    userName = "marc0246";
  };
}
