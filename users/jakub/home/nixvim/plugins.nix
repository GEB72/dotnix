{
  imports = [
    ./plugins/github-theme.nix
    ./plugins/lualine.nix
    ./plugins/nvim-tree.nix
    ./plugins/telescope.nix
    ./plugins/cmp.nix
    ./plugins/treesitter.nix
    ./plugins/lsp.nix
    ./plugins/auto-session.nix
    ./plugins/toggleterm.nix
    ./plugins/lazygit.nix
    ./plugins/tmux-navigator.nix
    ./plugins/markdown.nix
    ./plugins/leetcode.nix
  ];

  programs.nixvim.plugins.web-devicons.enable = true;
}
