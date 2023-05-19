{
  lib,
  config,
  ...
}: {
  options = {
    my.roles.user.name = lib.mkOption {
      type = types.str;
      default = "calops";
      description = "Username";
    };
    my.roles.user.homeDirectory = lib.mkOption {
      type = types.path;
      default = "/home/${config.my.roles.user.name}";
      description = "Home directory";
    };
  };
}
