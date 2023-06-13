{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.roles.terminal;
  palette = config.my.colors.palette;
  configDir = "${config.home.homeDirectory}/.config/home-manager/roles/terminal/neovim/config";
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
        ];
      };
      # Raw symlink to the lazy plugin manager lock file, so that it stays writeable
      xdg.configFile."nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink configDir + "/lazy-lock.json";
      xdg.configFile."nvim/lua/nix/palette.lua".text = "return ${lib.generators.toLua {} palette}";
      xdg.configFile.nvim = {
        source = configDir;
        recursive = true;
      };
    };
  }
