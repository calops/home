{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
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
        email = "rlabeyrie@gmail.com";
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
  };
}
