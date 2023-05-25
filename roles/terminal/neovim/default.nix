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
        package = pkgs.neovim-nightly;
        defaultEditor = true;
        extraPackages = with pkgs;
          mkIf cfg.dev [
            fzf
            fd
            alejandra
            ripgrep
          ];
      };
      # Raw symlink to the config directory. Plugins installation and synchronization is deferred to lazy.nvim
      xdg.configFile.nvim = mkIf cfg.dev {
        source = config.lib.file.mkOutOfStoreSymlink configDir;
      };
    };
  }
