{ pkgs, ... }: {
  home.packages = with pkgs; [
    pi-coding-agent
  ];

  programs.pi-coding-agent = {
    enable = true;

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
