{ pkgs, config, ... }: {
  programs.pi-coding-agent = {
    enable = true;
    context = ''
      * When the operator requests separate tool calls, never batch them.
      * Never batch a call that reads file X with a call that writes or produces X.
    '';

    extraPackages = with pkgs; [
      # Runtimes
      uv
      nodejs
      python3

      # Commands
      jq
    ];

    settings = {
      # Providers
      defaultProvider = "llama.cpp";
      defaultThinkingLevel = "medium";

      # UI
      theme = "dark";
      tuiMode = "fullscreen";
      externalEditor = "$EDITOR";

      # Telemetry
      enableInstallTelemetry = false;
      enableAnalytics = false;
      trackingId = "";
    };
  };

  home.file =
    let
      cfg = config.programs.pi-coding-agent;
    in
    {
      "${cfg.configDir}/mcp.json".source = pkgs.writeText "pi-coding-agent-mcp.json" (
        builtins.toJSON {
          mcpServers = {
            "web-search-exa-ai" = {
              url = "https://mcp.exa.ai/mcp";

              exposure = "direct";
            };

            "nix-docs" = {
              command = "uvx";
              args = [ "mcp-nixos" ];

              exposure = "direct";
            };
          };
        }
      );
    };
}
