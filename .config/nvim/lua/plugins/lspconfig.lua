return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          check_outdated_packages_on_open = true,
          border = "rounded",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      ensure_installed = {
        "lua_ls",
        "pyright",
        "jdtls",
        "html",
        "cssls",
        "ts_ls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = { "pyright", "html", "cssls", "ts_ls" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({ capabilities = capabilities })
      end
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      lspconfig.jdtls.setup({
        capabilities = capabilities,
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-25",
                  path = "C:/Program Files/Java/jdk-25",
                  default = true,
                },
              },
            },
          },
        },
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Show hover information" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "Go to implementation" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "Go to declaration" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "Go to references" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename symbol" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code action" })
    end,
  },
}
