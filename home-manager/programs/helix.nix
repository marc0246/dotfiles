{ inputs, outputs, config, lib, pkgs, ... }: let
  lldbDapRustcPrimer = pkgs.writeScriptBin "lldb_dap_rustc_primer.py" ''
    import subprocess
    import pathlib
    import lldb

    # Determine the sysroot for the active Rust interpreter.
    sysroot = pathlib.Path(subprocess.getoutput('rustc --print sysroot'))
    rustlib_etc = sysroot / 'lib' / 'rustlib' / 'etc'
    if not rustlib_etc.exists():
        raise RuntimeError('Unable to determine rustc sysroot')

    # Load lldb_lookup.py and execute lldb_commands with the correct path.
    lldb.debugger.HandleCommand(f"""command script import "{rustlib_etc / 'lldb_lookup.py'}" """)
    lldb.debugger.HandleCommand(f"""command source -s 0 "{rustlib_etc / 'lldb_commands'}" """)
  '';
in {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language-server.rust-analyzer = {
        command = "rust-analyzer";
        config = {
          rust-analyzer.check.command = "clippy";
          rust-analyzer.check.extraArgs = [ "--profile" "rust-analyzer" ];
        };
      };
      language = [
        {
          name = "rust";
          debugger = {
            name = "lldb-dap";
            transport = "stdio";
            command = "${pkgs.lldb}/bin/lldb-dap";
            templates = [
              {
                name = "binary";
                request = "launch";
                completion = [ { name = "binary"; completion = "filename"; } ];
                args = {
                  program = "{0}";
                  initCommands = [
                    "command script import ${lldbDapRustcPrimer}/bin/lldb_dap_rustc_primer.py"
                  ];
                };
              }
            ];
          };
        }
      ];
    };
    settings = {
      theme = "city-lights";
      editor = {
        auto-pairs = false;
        bufferline = "always";
        color-modes = true;
        completion-trigger-len = 1;
        cursorline = true;
        gutters = {
          layout = [ "diff" "spacer" "diagnostics" "spacer" "line-numbers" "spacer" "spacer" ];
          line-numbers.min-width = 4;
        };
        indent-guides = {
          render = true;
          character = "▏";
        };
        line-number = "relative";
        rulers = [ 101 ];
        statusline = {
          right = [
            "diagnostics"
            "selections"
            "primary-selection-length"
            "register"
            "position"
            "file-encoding"
          ];
        };
        text-width = 100;
      };
      keys.normal = {
        A-h = "goto_previous_buffer";
        A-l = "goto_next_buffer";
      };
    };
    themes.city-lights = with outputs.lib.palette; {
      "attribute" = { fg = brightGreen; };
      "constant" = { fg = brightRed; };
      "comment" = { fg = gray32; };
      "constructor" = { fg = cyan; };
      "diff.delta.gutter" = { fg = brightViolet; };
      "diff.minus.gutter" = { fg = brightRed; };
      "diff.plus.gutter" = { fg = brightGreen; };
      "function" = { fg = brightCyan; };
      "function.special" = { fg = gray53; };
      "keyword" = { fg = brightBlue; };
      "keyword.directive" = { fg = gray53; };
      "keyword.storage.modifier" = { fg = darkCyan; };
      "label" = { fg = cyan; };
      "markup" = { fg = gray53; };
      "markup.bold" = { modifiers = [ "bold" ]; };
      "markup.heading" = { fg = gray77; };
      "markup.italic" = { modifiers = [ "italic" ]; };
      "markup.strikethrough" = { modifiers = [ "crossed_out" ]; };
      "namespace" = { fg = cyan; };
      "operator" = { fg = brightBlue; };
      "punctuation" = { fg = gray53; };
      "punctuation.delimiter" = { fg = brightBlue; };
      "string" = { fg = brightViolet; };
      "special" = { fg = brightCyan; };
      "tag" = { fg = darkCyan; };
      "type" = { fg = cyan; };
      "variable" = { fg = gray53; };
      "variable.builtin" = { fg = brightRed; };
      "variable.parameter" = { fg = brightYellow; };

      "ui.background" = { fg = gray53; bg = gray14; };
      "ui.background.separator" = { fg = gray53; };
      "ui.bufferline" = { fg = gray53; bg = gray11; };
      "ui.bufferline.active" = { fg = gray77; bg = gray14; };
      "ui.bufferline.background" = { bg = gray11; };
      "ui.cursor.insert" = { fg = gray14; bg = brightBlue; };
      "ui.cursor.match" = { fg = gray14; bg = gray53; };
      "ui.cursor.normal" = { fg = gray14; bg = gray53; };
      "ui.cursor.primary.insert" = { fg = gray14; bg = brightBlue; };
      "ui.cursor.primary.normal" = { fg = gray14; bg = gray77; };
      "ui.cursor.primary.select" = { fg = gray14; bg = brightRed; };
      "ui.cursor.select" = { fg = gray14; bg = brightRed; };
      "ui.cursorcolumn.primary" = { bg = gray17; };
      "ui.cursorline.primary" = { bg = gray17; };
      "ui.debug.breakpoint" = { fg = brightBlue; };
      "ui.debug.active" = { fg = brightYellow; };
      "ui.help" = { fg = gray32; bg = gray11; };
      "ui.highlight" = { bg = gray20; };
      # "ui.highlight.frameline" = {  };
      "ui.linenr" = { fg = gray32; };
      "ui.linenr.selected" = { fg = gray77; };
      "ui.menu" = { fg = gray53; bg = gray11; };
      "ui.menu.scroll" = { fg = gray53; bg = gray11; };
      "ui.menu.selected" = { fg = gray77; bg = gray23; };
      "ui.selection" = { bg = gray20; };
      "ui.statusline" = { fg = gray53; bg = gray11; };
      "ui.statusline.insert" = { fg = gray14; bg = brightBlue; };
      "ui.statusline.normal" = { fg = gray53; bg = gray11; };
      "ui.statusline.select" = { fg = gray14; bg = brightRed; };
      "ui.picker.header.column.active" = { fg = gray77; };
      "ui.popup" = { fg = gray53; bg = gray11; };
      # "ui.popup.info" = {  };
      "ui.text" = { fg = gray53; };
      "ui.virtual.ruler" = { bg = gray17; };
      "ui.virtual.whitespace" = { fg = gray20; };
      "ui.virtual.indent-guide" = { fg = gray20; };
      "ui.virtual.inlay-hint" = { fg = gray32; };
      "ui.virtual.wrap" = { fg = gray20; };
      # "ui.virtual.jump-label" = {  };
      "ui.window" = { fg = gray11; bg = gray11; };

      "diagnostic.deprecated" = { underline = { color = warning; style = "curl"; }; };
      "diagnostic.error" = { underline = { color = error; style = "curl"; }; };
      "diagnostic.hint" = { underline = { color = hint; style = "curl"; }; };
      "diagnostic.info" = { underline = { color = gray77; style = "curl"; }; };
      "diagnostic.unnecessary" = { underline = { color = warning; style = "curl"; }; };
      "diagnostic.warning" = { underline = { color = warning; style = "curl"; }; };
      "error" = { fg = error; };
      "hint" = { fg = hint; };
      "info" = { fg = gray77; };
      "warning" = { fg = warning; };

      # "tabstop" = {  };
    };
  };
}
