{ inputs, ... }:

{
  imports = [
    inputs.lazyvim.homeManagerModules.default
  ];

  programs.lazyvim = {
    enable = true;

    extras = {
      lang.dotnet.enable = true;
      lang.go.enable = true;
      lang.yaml.enable = true;
      dap.core.enable = true;
      util.octo.enable = true;
    };

    config = {
      options = ''
        vim.filetype.add({
          extension = {
            cake = "cs",
            csharp = "cake",
          },
        })
      '';
    };

    plugins = {
      flash = ''
        return {
          "folke/flash.nvim",
          keys = {
            { "t", mode = { "n", "x", "o" }, false },
          },
        }
      '';

      kubernetes = ''
        return {
          "diogo464/kubernetes.nvim",
          opts = {
            schema_strict = true,
            schema_generate_always = true,
            patch = true,
            yamlls_root = function()
              return vim.fs.joinpath(vim.fn.stdpath("data"), "/mason/packages/yaml-language-server/")
            end,
          },
        }
      '';

      markdownpreview = ''
        return {
          "iamcco/markdown-preview.nvim",
          cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
          build = "cd app && yarn install",
          init = function()
            vim.g.mkdp_filetypes = { "markdown" }
          end,
          ft = { "markdown" },
        }
      '';

      neogen = ''
        return {
          "danymat/neogen",
          dependencies = "nvim-treesitter/nvim-treesitter",
          opts = {
            languages = {
              cs = {
                template = {
                  annotation_convention = "xmldoc",
                },
              },
            },
          },
          keys = {
            { "<leader>n", "<cmd>Neogen<cr>", desc = "Generate documentation" },
          },
        }
      '';

      noneckpain = ''
        return {
          {
            "shortcuts/no-neck-pain.nvim",
          },
        }
      '';

      omnisharp = ''
        local util = require("lspconfig.util")

        return {
          "neovim/nvim-lspconfig",
          opts = {
            servers = {
              omnisharp = {
                filetypes = { "cs", "vb", "cake" },
                root_dir = util.root_pattern("*.sln", "*.csproj", "omnisharp.json", "function.json", ".git"),
              },
            },
          },
        }
      '';

      opencode = ''
        return {
          "NickvanDyke/opencode.nvim",
          dependencies = {
            { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
          },
          config = function()
            local opencode_cmd = "opencode --port"
            local snacks_terminal_opts = {
              win = {
                position = "right",
                enter = false,
                on_win = function(win)
                  require("opencode.terminal").setup(win.win)
                end,
              },
            }

            vim.g.opencode_opts = {
              server = {
                start = function()
                  require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
                end,
                stop = function()
                  require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
                end,
                toggle = function()
                  require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
                end,
              },
            }

            vim.o.autoread = true

            vim.keymap.set({ "n", "x" }, "<leader>oa", function()
              require("opencode").ask("@this: ", { submit = true })
            end, { desc = "Ask opencode" })
            vim.keymap.set({ "n", "x" }, "<leader>oo", function()
              require("opencode").select()
            end, { desc = "Execute opencode action..." })
            vim.keymap.set({ "n", "x" }, "<leader>op", function()
              require("opencode").prompt("@this")
            end, { desc = "Add to opencode" })
            vim.keymap.set({ "n", "t" }, "<leader>ot", function()
              require("opencode").toggle()
            end, { desc = "Toggle opencode" })
            vim.keymap.set("n", "<leader>oh", function()
              require("opencode").command("session.half.page.up")
            end, { desc = "opencode half page up" })
            vim.keymap.set("n", "<leader>om", function()
              require("opencode").command("session.half.page.down")
            end, { desc = "opencode half page down" })
          end,
        }
      '';
    };
  };

}
