return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "vim" },
      enable_moveright = false,
      enable_afterquote = true,
      enable_check_bracket_line = true,
      fast_wrap = {
        map = "<A-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        before_key = "h",
        after_key = "l",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        cursor_pos_before = true,
        manual_position = true,
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    })
    autopairs.get_rule("`"):with_pair(function(opts)
      return vim.bo.filetype ~= "markdown"
    end)
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
