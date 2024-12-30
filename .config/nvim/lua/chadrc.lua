-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadracula",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.ui = {
  tabufline = {
    lazyload = false,
  },
  telescope = { style = "bordered" },
  statusline = {
    separator_style = "round",
  },
}

M.nvdash = {
  load_on_startup = true,
}

return M
