{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      github-nvim-theme
    ];
    extraConfigLuaPre = ''
      require("github-theme").setup({
        options = {
          hide_end_of_buffer = true,
          hide_nc_statusline = true,
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          styles = {
            comments = "NONE",
            functions = "NONE",
            keywords = "NONE",
            variables = "NONE",
            conditionals = "NONE",
            constants = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
          },
          inverse = {
            match_paren = false,
            visual = false,
            search = false,
          },
          darken = {
            floats = true,
            sidebars = { enable = true },
          },
        },
      })
    '';
    colorscheme = "github_dark_high_contrast";
  };
}
