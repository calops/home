{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.roles.terminal;
  enable = cfg.enable && cfg.dev;
in
  with lib; {
    home.packages = mkIf enable [
      pkgs.podman
    ];

    xdg.configFile."containers/registries.conf".text = mkIf enable ''
      [registries.search]
      registries = ['docker.io']
    '';
    xdg.configFile."containers/policy.json".text = mkIf enable ''
      {
        "default": [
          {
            "type": "insecureAcceptAnything"
          }
        ]
      }
    '';
  }
