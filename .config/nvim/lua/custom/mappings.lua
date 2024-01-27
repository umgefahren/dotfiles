---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>cd"] = { "<cmd> Copilot disable <CR>", "Disable GitHub Copilot", opts = { nowait = true } },
    ["<leader>ce"] = { "<cmd> Copilot enable <CR>", "Enable GitHub Copilot", opts = { nowait = true } },
    ["<leader>fl"] = { "<cmd> Telescope lsp_document_symbols <CR>", "List document symbols", opts = { nowait = true } },
    ["<leader>fL"] = {
      "<cmd> Telescope lsp_workspace_symbols <CR>",
      "List workspace symbols",
      opts = { nowait = true },
    },
    ["<leader>mm"] = {
      function()
        require("bookmarks").bookmark_toggle()
      end,
      "Add/Remove bookmark at current line",
    },
    ["<leader>mi"] = {
      function()
        require("bookmarks").bookmark_ann()
      end,
      "Add/Edit mark annotation at current line",
    },
    ["<leader>mc"] = {
      function()
        require("bookmarks").bookmark_clean()
      end,
      "Clean all marks in local buffer",
    },
    ["<leader>mn"] = {
      function()
        require("bookmarks").bookmark_next()
      end,
      "Jump to next mark in local buffer",
    },
    ["<leader>mp"] = {
      function()
        require("bookmarks").bookmark_prev()
      end,
      "Jump to previous mark in local buffer",
    },
    ["<leader>ml"] = {
      function()
        require("bookmarks").bookmark_list()
      end,
      "Show marked file list in quickfix window",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>mf"] = {
      "<cmd> Telescope bookmarks list <CR>",
      "List bookmarks",
      opts = { nowait = true },
    },
  },
}

return M
