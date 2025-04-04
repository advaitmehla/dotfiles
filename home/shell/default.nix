# modular zsh config
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh-autosuggestions
    # zsh-syntax-highlighting
    # zsh-powerlevel10k
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

      # Async plugin loading
      zinit wait'0' lucid light-mode for \
        zdharma-continuum/fast-syntax-highlighting \
        zsh-users/zsh-syntax-highlighting

      zinit snippet OMZP::git
      zinit snippet OMZP::sudo

      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      autoload -Uz compinit && compinit -C

      # Keybindings
      bindkey '^[[1;5A' history-search-backward
      bindkey '^[[1;5B' history-search-forward

      # Completion styles
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

      # History settings
      HISTDUP=erase

      eval "$(fzf --zsh)"

      # Load zoxide with custom 'cd' alias
      eval "$(zoxide init --cmd cd zsh)"

      lspkg() {
        local pkg_path
        pkg_path=$(nix eval --raw nixpkgs#$1 2>/dev/null)
        if [[ -d "$pkg_path" ]]; then
          ls "$pkg_path"
        else
          echo "Package '$1' not found or invalid."
        fi
      }

      nixpkg-path() {
        nix eval --raw nixpkgs#$1 2>/dev/null || echo "Package '$1' not found."
      }
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