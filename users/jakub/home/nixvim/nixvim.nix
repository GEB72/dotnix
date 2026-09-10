{ ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals.mapleader = " ";

    opts = {
      tabstop = 2;
      softtabstop = -1;
      shiftwidth = 2;
      expandtab = true;
      splitbelow = true;
      splitright = true;
      number = true;
      relativenumber = true;
      laststatus = 3;
      cmdheight = 0;
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";
    };

    keymaps = [
      { mode = [ "n" "v" ]; key = "<CR>"; action = "o<Esc>k"; }
      { mode = [ "n" "v" ]; key = "<S-CR>"; action = "O<Esc>j"; }
      { mode = [ "n" "v" ]; key = "<leader>p"; action = "\"+p"; }
      { mode = [ "n" "v" ]; key = "<leader>y"; action = "\"+y"; }
      { mode = [ "n" "v" ]; key = "<leader>d"; action = "\"+d"; }
      { mode = "n"; key = "<leader>q"; action = "<cmd>q<CR>"; }
      { mode = "n"; key = "<leader>Q"; action = "<cmd>q!<CR>"; }
      { mode = "n"; key = "<leader><Esc>"; action = "<cmd>qa<CR>"; }
      { mode = "n"; key = "<leader>w"; action = "<cmd>w<CR>"; }
      { mode = "n"; key = "<leader>W"; action = "<cmd>wa<CR>"; }
      { mode = [ "n" "v" ]; key = "<leader>sd"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; }
      { mode = "i"; key = "jk"; action = "<Esc>"; }
      { mode = "v"; key = "<leader>r"; action = ":s/\\%V"; }
    ];

    autoCmd = [
      {
        event = "TextYankPost";
        pattern = "*";
        callback.__raw = ''
          function()
            vim.highlight.on_yank({ timeout = 200 })
          end
        '';
      }
      {
        event = "RecordingEnter";
        pattern = "*";
        callback.__raw = "function() vim.opt.cmdheight = 1 end";
      }
      {
        event = "RecordingLeave";
        pattern = "*";
        callback.__raw = "function() vim.opt.cmdheight = 0 end";
      }
      {
        event = "BufWritePre";
        pattern = "*.go";
        callback.__raw = ''
          function()
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
            for _, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
                else
                  vim.lsp.buf.execute_command(r.command)
                end
              end
            end
            vim.lsp.buf.format()
            vim.fn.jobstart("go mod tidy", { detach = true })
          end
        '';
      }
    ];

    diagnostics.update_in_insert = true;

    userCommands = {
      Lm = { command = "Leet menu"; };
      Lc = { command = "Leet console"; };
      Ll = { command = "Leet lang"; };
      Li = { command = "Leet info"; };
      Ld = { command = "Leet desc"; };
      Lt = { command = "Leet test"; };
      Lr = { command = "Leet run"; };
      Ls = { command = "Leet submit"; };
      Lo = { command = "Leet open"; };
      Le = { command = "Leet exit"; };
    };
  };

  imports = [ ./plugins.nix ];
}
