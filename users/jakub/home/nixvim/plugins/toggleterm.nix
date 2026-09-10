{ ... }:
{
  programs.nixvim = {
    plugins.toggleterm.enable = true;

    keymaps = [
      { mode = "n"; key = "<leader>tr"; action = "<cmd>ToggleTerm<CR>"; }
    ];
  };
}
