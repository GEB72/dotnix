{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
            bind r source-file ~/.config/tmux/tmux.conf
      			set -g default-terminal "screen-256color"

            bind -n C-s choose-session
            set -g mode-keys vi	
    '';
  };
}
