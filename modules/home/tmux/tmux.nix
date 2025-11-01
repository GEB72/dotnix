{ ... }:
{
  programs.tmux = {
    extraConfig = ''
      bind r source-file ~/.config/tmux/tmux.conf

			bind -n C-s choose-session
			set -g mode-keys vi	
    '';
  };
}
