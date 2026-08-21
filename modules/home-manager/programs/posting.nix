{ pkgs, ... }: {
  home.packages = with pkgs; [
    posting
  ];

  programs.posting = {
    enable = true;

    settings = {
      editor = "nvim";
      layout = "vertical";
      animation = "full";
    };
  };
}
