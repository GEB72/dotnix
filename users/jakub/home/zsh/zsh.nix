{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    # in-built plugins
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # omz plugins
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "aws"
      ];
    };

    shellAliases = {
      fclear = "clear; fastfetch";
    };

    initContent = ''
            if [[ -z "$NVIM_LOG_FILE" ]]; then
            	fastfetch
            fi
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            test -f ~/.p10k.zsh && source ~/.p10k.zsh
            if [ -z "$TMUX" ] && ! pgrep -x "tmuxr" > /dev/null && pgrep -x -f "startplasma-wayland" > /dev/null
      			then
            	tmux a || (tmuxr && tmux a)
            fi
    '';
  };
}
