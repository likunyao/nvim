-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify("正在安装Pakcer.nvim, 请稍后...")
    paccker_bootstrap =
        fn.system(
        {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
    )

    -- https://github.com/wbthomason/packer.nvim/issues/750
    local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
    if not string.find(vim.o.runtimepath, rtp_addition) then
        vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
    end
    vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("没有安装 packer.nvim")
    return
end

packer.startup({
  function(use)
    -- Packer 可以升级自己
    use("wbthomason/packer.nvim")
    -------------------------- plugins -----------------------------------------
    --gruvbox
    use("sainnhe/gruvbox-material")
    -- treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    })
    -- nvim-tree
    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
    })
    -- coc
    use({
      "neoclide/coc.nvim",
      branch = "release",
    })
    -- gitsigns
    use("lewis6991/gitsigns.nvim")
    -- wakatime
    use("wakatime/vim-wakatime")
    -- lualine
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
    })
    -- autopairs
    use("windwp/nvim-autopairs")
    -- toggleterm
    use({
      "akinsho/toggleterm.nvim",
      tag = "v2.*"
    })
    -- neogen
    use({
      "danymat/neogen",
      requires = "nvim-treesitter/nvim-treesitter",
    })
    -- telescope
    use({
      "nvim-telescope/telescope.nvim", branch = "0.1.x",
      requires = {'nvim-lua/plenary.nvim'}
    })
    use("LinArcX/telescope-env.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")
    --indent
    use("lukas-reineke/indent-blankline.nvim")
    --copilot
    use("github/copilot.vim")
  end,
    config = {
      display = {
        open_fn = function()
          return require('packer.util').float({ border = 'single' })
        end
      }
    }
})
