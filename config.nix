{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "packages";
      paths = [
        zsh
        zsh-completions
        neovim
        ripgrep
        fzf
        lazygit
        tmux
      ];
    };
  };
}
