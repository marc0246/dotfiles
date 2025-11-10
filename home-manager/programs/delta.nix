{ inputs, outputs, config, lib, pkgs, ... }: {
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
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
}
