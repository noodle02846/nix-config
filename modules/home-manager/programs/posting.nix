{ pkgs, ... }: {
  home.packages = with pkgs; [
    posting
  ];

  programs.posting = {
    enable = true;

    settings = {
      editor = "nvim";
      layout = "horizontal";
      animation = "full";
    };
  };
}
