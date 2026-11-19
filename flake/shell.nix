_: {
  perSystem =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      devShells.default = pkgs.mkShellNoCC {
        shellHook = "${config.pre-commit.shellHook}";
        nativeBuildInputs =
          with pkgs;
          [
            # LSPs
            nixd
            just-lsp
            bash-language-server

            # Tooling
            age
            sops
          ]
          ++ [ config.treefmt.build.wrapper ]
          ++ (lib.attrValues config.treefmt.build.programs);
      };
    };
}
