{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.roles.terminal;
in {
  options = {
    my.roles.terminal.enable = lib.mkEnableOption "Terminal utilities";
  };
  imports = [
    ./git.nix
    ./zellij.nix
    ./fish.nix
    ./neovim
    ./podman.nix
    ./ssh.nix
  ];
  config =
    lib.mkIf cfg.enable
    {
      home.packages = with pkgs; [
        bash
        fd
        ripgrep
        rm-improved
        xcp
        choose
        rargs
        sshfs
      ];

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.jujutsu = {
        enable = true;
        settings = {
          ui.default-command = "status";
        };
      };

      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
      programs.exa = {
        enable = true;
        icons = true;
        git = true;
      };
      programs.helix = {
        enable = true;
        settings = {
          theme = "catppuccin_mocha";
        };
      };
      stylix.targets.helix.enable = false;
      programs.btop = {
        enable = true;
        settings = {
          color_theme = "Default";
          theme_background = false;
        };
      };
      programs.starship = {
        enable = true;
        settings = {
          nix_shell.symbol = " ";
          rust.symbol = " ";
          nodejs.symbol = " ";
          package.symbol = " ";
          aws.symbol = " ";
          git_branch.symbol = "שׂ ";
          hostname = {
            ssh_symbol = " ";
            style = "bold blink bright-red";
          };
        };
      };
      programs.skim = {
        enable = true;
        defaultCommand = "fd --color=always";
        defaultOptions = ["--ansi"];
        fileWidgetCommand = "fd --color=always";
        fileWidgetOptions = ["--ansi" "--preview '~/scripts/preview.sh {}'"];
        changeDirWidgetCommand = "fd --type d --color=always";
      };
      programs.bat = {
        enable = true;
        config = {
          theme = "catppuccin";
          pager = "--RAW-CONTROL-CHARS --quit-if-one-screen --mouse";
          style = "plain";
          color = "always";
          italic-text = "always";
        };
        extraPackages = with pkgs.bat-extras; [
          batdiff
          batman
          batgrep
          batwatch
        ];
        themes = {
          catppuccin = builtins.readFile (pkgs.fetchFromGitHub
            {
              owner = "catppuccin";
              repo = "bat";
              rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
              sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
            }
            + "/Catppuccin-mocha.tmTheme");
        };
      };
      stylix.targets.bat.enable = false;
    };
}
