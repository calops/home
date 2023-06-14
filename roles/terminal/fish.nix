{
  config,
  lib,
  ...
}: let
  cfg = config.my.roles.terminal;
in {
  programs.fish = {
    enable = cfg.enable;
    shellAbbrs = {
      nv = "nvim";
      cat = "bat";
      hm = "home-manager";
      hs = "home-manager switch --impure";
      ga = "git add -v";
      gu = "git add -vu";
      gp = "git push";
      st = "git status";
      cc = "cargo check";
      di = "git diff";
      rm = "rip";
    };
    shellAliases = {
      copy = "xclip -selection clipboard";
      cp = "xcp";
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
      run = ''nix run nixpkgs#"$argv[1]" -- $argv[2..-1]'';
      cdr = ''
        if test (count $argv) -gt 0
          cd $STOCKLY_MAIN/$argv[1]
        else
          cd $STOCKLY_MAIN
        end
      '';
      s = ''
        cargo run --manifest-path "$STOCKLY_MAIN/.cargo/workspace/Cargo.toml" -p "stockly_cli" --release -- $argv
      '';
      eol = ''
        echo "adding missing EOLs"
        git status --short | choose 1 | rargs sed -i '$a\\' {0}
        git status --short
      '';
      gc = ''git commit -m "$argv"'';
    };
    interactiveShellInit = ''
      set fish_greeting

      if test -e ~/.nix-profile/etc/profile.d/nix.fish
        source ~/.nix-profile/etc/profile.d/nix.fish
      end
    '';
  };
}
