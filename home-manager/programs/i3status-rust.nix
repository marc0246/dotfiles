{ inputs, outputs, config, lib, pkgs, ... }: {
  programs.i3status-rust = {
    enable = true;
    bars.default = {
      blocks = [
        {
          block = "keyboard_layout";
          driver = "sway";
          format = "<span foreground='#8cc1f2'>󰌌 </span>$layout   ";
          mappings = {
            "English (US)" = "US";
            "German (Austria)" = "AT";
            "Slovak (N/A)" = "SK";
          };
        }
        {
          block = "temperature";
          chip = "k10temp-pci-00c3";
          format = "<span foreground='#8cc1f2'> </span>$average ";
          interval = 1;
        }
        {
          block = "cpu";
          format = "$utilization ";
          interval = 1;
        }
        {
          block = "memory";
          format = "RAM: $mem_used_percents   ";
          interval = 1;
        }
        {
          block = "temperature";
          chip = "amdgpu-pci-2300";
          format = "<span foreground='#8cc1f2'>󰍹 </span>$average ";
          interval = 1;
        }
        {
          block = "amd_gpu";
          format = "$utilization VRAM: $vram_used_percents   ";
          interval = 1;
        }
        {
          block = "time";
          format = "<span foreground='#8cc1f2'>󰅐 </span>$timestamp.datetime(f:'%a, %d %b %Y, %R') ";
          interval = 1;
        }
      ];
      settings = {
        theme.theme = with outputs.lib.palette; "${pkgs.writeText "i3status-rust-config.toml" ''
          idle_bg = "#000000"
          idle_fg = "${gray77}"
          info_bg = "#000000"
          info_fg = "${gray77}"
          good_bg = "#000000"
          good_fg = "${gray77}"
          warning_bg  = "#000000"
          warning_fg  = "${brightYellow}"
          critical_bg = "#000000"
          critical_fg = "${brightRed}"
          separator = ""
          separator_bg = "#000000"
          separator_fg = "${gray53}"
        ''}";
      };
    };
  };
}
