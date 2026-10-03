{ pkgs, config, ... }: {
  programs.pi-coding-agent = {
    enable = true;
    package = pkgs.pi-coding-agent;

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
            };

            "nix-docs" = {
              command = "uvx";
              args = [ "mcp-nixos" ];
            };
          };
        }
      );
    };
}
