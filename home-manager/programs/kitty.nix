{ inputs, outputs, config, lib, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    extraConfig = ''
      modify_font cell_height +2px
      modify_font cell_width -1px
    '';
    keybindings = {
      "ctrl+t" = "new_tab_with_cwd";
      "ctrl+w" = "close_tab";
      "ctrl+h" = "previous_tab";
      "ctrl+l" = "next_tab";
      "kitty_mod+h" = "move_tab_backward";
      "kitty_mod+l" = "move_tab_forward";
    };
    settings = with outputs.lib.palette; {
      active_tab_foreground = gray77;
      active_tab_background = gray11;
      active_tab_font_style = "normal";
      allow_remote_control = true;
      background = gray11;
      color0 = gray20;
      color1 = brightRed;
      color2 = brightGreen;
      color3 = brightYellow;
      color4 = brightBlue;
      color5 = brightViolet;
      color6 = brightCyan;
      color7 = gray53;
      color8 = gray32;
      color9 = brightRed;
      color10 = brightGreen;
      color11 = brightYellow;
      color12 = brightBlue;
      color13 = brightViolet;
      color14 = brightCyan;
      color15 = gray77;
      cursor = gray77;
      cursor_blink_interval = 0;
      cursor_text_color = gray14;
      font_family = "family='Fira Code' variable_name=FiraCodeRoman style=FiraCodeRoman-Medium";
      font_size = 12.0;
      foreground = gray77;
      inactive_tab_background = gray08;
      inactive_tab_foreground = gray53;
      placement_strategy = "top-left";
      selection_background = gray20;
      selection_foreground = "none";
      tab_bar_background = gray08;
      tab_bar_edge = "top";
      tab_bar_min_tabs = 1;
      tab_fade = "1";
      url_color = brightBlue;
    };
  };
}
