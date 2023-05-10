{pkgs, ...}: {
  home.packages = [pkgs.git-crypt];
  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      signByDefault = true;
      key = "1FAB C23C 7766 D833 7C4D  C502 5357 919C 06FD 9147";
    };
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        line-numbers = true;
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "bold yellow ul";
          file-style = "bold yellow";
          hunk-header-decoration-style = "omit";
        };
        features = "decorations";
      };
    };
    aliases = {
      st = "status";
      ci = "commit";
      lg = "log --graph --pretty=tformat:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ar)%Creset' -n25";
      llg = "log --graph --pretty=tformat:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ar)%Creset'";
      oops = "commit --amend --no-edit";
      pushf = "push --force-with-lease";
      mom = "merge origin/master --no-edit";
    };
    ignores = [
      ".aws"
      ".lsp.lua"
      ".neoconf.json"
      ".venv"
      ".vim"
      ".yarn"
      ".yarnrc"
      "Cargo.lock"
      "Session.vim"
      "__pycache__"
      "settings.json"
      "target"
      "tmp"
      "typings"
    ];
    extraConfig = {
      user = {
        name = "Rémi Labeyrie";
        email = "calops@tocards.net";
      };
      diff = {
        renames = true;
        mnemonicPrefix = true;
        colorMoved = "default";
      };
      core = {
        whitespace = "-trailing-space";
      };
      color.ui = "auto";
      grep.extendedRegexp = true;
      log.abbrevCommit = true;
      merge = {
        tool = "vimdiff";
        log = true;
        conflictstyle = "diff3";
      };
      mergetool.prompt = true;
      difftool.prompt = false;
      diff.tool = "vimdiff";
      rerere = {
        enabled = true;
        autoUpdate = true;
      };
      status = {
        submoduleSummary = true;
        showUntrackedFiles = "all";
      };
      tag.sort = "version:refname";
      pull.rebase = "true";
      push.default = "upstream";
    };
    includes = [
      {
        condition = "gitdir:stockly";
        contents = {
          user = {
            name = "Remi Labeyrie";
            email = "remi.labeyrie@stockly.ai";
            signingKey = "0C4A 765B BFDA 280C 47C1  73EE 8769 75DF 5890 0393";
          };
        };
      }
    ];
  };
}
