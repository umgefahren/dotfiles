local autocmd = vim.api.nvim_create_autocmd

autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    require("cmp").setup.buffer { sources = { { name = "crates" } } }
  end,
})

autocmd("BufEnter", {
  pattern = "*",
  callback = function(opts)
    local bufid = opts.buf
    local clients = vim.lsp.buf_get_clients(bufid)
    if vim.bo.buftype ~= 'terminal' then
      vim.opt_local.relativenumber = true
    end
  end
})

autocmd("TermOpen", {
  pattern = "*",
  desc = "Set terminal buffer options",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
  italic = true,
  bold = true,
  fg = '#38468f',
})

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
