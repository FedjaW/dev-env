--[=====[
return {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        -- Example config in lua
        vim.g.nord_contrast = true
        vim.g.nord_borders = false
        vim.g.nord_disable_background = false
        vim.g.nord_italic = false
        vim.g.nord_uniform_diff_background = true
        vim.g.nord_bold = false

        -- Load the colorscheme
        require('nord').set()
    end
}

return {
    'behemothbucket/gruber-darker-theme.nvim',
    priority = 1000,
    lazy = false,
    config = function()
        require('gruber-darker').setup()
        vim.cmd('colorscheme gruber-darker')
    end,
}
--]=====]

return {
  "vague2k/vague.nvim",
  config = function()
    -- NOTE: you do not need to call setup if you don't want to.
    require("vague").setup({
      -- optional configuration here
    })
  end
}
