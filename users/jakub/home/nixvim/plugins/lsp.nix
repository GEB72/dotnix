{ ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      lua_ls = {
        enable = true;
        settings = {
          Lua.runtime.version = "LuaJIT";
        };
      };
      gopls = {
        enable = true;
        settings = {
          analyses.unusedparams = true;
          staticcheck = true;
          gofumpt = true;
        };
      };
      nil_ls = {
        enable = true;
        settings = {
          formatting.command = [ "nixfmt" ];
        };
      };
    };
  };
}
