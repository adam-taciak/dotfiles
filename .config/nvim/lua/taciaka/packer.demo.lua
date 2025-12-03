-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
	-- Packer can manage itself
	use('wbthomason/packer.nvim')

	use({
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	})

	use({
		'Mofiqul/dracula.nvim',
		as = 'dracula',
		config = function()
--			vim.cmd('colorscheme dracula')
		end
	})

    use({
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            vim.cmd('colorscheme catppuccin')
        end
    })

	use({
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	})

	use('ThePrimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')

    use({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
        }

    })

--[[
    use({
        'huynle/ogpt.nvim',
        config = function()
            require('ogpt').setup({
                debug = {
                    log_level = 3,
                    notify_level = 3,
                },
                default_provider = 'openai',
                providers = {
                    openai = {
                        enabled = true,
                        model = '5test321',
                        api_host = 'https://primergy.openai.azure.com',
                        api_key = '<TOKEN>',
                    }
                }

            })
        end,
        requires = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim'
        }
    })
    ]]--

    use({
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt").setup({
               -- api_host_cmd = 'echo -n ""',
                api_key_cmd = 'echo <TOKEN>',
                api_type_cmd = 'echo azure',
                azure_api_base_cmd = 'echo https://primergyv4.openai.azure.com/',
                azure_api_engine_cmd = 'echo gpt-4',
                azure_api_version_cmd = 'echo 2024-05-01-preview',

                --azure_api_engine_cmd = 'echo -n ""',
                --azure_api_version_cmd = 'echo dummy',
                --api_key_cmd = 'echo <TOKEN>',
                --azure_api_base_cmd = 'echo https://ai-foundation-api.app/ai-foundation/chat-ai/gpt4-turbo',

                --openai_params = {
                --    model = 'gpt-4o-2024-05-13'
                --}
            })
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
            "nvim-telescope/telescope.nvim"
        }
    })


    use({
        'huynle/ogpt.nvim',
        config = function()
            require('ogpt').setup({
--                debug = {
--                    log_level = 0,
--                    notify_level = 0,
--               },
                default_provider = 'ollama',
                providers = {
                    ollama = {
                        api_host = 'http://10.172.181.54:8080', -- os.getenv('OLLAMA_API_HOST') or 'http://localhost:11434',
                        api_key = '', -- os.getenv('OLLAMA_API_KEY') or '',
                        model = 'llama3.2',
                    },
                    openai = {
                        api_host = 'https://ai-foundation-api.app/ai-foundation/chat-ai/gpt4',
                        api_key = '<TOKEN>',
                        model = 'gpt-4o-2024-05-13',
                    }
                }
            })
        end,
        requires = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim'
        }
    })

    use('vimwiki/vimwiki')


    use({
        "epwalsh/pomo.nvim",
            tag = "*",  -- Recommended, use latest release instead of latest commit
            requires = {
                -- Optional, but highly recommended if you want to use the "Default" timer
                "rcarriga/nvim-notify",
              },
          config = function()
            require("pomo").setup({
              -- See below for full list of options 👇
            })
          end,
    })

end)

