{ pkgs, ... }:
{
  # Set per-user tmux config w/ plugins
  programs.tmux = {
    plugins = with pkgs.tmuxPlugins; [
      continuum
      resurrect
      vim-tmux-navigator
    ];
    extraConfig = ''
      set -g @vim_navigator_mapping_left "C-h"
      set -g @vim_navigator_mapping_right "C-l"
      set -g @vim_navigator_mapping_up "C-k"
      set -g @vim_navigator_mapping_down "C-j"
      set -g @vim_navigator_mapping_prev "C-//"

      resurrect_dir="$HOME/.tmux/resurrect"
      set -g @resurrect-strategy-vim 'session'
      set -g @resurrect-strategy-nvim 'session'
      set -g @resurrect-capture-pane-contents 'on'
      set -g @resurrect-hook-post-save-all "sed 's/--cmd[^ ]* [^ ]* [^ ]*//g' $resurrect_dir/last | sponge $resurrect_dir/last"
      set -g @resurrect-processes '"~nvim"'

      set -g @continuum-restore 'on'
      set -g @continuum-boot 'on'
      set -g @continuum-boot-options 'kitty'
      set -g @continuum-save-interval '10'
    '';
  };

  home.file.".tmux/plugins".source = pkgs.buildEnv {
	  name = "tmux-plugins";
		paths = with pkgs.tmuxPlugins; [
		  resurrect
			continuum
		];
		pathsToLink = [ "/share" ];
	};

  # Import global tmux config
  imports = [ ../../../../modules/home/tmux/tmux.nix ];
}
