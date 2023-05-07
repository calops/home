{ ... }: {
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
}
