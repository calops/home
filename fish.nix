{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      nv = "nvim";
      cat = "bat";
      hm = "home-manager";
      hs = "home-manager switch";
    };
    shellAliases = {
      copy = "xclip -selection clipboard";
      cp = "xcp";
      rm = "rip";
      ls = "exa";
      ll = "ls -lH --time-style=long-iso";
      la = "ll -a";
      lt = "ll -T";
    };
    functions = {
      smake = ''
        if test -d "./StocklyContinuousDeployment"
          make -C "./StocklyContinuousDeployment" $argv
        else
          make -C "./scd" $argv
        end
      '';
      cdr = ''
        if test (count $argv) -gt 0
          cd $STOCKLY_MAIN/$argv[1]
        else
          cd $STOCKLY_MAIN
        end
      '';
    };
    interactiveShellInit = ''
      set fish_greeting

      function cdr_complete
        set arg (commandline -ct)
        set saved_pwd $PWD
        builtin cd $STOCKLY_MAIN 2>/dev/null
        and complete -C"cd $arg"
        builtin cd $saved_pwd
      end
      complete --command cdr -f --arguments '(cdr_complete)'

      if test -e ~/.nix-profile/etc/profile.d/nix.fish
        source ~/.nix-profile/etc/profile.d/nix.fish
      end
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.skim = {
    enable = true;
    defaultCommand = "fd --color=always";
    defaultOptions = ["--ansi"];
    fileWidgetCommand = "fd --color=always";
    fileWidgetOptions = ["--ansi" "--preview '~/scripts/preview.sh {}'"];
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
