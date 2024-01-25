/*
The diagram below shows how certain LaTeX options influence item list spacing.
This was borrowed from page 145 of The LaTeX Companion.
F. Mittelbach, M. Goossens, J. Braams, D. Carlisle, and C. Rowley, The LaTeX Companion, 2nd ed. Addison-Wesley Professional, 2004.
It can similarly be found in the enumitem package manual.
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│                                Preceding Text                               │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                      | \topsep + \parskip [+ \partopsep]    │
│                                      |                                      │
│                                      |                                      │
│             \labelwidth              |                                      │
│             <--------   \labelsep    v                                      │
│             [ label ]<-----┌──────────────────────────────┐                 │
│                 ┌──────────┘                              │                 │
│                 │                                         │                 │
│                 │----->            Item 1                 │                 │
│                 │\itemindent                              │                 │
│                 └─────────────────────────────────────────┘                 │
│                                      | \parsep                              │
│                 \listparindent       v                                      │
│                 -------------->┌──────────────────────────┐                 │
│                 ┌──────────────┘                          │                 │
│     \leftmargin │                                         │ \rightmargin    │
│---------------->│           Item 1, Paragraph 2           │<----------------│
│                 │                                         │                 │
│                 └─────────────────────────────────────────┘                 │
│                                      | \itemsep + \parsep                   │
│                                      |                                      │
│                                      |                                      │
│                                      v                                      │
│             [ label ]      ┌──────────────────────────────┐                 │
│                 ┌──────────┘                              │                 │
│                 │                                         │                 │
│                 │                  Item 2                 │                 │
│                 │                                         │                 │
│                 └─────────────────────────────────────────┘                 │
│                                      | \topsep + \parskip [+ \partopsep]    │
│                                      |                                      │
│                                      |                                      │
│                                      |                                      │
│                                      v                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                                Following Text                               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
*/
{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  latexLib = import ../../lib/latex.nix {inherit lib;};
in {
  imports = [
    ../components/standardStringOut.nix
  ];
  options = {
    format = {
      spacing = {
        # vertical spacing
        topsep = lib.mkOption {
          description = ''The amount of extra vertical space (in addition to \parskip) inserted between the preceding text and the first list item, and between the last item and the following text. It is a rubber length.'';
          type = types.nullOr types.str;
          default = null;
        };
        partopsep = lib.mkOption {
          description = ''The extra vertical space (in addition to \topsep + \parskip) inserted, if the environment is preceded by a blank line, between the preceding text and the first list item and between the last item and the following text. It is a rubber length.'';
          type = types.nullOr types.str;
          default = null;
        };
        itemsep = lib.mkOption {
          description = ''The amount of extra vertical space (in addition to \parsep) inserted between successive list items. It is a rubber length.'';
          type = types.nullOr types.str;
          default = null;
        };
        parsep = lib.mkOption {
          description = ''The amount of vertical space between paragraphs within an item. It is the value to which \parskip is set within the list. It is a rubber length.'';
          type = types.nullOr types.str;
          default = null;
        };

        # horizontal spacing
        leftmargin = lib.mkOption {
          description = ''The horizontal distance between the left margin of the enclosing environment and the left margin of the list. It must be non-negative.'';
          type = types.nullOr types.str;
          default = null;
        };
        rightmargin = lib.mkOption {
          description = ''The horizontal distance between the right margin of the enclosing environment and the right margin of the list. It must be non-negative. Its default value is zero in the standard document classes.'';
          type = types.nullOr types.str;
          default = null;
        };
        listparindent = lib.mkOption {
          description = ''The amount of extra indentation added to the first line of every paragraph except the first one of an item. Its default value is zero in the standard document classes. It may have a negative value.'';
          type = types.nullOr types.str;
          default = null;
        };
        labelwidth = lib.mkOption {
          description = ''The normal width of the box that contains the label. It must be nonnegative.'';
          type = types.nullOr types.str;
          default = null;
        };
        labelsep = lib.mkOption {
          description = ''The space between the end of the box containing the label and the text of the first line of the item. It may be set to a negative length.'';
          type = types.nullOr types.str;
          default = null;
        };
        itemindent = lib.mkOption {
          description = ''The indentation of the first line of an item. Its default value is zero in the standard document classes. It may have a negative value.'';
          type = types.nullOr types.str;
          default = null;
        };
        _out = lib.mkOption {
          description = "This groups LaTeX output.";
          type = types.str;
          visible = false;
          internal = true;
          readOnly = true;
        };
      };

      compact = {
        nosep = lib.mkOption {
          description = ''Kills all vertical spacing.'';
          type = types.bool;
          default = false;
        };
        noitemsep = lib.mkOption {
          description = ''Kills the spacing between items and paragraphs (i.e., itemsep=0pt and parsep=0pt).'';
          type = types.bool;
          default = false;
        };
        _out = lib.mkOption {
          description = "This groups LaTeX output.";
          type = types.str;
          visible = false;
          internal = true;
          readOnly = true;
        };
      };

      penalty = {
        beginpenalty = lib.mkOption {
          description = ''Set the penalty at the beginning of a list.'';
          type = types.nullOr types.int;
          default = null;
        };
        midpenalty = lib.mkOption {
          description = ''Set the penalty between items.'';
          type = types.nullOr types.int;
          default = null;
        };
        endpenalty = lib.mkOption {
          description = ''Set the penalty at the end of a list.'';
          type = types.nullOr types.int;
          default = null;
        };
        _out = lib.mkOption {
          description = "This groups LaTeX output.";
          type = types.str;
          visible = false;
          internal = true;
          readOnly = true;
        };
      };

      _out = {
        latex = lib.mkOption {
          description = "This groups LaTeX output.";
          type = types.str;
          visible = false;
          internal = true;
          readOnly = true;
        };
      };
    };
  };
  config = {
    format = {
      spacing._out = (
        latexLib.combineOptions
        (
          name: value:
            if builtins.isNull value
            then ""
            else "${name}=${value}"
        )
        cfg.format.spacing
      );
      compact._out = (
        latexLib.combineOptions
        (
          name: value:
            if value
            then name
            else ""
        )
        (cfg.format.compact)
      );
      penalty._out = (
        latexLib.combineOptions
        (
          name: value:
            if builtins.isNull value
            then ""
            else "${name}=${builtins.toString value}"
        )
        (cfg.format.penalty)
      );
      _out = {
        latex = (
          latexLib.combineOptions
          (name: value: value._out)
          (cfg.format)
        );
      };
    };
  };
}
