{ config, pkgs, ... }: {
  imports = [
    ../../custom/llama-server.nix
  ];

  services.llama-server = {
    enable = true;
    package = pkgs.llama-cpp-cuda;

    commandLineArgs = {
      # llama.cpp
      offline = true;
      log-verbosity = 3;

      models-dir = "${config.home.homeDirectory}/templates/models";

      port = 1234;
      host = "127.0.0.1";

      # Context
      flash-attn = "on";
      ctx-size = 131702;
      cache-reuse = 256;
      cache-type-k = "q8_0";
      cache-type-v = "q8_0";
      no-context-shift = true;

      # Layers
      load-mode = "mlock";

      n-cpu-moe = 32;
      n-gpu-layers = 999;

      # Performance
      jinja = true;
      parallel = 1;

      batch-size = 4096;
      ubatch-size = 1024;

      threads = 6;
      threads-batch = 6;
    };
  };
}
