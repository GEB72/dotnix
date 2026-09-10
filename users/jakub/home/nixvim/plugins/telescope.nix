{ ... }:
{
  programs.nixvim.plugins.telescope = {
    enable = true;
    settings = {
      pickers = {
        find_files = {
          hidden = true;
          file_ignore_patterns = [ ".git/" ".cache" ".idea" ];
        };
        lsp_document_symbols = {
          symbols = [ "function" "struct" "interface" "const" ];
        };
      };
    };
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
      "<leader>fds" = "lsp_document_symbols";
      "<leader>fb" = "buffers";
      "<leader>fh" = "help_tags";
    };
  };
}
