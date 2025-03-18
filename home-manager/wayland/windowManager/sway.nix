{ inputs, outputs, config, lib, pkgs, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      defaultWorkspace = "workspace number 1";
      modifier = "Mod4";
      terminal = "kitty -1 --instance-group global";

      bars = [{
        colors = with outputs.lib.palette; {
          activeWorkspace = {
            background = gray17;
            border = gray38;
            text = gray77;
          };
          background = "#000000";
          bindingMode = {
            background = backgroundRed;
            border = borderRed;
            text = gray77;
          };
          focusedWorkspace = {
            background = backgroundViolet;
            border = borderViolet;
            text = gray77;
          };
          inactiveWorkspace = {
            background = gray11;
            border = gray20;
            text = gray53;
          };
          separator = gray53;
          statusline = gray77;
          urgentWorkspace = {
            background = backgroundRed;
            border = borderRed;
            text = gray77;
          };
        };
        fonts = {
          names = [ "FiraCode" ];
          size = 9.5;
          style = "Medium";
        };
        hiddenState = "hide";
        mode = "dock";
        position = "top";
        statusCommand = "${pkgs.i3status}/bin/i3status";
        trayOutput = "primary";
        workspaceButtons = true;
        workspaceNumbers = true;
      }];
      colors = with outputs.lib.palette; {
        background = gray14;
        focused = {
          background = backgroundViolet;
          border = borderViolet;
          childBorder = borderViolet;
          indicator = borderViolet;
          text = gray77;
        };
        focusedInactive = {
          background = gray17;
          border = gray38;
          childBorder = gray38;
          indicator = gray38;
          text = gray77;
        };
        unfocused = {
          background = gray11;
          border = gray20;
          childBorder = gray20;
          indicator = gray20;
          text = gray53;
        };
        urgent = {
          background = backgroundRed;
          border = borderRed;
          childBorder = borderRed;
          indicator = borderRed;
          text = gray77;
        };
      };
      floating = {
        border = 1;
      };
      fonts = {
        names = [ "FiraSans" ];
        size = 8.75;
      };
      keybindings = lib.mkOptionDefault {
        # Screenshots a region of the screen and copies the PNG to the clipboard.
        "${modifier}+z" = ''exec grim -g "$(slurp)" - | wl-copy'';
        # Screenshots the entire screen and copies the PNG to the clipboard.
        "${modifier}+Shift+z" = ''exec grim - | wl-copy'';
        # Picks the color under the cursor and copies the hex code to the clipboard.
        "${modifier}+grave" = ''
          exec grim -g "$(slurp -p)" -t ppm - \
            | convert - -format '%[pixel:p{0,0}]' txt:- \
            | tail -n 1 \
            | cut -d ' ' -f 4 \
            | wl-copy -n'';
      };
      window = {
        border = 1;
        hideEdgeBorders = "both";
      };

      input = {
        "type:keyboard" = {
          xkb_options = "caps:swapescape,altwin:swap_alt_win";
          xkb_numlock = "enabled";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "-0.5";
        };
      };
    };
  };
}
