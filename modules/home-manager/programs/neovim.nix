{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    # Program options
    defaultEditor = true;

    # NOTE: better to mentally always do nvim for neovim
    # viAlias = true;
    # vimAlias = true;

    waylandSupport = true;

    # Lua options
    extraConfigLua = ''
      vim.pack.add({ {
        name = "lackluster.nvim",
        src = "https://github.com/slugbyte/lackluster.nvim"
      } });
    '';

    extraConfigLuaPost = ''
      vim.cmd.colorscheme("lackluster");
    '';

    # Local options
    opts = {
      number = true;
      colorcolumn = "80";

      # Tab options
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;

      list = true;
      smoothscroll = true;
    };

    # Clipboard settings
    clipboard.providers.wl-copy.enable = true;

    # LSP settings
    lsp = {
      inlayHints.enable = true;

      servers = {
        nixd.enable = true;
        zls.enable = true;
        vls.enable = true;
        qmlls.enable = true;
        gopls.enable = true;
        gleam.enable = true;
        luau_lsp.enable = true;
        rust_analyzer.enable = true;
      };
    };

    # Plugin settings
    plugins = {
      lspconfig.enable = true;

      lsp-lines.enable = true;
      lsp-status.enable = true;
      lsp-progress.enable = true;

      todo-comments.enable = true;

      lualine = {
        enable = true;
        settings.options.theme = "lackluster";
      };

      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
      };

      lint = {
        enable = true;

        autoInstall = {
          enable = true;
          enableWarnings = true;
        };

        lintersByFt = {
          go = [ "golangcilint" ];
          nix = [ "statix" ];
        };
      };

      conform-nvim = {
        enable = true;
        autoInstall.enable = true;

        settings = {
          format_on_save = {
            timeout_ms = 500;
            lsp_format = "fallback";
          };

          formatters_by_ft = {
            nix = [ "nixfmt" ];
            rust = [ "rustfmt" ];
            go = [ "gofmt" ];
            v = [ "v" ];
            gleam = [ "gleam" ];
            qml = [ "qmlformat" ];
          };
        };
      };
    };
  };
}
