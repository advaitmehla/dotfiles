# modular zsh config
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-powerlevel10k
    # fzf-zsh
    fzf
    # zsh-fzf-tab
    zinit
    zoxide
  ];

  programs.zsh = {

    enable = true;

    shellAliases = {
      ll = "ls -l";
      ls = "ls --color";
      ".." = "cd ..";
      astro = "conda activate astro";
      gitpc = "ssh -x -oHostKeyAlgorithms=+ssh-dss -x -A growth-crest@117.252.85.44";
      "rebuildhome" = "home-manager switch --flake ~/.dotfiles/.";
      "rebuildsys" = "sudo nixos-rebuild switch --flake ~/.dotfiles/.";
      conda = "micromamba";
    };


    initExtra = ''
      source ${pkgs.zinit}/share/zinit/zinit.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      
      # source ~/.fzf-tab-completion/zsh/fzf-zsh-completion.sh
      # bindkey '^I' fzf_completion
    

      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      autoload -Uz compinit && compinit

      bindkey '^[[1;5A' history-search-backward
      bindkey '^[[1;5B' history-search-forward

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      # zstyle ':completion:*:*:git:*' fzf-search-display true
      # zstyle ':completion:*' menu no
      # zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

      zinit snippet OMZP::git
      zinit snippet OMZP::sudo
      # zinit snippet OMZP::command-not-found

      HISTDUP=erase
      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"

    '';

    history = {
      size = 10000;
      save = 10000;
      append = true;
      share = true;
      ignoreDups = true;
      saveNoDups = true;
      ignoreAllDups = true;
      findNoDups = true;
    };
  }; 

  home.file.".p10k.zsh".source = ./.p10k.zsh;
}