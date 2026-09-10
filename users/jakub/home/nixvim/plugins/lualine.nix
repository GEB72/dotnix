{ ... }:
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "auto";
        section_separators = { left = ""; right = ""; };
        component_separators = { left = ""; right = ""; };
        refresh = {
          statusline = 100;
          tabline = 100;
          winbar = 100;
        };
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" "diff" "diagnostics" ];
        lualine_c = [
          "filename"
          {
            __unkeyed-1 = "datetime";
            style = "%H:%M";
          }
        ];
        lualine_x = [ "encoding" "fileformat" "filetype" ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
      inactive_sections = {
        lualine_a = [ ];
        lualine_b = [ ];
        lualine_c = [ "filename" ];
        lualine_x = [ "location" ];
        lualine_y = [ ];
        lualine_z = [ ];
      };
    };
  };
}
