{ inputs, outputs, config, lib, pkgs, ... }: {
  programs.lazygit = {
    enable = true;
    settings = {
      autoForwardBranches = "none";
      git = {
        paging = {
          colorArg = "always";
          pager = "${pkgs.delta}/bin/delta --paging=never";
        };
        truncateCopiedCommitHashesTo = 40;
      };
      gui = {
        commitHashLength = 0;
        border = "single";
        nerdFontsVersion = "3";
        scrollHeight = 3;
        scrollOffMargin = 5;
        showCommandLog = false;
        showRandomTip = false;
        skipNoStagedFilesWarning = true;
        theme = with outputs.lib.palette; {
          inactiveBorderColor = [ "white" ];
          selectedLineBgColor = [ "${gray20}" ];
        };
      };
      update.method = "never";
    };
  };
}
