{ inputs, outputs, config, lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      user = {
        email = "40955683+marc0246@users.noreply.github.com";
        name = "marc0246";
      };
    };
    signing = {
      format = "openpgp";
      key = "7C39D3F6447830F2";
      signByDefault = true;
    };
  };
}
