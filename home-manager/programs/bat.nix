{ inputs, outputs, config, lib, pkgs, ... }: {
  programs.bat = {
    enable = true;
    config = {
      theme = "city-lights";
    };
  };

  home.file."${config.xdg.configHome}/bat/themes/city-lights.tmTheme".text = let
    attrsToXML = attrs: ''
      <?xml version="1.0" encoding="UTF-8"?>
      <plist version="1.0">
      ${attrsToXMLDict attrs}'';
    attrsToXMLDict = attrs: ''
      <dict>
      ${indent (lib.concatStringsSep "\n" (lib.mapAttrsToList attrToXMLKeyValue attrs))}
      </dict>'';
    attrToXMLKeyValue = key: value: ''
      <key>${key}</key>
      ${if lib.isString value then
        "<string>${value}</string>"
      else if lib.isList value then
        attrsToXMLArray value
      else
        attrsToXMLDict value}'';
    attrsToXMLArray = attrs: ''
      <array>
      ${indent (lib.concatMapStringsSep "\n" attrsToXMLDict attrs)}
      </array>'';
    indent = s: lib.concatMapStringsSep "\n" (s: "  " + s) (lib.splitString "\n" s);
    scopeList = lib.concatStringsSep ", ";
  in with outputs.lib.palette; attrsToXML {
    settings = [
      {
        settings = {
          foreground = gray53;
          gutterForeground = gray32;
        };
      }
      {
        scope = "comment";
        settings.foreground = gray32;
      }
      {
        scope = "constant";
        settings.foreground = brightRed;
      }
      {
        scope = "entity.name.constant";
        settings.foreground = brightRed;
      }
      {
        scope = scopeList [
          "entity.name.class"
          "entity.name.enum"
          "entity.name.impl"
          "entity.name.struct"
          "entity.name.type"
        ];
        settings.foreground = cyan;
      }
      {
        scope = "entity.name.label";
        settings.foreground = gray53;
      }
      {
        scope = "entity.name.function";
        settings.foreground = brightCyan;
      }
      {
        scope = "entity.name.namespace";
        settings.foreground = cyan;
      }
      {
        scope = "entity.name.tag";
        settings.foreground = darkCyan;
      }
      {
        scope = scopeList [ "entity.name.tag.toml" "entity.name.tag.yaml" ];
        settings.foreground = gray53;
      }
      {
        scope = "entity.other.attribute-name";
        settings.foreground = brightGreen;
      }
      {
        scope = scopeList [
          "entity.other.attribute-name.multipart.nix"
          "entity.other.attribute-name.single.nix"
        ];
        settings.foreground = gray53;
      }
      {
        scope = "entity.other.inherited-class";
        settings.foreground = cyan;
      }
      {
        scope = "keyword";
        settings.foreground = brightBlue;
      }
      {
        scope = "keyword.control.directive";
        settings.foreground = gray53;
      }
      {
        scope = "punctuation";
        settings.foreground = gray53;
      }
      {
        scope = scopeList [
          "punctuation.accessor"
          "punctuation.separator"
          "punctuation.terminator"
        ];
        settings.foreground = brightBlue;
      }
      {
        scope = "punctuation.definition.comment";
        settings.foreground = gray32;
      }
      {
        scope = scopeList [
          "punctuation.definition.keyword"
          "punctuation.definition.variable"
        ];
        settings.foreground = brightRed;
      }
      {
        scope = "punctuation.definition.string";
        settings.foreground = brightViolet;
      }
      {
        scope = "storage";
        settings.foreground = brightBlue;
      }
      {
        scope = "storage.modifier.lifetime";
        settings.foreground = cyan;
      }
      {
        scope = "storage.type.numeric";
        settings.foreground = brightRed;
      }
      {
        scope = "storage.type.string";
        settings.foreground = brightViolet;
      }
      {
        scope = "string";
        settings.foreground = brightViolet;
      }
      {
        scope = scopeList [ "support.class" "support.type" ];
        settings.foreground = cyan;
      }
      {
        scope = scopeList [ "support.function" "support.macro" ];
        settings.foreground = brightCyan;
      }
      {
        scope = "variable";
        settings.foreground = gray53;
      }
      {
        scope = scopeList [ "variable.language" "variable.other.constant" ];
        settings.foreground = brightRed;
      }
      {
        scope = "variable.parameter";
        settings.foreground = brightYellow;
      }
      {
        scope = "variable.parameter.generic";
        settings.foreground = cyan;
      }
      {
        scope = "variable.parameter.name.nix";
        settings.foreground = gray53;
      }
    ];
  };
}
