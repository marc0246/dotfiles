{ inputs, outputs, config, lib, pkgs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language-server.rust-analyzer = {
        command = "rust-analyzer";
        config = {
          rust-analyzer.check.command = "clippy";
          rust-analyzer.checkOnSave.extraArgs = [ "--profile" "rust-analyzer" ];
        };
      };
    };
    settings = {
      theme = "city-lights";
      editor = {
        auto-pairs = false;
        bufferline = "always";
        color-modes = true;
        completion-trigger-len = 1;
        completion-replace = true;
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
      "diff.plus.gutter" = { fg = brightGreen; };
      "diff.minus.gutter" = { fg = brightRed; };
      "diff.delta.gutter" = { fg = brightViolet; };
      "function" = { fg = brightCyan; };
      "function.special" = { fg = gray53; };
      "keyword" = { fg = brightBlue; };
      "keyword.storage.modifier" = { fg = darkCyan; };
      "keyword.directive" = { fg = gray53; };
      "label" = { fg = cyan; };
      "markup" = { fg = gray53; };
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
      # "ui.picker.header" = {  };
      # "ui.picker.header.column" = {  };
      # "ui.picker.header.column.active" = {  };
      "ui.popup" = { fg = gray53; bg = gray11; };
      # "ui.popup.info" = {  };
      "ui.text" = { fg = gray53; };
      "ui.text.focus" = { bg = gray23; };
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
