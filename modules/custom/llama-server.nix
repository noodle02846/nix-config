{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.llama-server;
in
{
  options.services.llama-server = {
    enable = lib.mkEnableOption "llama.cpp inference server";

    package = lib.mkPackageOption pkgs "llama-cpp" { };

    commandLineArgs = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.oneOf [
          lib.types.str
          lib.types.int
          lib.types.bool
        ]
      );
      default = { };
      description = ''
        Command-line flags passed to the `llama-server` binary
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.llama-server = {
      Unit = {
        Description = "llama.cpp inference server";
        Documentation = "https://github.com/ggml-org/llama.cpp";

        After = [ "network-online.target" ];
        Wants = [ "network-online.target" ];

        X-Restart-Triggers = [ cfg.package ];
      };

      Service =
        let
          args = lib.concatLists (
            lib.mapAttrsToList (
              flag: value:
              if lib.isBool value then
                lib.optional value "--${flag}"
              else
                [
                  "--${flag}"
                  (toString value)
                ]
            ) cfg.commandLineArgs
          );

          escapeSystemdExecArg =
            arg:
            let
              s = toString arg;
              full = lib.replaceStrings [ "%" "$" ] [ "%%" "$$" ] (builtins.toJSON s);
            in
            if lib.match "[[:alnum:],._+=:@/-]+" s != null then s else full;

          escapeSystemdExecArgs = lib.concatMapStringsSep " " escapeSystemdExecArg;
        in
        {
          Type = "exec";
          ExecStart = escapeSystemdExecArgs (
            [
              (lib.getExe cfg.package)
              "server"
            ]
            ++ args
          );

          Restart = "on-failure";
          RestartSec = 5;

          TimeoutStopSec = 30;
        };

      Install.WantedBy = [ "default.target" ];
    };
  };
}
