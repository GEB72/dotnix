{ ... }:
{
  programs.nixvim = {
    plugins.auto-session = {
      enable = true;
      settings = {
        session_lens = {
          load_on_setup = true;
          theme_conf = { border = true; };
          previewer = false;
        };
        auto_session_allowed_dirs = [
          "~/dotnix"
          "~/dotfiles"
          "~/Workspace/repo/*"
          "~/go/pkg/*"
        ];
      };
    };

    keymaps = [
      { mode = "n"; key = "<leader>fs"; action.__raw = "require('auto-session.session-lens').search_session"; }
      { mode = "n"; key = "<leader>s"; action = "<cmd>SessionSave<CR>"; }
    ];
  };
}
