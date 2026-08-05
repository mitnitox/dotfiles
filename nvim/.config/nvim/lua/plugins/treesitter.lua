return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local install_dir = vim.fn.stdpath('data') .. '/site'

    vim.opt.rtp:prepend(install_dir)

    require('nvim-treesitter').setup({
      install_dir = install_dir,
    })

-- Instala los parsers que quieras
    require('nvim-treesitter').install({
      'lua', 'vim', 'vimdoc', 'query',
      'bash', 'json', 'markdown', 'markdown_inline',
      'go', 'python', 'javascript', 'typescript',
      -- agrega los que uses: 'python', 'go', 'javascript', 'typescript', etc.
    })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'lua', 'vim', 'vimdoc', 'query', 'bash', 'json', 'markdown' },
      callback = function() vim.treesitter.start() end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'lua', 'vim', 'vimdoc', 'query', 'bash', 'json', 'markdown' },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'lua', 'vim', 'vimdoc', 'query', 'bash', 'json', 'markdown' },
      callback = function()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
      end,
    })
  end,
}
