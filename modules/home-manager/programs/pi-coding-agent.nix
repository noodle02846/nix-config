{ pkgs, config, ... }: {
  programs.pi-coding-agent = {
    enable = true;

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
      defaultProvider = "tinfoil";
      defaultModel = "inkling-2-small";
      defaultThinkingLevel = "high";

      enabledModels = [
        "glm-5-3"
        "kimi-k3-1-pro"
        "inkling-2-small"
        "deepseek-v4-1-flash"
      ];

      # Packages
      packages = [
        "npm:@tinfoilsh/pi-provider"
      ];

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

  programs.mcp = {
    enable = true;
    servers = {
      mcp-nixos = {
        command = "uvx";
        args = [ "mcp-nixos" ];
      };
    };
  };

  home.file."${config.programs.pi-coding-agent.configDir}/mcp.json".source =
    config.xdg.configFile."mcp/mcp.json".source;

  # home.file =
  #   let
  #     cfg = config.programs.pi-coding-agent;
  #   in
  #   {
  #     "${cfg.configDir}/mcp.json".source = pkgs.writeText "pi-coding-agent-mcp.json" (
  #       builtins.toJSON {
  #         mcpServers = {
  #           "web-search-exa-ai" = {
  #             url = "https://mcp.exa.ai/mcp";
  #
  #             exposure = "direct";
  #           };
  #
  #           "nix-docs" = {
  #             command = "uvx";
  #             args = [ "mcp-nixos" ];
  #
  #             exposure = "direct";
  #           };
  #         };
  #       }
  #     );
  #   };
}
