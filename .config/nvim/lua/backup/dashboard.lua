return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        header = {
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                     ]],
          [[       ████ ██████           █████      ██                     ]],
          [[      ███████████             █████                             ]],
          [[      █████████ ███████████████████ ███   ███████████   ]],
          [[     █████████  ███    █████████████ █████ ██████████████   ]],
          [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
          [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
          [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
          [[                                                                       ]],
          [[                                                                       ]],
          [[                                                                       ]],
        },
        center = {
          { icon = " ", desc = "New file", key = "n", action = "ene | startinsert" },
          { icon = " ", desc = "Find files", key = "f", action = "Telescope find_files" },
          { icon = "󰱼 ", desc = "Find text", key = "g", action = "Telescope live_grep" },
          { icon = " ", desc = "Recent files", key = "r", action = "Telescope oldfiles" },
          { icon = " ", desc = "Config", key = "c", action = "e $MYVIMRC" },
          { icon = "󱌣 ", desc = "Mason", key = "m", action = "Mason" },
          { icon = "󰒲 ", desc = "Lazy", key = "l", action = "Lazy" },
          { icon = " ", desc = "Quit", key = "q", action = "qa" },
        },
        footer = {
          [[                                   ]],
          [[   Getting started with NeoVim   ]],
          [[       ⚡ Ship code faster ⚡        ]],
        },
        verticle_center = true,
      },
    })
  end,
}
