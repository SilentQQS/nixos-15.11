{ pkgs, lib, ... }: {
  programs.nvf = {
    enable = true;

    settings.vim = {
      options = { cmdheight = 10; };
      extraPlugins = {
        codewindow = {
          package = pkgs.vimPlugins.codewindow-nvim;
          setup = ''
            require("codewindow").setup({
              minimap_width = 10,                      -- стандарт 20
              auto_enable = false,                     -- автозапуск мы делаем вручную
              auto_enable_width = 0,                   -- отключить авто на ширину
              use_lsp = true,                         -- отключить LSP-индикацию
              exclude_filetypes = { "NvimTree", "TelescopePrompt", "neo-tree" },
              active_in_terminals = false,
              use_treesitter = true,
              default_enable = true,
              screen_bounds = "background",            -- фон за границами
              line_color = "#ffffff",                  -- цвет текущей строки
              cursor_color = "#00ff00",                -- цвет курсора
              window_border = "none", 
              screen_bounds = "background"
            })

            -- AutoStart Minimap after open file
            vim.api.nvim_create_autocmd("BufReadPost", {
              callback = function()
                require("codewindow").open_minimap()
              end,
            })
          '';
        };
      };

      viAlias = false;
      vimAlias = true;
      keymaps = [
        # Undotree
        {
          key = "<leader>u";
          mode = [ "n" ];
          action = "<cmd>UndotreeToggle<CR>";
          desc = "Toggle Undotree";
          silent = true;
        }

        # Neotree
        {
          key = "<leader>e";
          mode = [ "n" ];
          action = "<cmd>Neotree toggle<CR>";
          desc = "Toggle Neotree";
          silent = true;
        }
        # Multicursors (vim-visual-multi или nvim-multicursor)
        {
          key = "<leader>r";
          mode = [ "v" ];
          action = "<cmd>MCstart<CR>";
          desc = "Multicursor Start";
          silent = true;
        }
      ];
      debugMode = {
        enable = false;
        level = 16;
        logFile = "/tmp/nvim.log";
      };

      spellcheck = {
        enable = true;
        programmingWordlist.enable = false;
      };

      lsp = {
        enable = true;
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = false;
        otter-nvim.enable = true;
        nvim-docs-view.enable = true;
      };

      debugger.nvim-dap = {
        enable = true;
        ui.enable = true;
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        markdown.enable = true;

        bash.enable = true;
        clang.enable = false;
        css.enable = false;
        html.enable = true;
        sql.enable = true;
        java.enable = false;
        kotlin.enable = false;
        ts.enable = false;
        go.enable = false;
        lua.enable = true;
        zig.enable = false;
        python.enable = true;
        typst.enable = false;
        rust = {
          enable = false;
          crates.enable = false;
        };

        assembly.enable = false;
        astro.enable = false;
        nu.enable = false;
        csharp.enable = false;
        julia.enable = false;
        vala.enable = false;
        scala.enable = false;
        r.enable = false;
        gleam.enable = false;
        dart.enable = false;
        ocaml.enable = false;
        elixir.enable = false;
        haskell.enable = false;
        ruby.enable = false;
        fsharp.enable = false;
        tailwind.enable = false;
        svelte.enable = false;
        nim.enable = false;
      };

      visuals = {
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        indent-blankline.enable = true;
        cellular-automaton.enable = false;
      };

      statusline.lualine = {
        enable = true;
        theme = lib.mkForce "catppuccin";
      };

      theme = {
        enable = true;
        name = lib.mkForce "catppuccin";
        style = lib.mkForce "mocha";
        transparent = lib.mkForce false;
      };

      autopairs.nvim-autopairs.enable = true;

      autocomplete = {
        nvim-cmp.enable = false;
        blink-cmp.enable = true;
      };

      snippets.luasnip.enable = true;

      filetree.neo-tree.enable = true;

      tabline.nvimBufferline.enable = true;

      treesitter.context.enable = true;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      telescope.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
        neogit.enable = false;
      };

      minimap = {
        minimap-vim.enable = false;
        codewindow.enable = true;
      };

      dashboard = {
        dashboard-nvim.enable = false;
        alpha.enable = true;
      };

      notify.nvim-notify.enable = true;

      projects.project-nvim.enable = true;

      utility = {
        ccc.enable = false;
        vim-wakatime.enable = false;
        diffview-nvim.enable = true;
        yanky-nvim.enable = false;
        icon-picker.enable = false;
        surround.enable = true;
        leetcode-nvim.enable = false;
        multicursors.enable = true;
        smart-splits.enable = true;
        undotree.enable = true;
        nvim-biscuits.enable = true;

        motion = {
          hop.enable = true;
          leap.enable = true;
          precognition.enable = false;
        };

        images = {
          image-nvim.enable = false;
          img-clip.enable = true;
        };
      };

      notes = {
        obsidian.enable = false;
        neorg.enable = false;
        orgmode.enable = false;
        mind-nvim.enable = true;
        todo-comments.enable = true;
      };

      terminal.toggleterm = {
        enable = true;
        lazygit.enable = true;
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        modes-nvim.enable = false;
        illuminate.enable = true;

        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };

        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            nix = "110";
            ruby = "120";
            java = "130";
            go = [ "90" "130" ];
          };
        };

        fastaction.enable = true;
      };

      assistant = {
        chatgpt.enable = false;
        copilot = {
          enable = false;
          cmp.enable = false;
        };
        codecompanion-nvim.enable = false;
        avante-nvim.enable = false;
      };

      session.nvim-session-manager.enable = false;

      gestures.gesture-nvim.enable = false;

      comments.comment-nvim.enable = true;

      presence.neocord.enable = false;
    };
  };
}
