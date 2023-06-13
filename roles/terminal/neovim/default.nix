{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.roles.terminal;
  palette = config.my.colors.palette;
  nvimDir = "${config.home.homeDirectory}/.config/home-manager/roles/terminal/neovim";
in
  with lib; {
    config = mkIf cfg.enable {
      programs.neovim = {
        enable = true;
        # We want gcc to override the system's one or treesitter throws a fit
        package = pkgs.neovim-nightly.overrideAttrs (attrs: {
          disallowedReferences = [];
          nativeBuildInputs = attrs.nativeBuildInputs ++ [pkgs.makeWrapper];
          postFixup = ''
            wrapProgram $out/bin/nvim --prefix PATH : ${lib.makeBinPath [pkgs.gcc]}
          '';
        });
        defaultEditor = true;
        extraPackages = with pkgs; [
          fzf
          alejandra
          stylua
        ];
      };
      xdg.configFile = {
        # Raw symlink to the plugin manager lock file, so that it stays writeable
        "nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "${nvimDir}/lazy-lock.json";
        "nvim/lua/nix/palette.lua".text = "return ${lib.generators.toLua {} palette}";
        "nvim" = {
          source = ./config;
          recursive = true;
        };
      };
    };
  }
