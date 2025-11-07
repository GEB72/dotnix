{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      bind r source-file ~/.config/tmux/tmux.conf

      bind -n C-s choose-session
      bind -n C-w choose-window
      set -g mode-keys vi	
    '';
  };
}
