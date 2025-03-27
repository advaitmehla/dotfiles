{
  programs.plasma = {
    shortcuts = {
      "Show Desktop" = "none";
      "MinimizeAll" = "Meta+D";
    };
    kwin.scripts = {
      minimizeall = {
        enable = true;
      };
    };
  };  

}