{ pkgs, ... }: {
  programs.pi-coding-agent = {
    enable = true;
    package = pkgs.pi-coding-agent;

    extraPackages = with pkgs; [
      # Runtimes
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

      # Telemtry
      enableInstallTelemetry = false;
      enableAnalytics = false;
      trackingId = "";
    };
  };
}
