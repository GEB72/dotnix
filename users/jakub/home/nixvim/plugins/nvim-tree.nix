{ ... }:
{
  programs.nixvim = {
    plugins.nvim-tree = {
      enable = true;
      view.width = 30;
      sortBy = "case_sensitive";
      filters.dotfiles = false;
      renderer.groupEmpty = true;
      onAttach.__raw = ''
        function(bufnr)
          local api = require("nvim-tree.api")
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set("n", "cd", api.tree.change_root_to_node, opts("CD"))
          vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        end
      '';
    };

    keymaps = [
      { mode = "n"; key = "<leader>ft"; action = "<cmd>NvimTreeToggle<CR>"; }
    ];
  };
}
