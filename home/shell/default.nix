# modular zsh config
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-powerlevel10k
  ];

  programs.zsh = {

    enable = true;

    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      astro = "conda activate astro";
      gitpc = "ssh -x -oHostKeyAlgorithms=+ssh-dss -x -A growth-crest@117.252.85.44";
      "rebuildhome" = "home-manager switch --flake ~/.dotfiles/.";
      "rebuildsys" = "sudo nixos-rebuild switch --flake ~/.dotfiles/.";
      conda = "micromamba";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ]; # Only include plugins that are part of oh-my-zsh
    };

    initExtra = ''
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
  }; 
  home.file.".p10k.zsh".source = ./.p10k.zsh;
}