{ inputs, ... }: {
  imports = [
    inputs.treefmt.flakeModule
    inputs.git-hooks.flakeModule
  ];

  perSystem = _: {
    pre-commit.settings.hooks.treefmt.enable = true;

    treefmt.programs = {
      # Flake tooling
      jq.enable = true;
      just.enable = true;

      # Markdown tooling
      mdformat.enable = true;

      # Shell tooling
      shfmt.enable = true;
      shellcheck = {
        enable = true;
        excludes = [ "*.envrc" ];
      };

      # Nix tooling
      nixfmt.enable = true;
      statix.enable = true;
      deadnix.enable = true;
    };
  };
}
