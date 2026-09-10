{ ... }:
{
  programs.nixvim = {
    plugins.render-markdown.enable = true;

    extraConfigLua = ''
      require("render-markdown").enable()
    '';
  };
}
