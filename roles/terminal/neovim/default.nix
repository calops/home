{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.roles.terminal;
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
      # Raw symlink to the config directory. Plugins installation and synchronization is deferred to lazy.nvim
      xdg.configFile.nvim = {
        source = config.lib.file.mkOutOfStoreSymlink configDir;
      };
    };
  }
