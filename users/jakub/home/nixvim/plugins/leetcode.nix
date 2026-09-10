{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      leetcode-nvim
      nui-nvim
    ];

    extraConfigLua = ''
      require("leetcode").setup({
        lang = "golang",
      })
    '';
  };
}
