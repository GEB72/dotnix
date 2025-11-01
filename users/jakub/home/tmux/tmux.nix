{ pkgs, ... }:
{
  # Set per-user tmux config w/ plugins
  programs.tmux = {
    enable = true;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      resurrect
      continuum
    ];
    extraConfig = ''
      set -g @vim_navigator_mapping_left "C-h"
      set -g @vim_navigator_mapping_right "C-l"
      set -g @vim_navigator_mapping_up "C-k"
      set -g @vim_navigator_mapping_down "C-j"
      set -g @vim_navigator_mapping_prev "C-//"

      set -g @resurrect-strategy-vim 'session'
      set -g @resurrect-strategy-nvim 'session'
      set -g @resurrect-capture-pane-contents 'on'

      set -g @continuum-restore 'on'
      set -g @continuum-boot 'on'
      set -g @continuum-save-interval '10'
    '';
  };

  # Import global tmux config
  imports = [ ../../../../modules/home/tmux/tmux.nix ];
}
