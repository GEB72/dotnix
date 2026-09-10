{ ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      ensure_installed = [ "c" "lua" "vim" "go" "vimdoc" "query" "markdown" "markdown_inline" ];
      ignore_install = [ "javascript" ];
      auto_install = true;
      highlight = {
        enable = true;
        disable.__raw = ''
          function(lang, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end
        '';
      };
    };
  };
}
