_: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;

    shellAliases = {
      "cls" = "clear";
    };

    syntaxHighlighting = {
      enable = true;

      highlighters = [
        "brackets"
        "root"
      ];
    };

    history = {
      extended = true;
      expireDuplicatesFirst = true;
      save = 1000;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "foot"
        "golang"
        "rust"
      ];
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
