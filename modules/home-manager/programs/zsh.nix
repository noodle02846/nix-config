{ pkgs, ... }: {
  home.packages = with pkgs; [
    zsh
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;

    shellAliases = {
      "hm" = "home-manager";
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
      save = 100;
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

    zplug = {
      enable = true;
      plugins = [
        {
          name = "spaceship-prompt/spaceship-prompt";
          tags = [
            "use:spaceship.zsh"
            "from:github"
            "as:theme"
          ];
        }
      ];
    };
  };
}
