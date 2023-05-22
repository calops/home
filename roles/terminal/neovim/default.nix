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
    options = {
      my.roles.terminal.neovim.full = mkEnableOption "Heavy-duty neovim dev setup";
    };
    config = {
      programs.neovim = {
        enable = cfg.enable;
        package = pkgs.neovim-nightly;
        extraPackages = with pkgs;
          mkIf cfg.neovim.full [
            fzf
            fd
            alejandra
          ];
      };
      # Raw symlink to the config directory. Plugins installation and synchronization is deferred to lazy.nvim
      xdg.configFile.nvim = mkIf (cfg.enable && cfg.neovim.full) {
        source = config.lib.file.mkOutOfStoreSymlink configDir;
      };
    };
  }
