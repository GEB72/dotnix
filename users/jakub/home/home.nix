{ pkgs, ... }:
{
  home = {
    # Username and directory
    username = "jakub";
    homeDirectory = "/home/jakub";

    # Copy public ssh key
    file.".ssh/id_ed25519.pub".text = builtins.readFile ../public-keys/id_me.pub;

    # Home packages
    packages = with pkgs; [
      (callPackage ./scripts/restore.nix { inherit pkgs; })
    ];

    # Backwards compatibility
    stateVersion = "24.11";
  };

  imports = [
    ./tmux/tmux.nix
    ./zsh/zsh.nix
  ];
}
