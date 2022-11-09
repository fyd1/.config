vim.opt.termguicolors = true
vim.api.nvim_cmd({cmd='colorscheme', args={theme}}, {})

-- transparent everything
if theme == 'dracula' then
    vim.api.nvim_exec([[
        set fillchars+=vert:\|
        highlight Normal ctermbg=None guibg=None
        highlight EndOfBuffer ctermbg=None
        highlight LineNr guibg=None
        highlight NonText ctermbg=None guibg=None
        highlight SignColumn guibg=None
        highlight WinSeparator guifg=#44475A guibg=None
        highlight NvimTreeNormal guibg=None guifg=none
        highlight VertSplit guifg=#44475A guibg=None
    ]], {}) 
end

