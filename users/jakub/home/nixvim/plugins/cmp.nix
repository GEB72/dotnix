{ ... }:
{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      settings = {
        enabled.__raw = ''
          function()
            local disabled = false
            disabled = disabled or (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt")
            disabled = disabled or (vim.fn.reg_recording() ~= "")
            disabled = disabled or (vim.fn.reg_executing() ~= "")
            disabled = disabled or require("cmp.config.context").in_treesitter_capture("comment")
            return not disabled
          end
        '';
        sources = [
          { name = "nvim_lsp"; max_item_count = 5; }
          { name = "luasnip"; max_item_count = 5; }
        ];
        snippet.expand.__raw = ''
          function(args)
            require("luasnip").lsp_expand(args.body)
          end
        '';
        mapping = {
          "<C-b>".__raw = "cmp.mapping.scroll_docs(-4)";
          "<C-f>".__raw = "cmp.mapping.scroll_docs(4)";
          "<C-Space>".__raw = ''
            cmp.mapping(function()
              if cmp.visible() then
                cmp.close()
              else
                cmp.complete()
              end
            end)
          '';
          "<C-e>".__raw = "cmp.mapping.abort()";
          "<CR>".__raw = "cmp.mapping.confirm({ select = true })";
        };
        experimental = {
          ghost_text = false;
        };
      };
    };
    cmp-nvim-lsp.enable = true;
    luasnip = {
      enable = true;
      fromVscode = [ { } ];
    };
  };
}
