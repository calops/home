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
    programs.neovim = {
      enable = cfg.enable;
      package = pkgs.neovim-nightly;
      extraPackages = with pkgs;
        mkIf cfg.dev [
          fzf
          fd
          alejandra
          ripgrep
        ];
    };
    # Raw symlink to the config directory. Plugins installation and synchronization is deferred to lazy.nvim
    xdg.configFile.nvim = mkIf (cfg.enable && cfg.dev) {
      source = config.lib.file.mkOutOfStoreSymlink configDir;
    };
  }
