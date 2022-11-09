--[[
plugins to check out for a complete build
https://github.com/kylechui/nvim-surround or maybe https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md for more minimal

https://github.com/nvim-telescope/telescope.nvim

--]]


-- bootstrapping packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
local packer = require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
    	'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({with_sync = true})
            ts_update()
        end,
    }

    -- better color the arguments
    use {
        'm-demare/hlargs.nvim',
        config = function()
            require('hlargs').setup()
        end
    }

    -- color hex codes
    use {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup()
        end
    }

    -- file explorer
    use {
        'nvim-tree/nvim-tree.lua',
         requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        config = function()
            require('nvim-tree').setup {
                view = {
                    width = 20
                }
            }
        end
    }

    -- only highlight the current code block
    use {
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup {}
        end
    }

    -- themes
    use 'connorholyday/vim-snazzy'
    use 'dracula/vim'

    if packer_bootstrap then
    	require('packer').sync()
    end
end)

require 'treesitter'

return packer

