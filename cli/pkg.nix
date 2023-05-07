{ pkgs, ... }: {
  imports = [
    ./btop.nix
    ./fish.nix
    ./git.nix
  ];

  home.packages = [
    pkgs.bash
    pkgs.fd
    pkgs.ripgrep
    pkgs.rm-improved
    pkgs.rustup
    pkgs.xcp
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.skim = {
    enable = true;
    defaultCommand = "fd --color=always";
    defaultOptions = [ "--ansi" ];
    fileWidgetCommand = "fd --color=always";
    fileWidgetOptions = [ "--ansi" "--preview '~/scripts/preview.sh {}'" ];
    changeDirWidgetCommand = "fd --type d --color=always";
  };

  programs.direnv = {
    enable = true;
  };

  programs.starship = {
    enable = true;
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

  programs.exa = {
    enable = true;
    icons = true;
    git = true;
  };
}