-- File: pretty-ts-errors.lua
local M = {}

local api = vim.api
local fn = vim.fn

local function log_to_file(msg)
  local log_file = "/tmp/nvim_plugin.log" -- Change this path as needed
  local file = io.open(log_file, "a") -- Open file in append mode
  if file then
    file:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. msg .. "\n")
    file:close()
  else
    vim.api.nvim_err_writeln("Failed to open log file: " .. log_file)
  end
end

-- Configure plugin options with defaults
M.config = {
  executable = "pretty-ts-errors-markdown",
  float_opts = {
    border = "rounded",
    max_width = 80,
    max_height = 20,
  },
  auto_open = true,
}

-- Cache for storing formatted messages
local cache = {}

-- Execute external Node.js process to format error message
local function format_error(diagnostic)
  -- Skip if not from tsserver
  if diagnostic.source ~= "tsserver" then
    return nil
  end

  -- Check cache first
  local cache_key = diagnostic.code .. diagnostic.message
  if cache[cache_key] then
    return cache[cache_key]
  end

  local lsp_data = diagnostic.user_data.lsp

  -- Convert to JSON string and escape for shell
  local json_str = vim.fn.json_encode(lsp_data)
  json_str = json_str:gsub('"', '\\"')

  -- Build command
  local cmd = string.format('%s -i "%s"', M.config.executable, json_str)

  -- Execute the command
  local result = fn.system(cmd)

  -- Check if command succeeded
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to format TypeScript error: " .. result, vim.log.levels.ERROR)
    return nil
  end

  -- Cache the result
  cache[cache_key] = result

  return result
end

local floating_win_visible = false

-- Create a floating window with formatted error
function M.show_formatted_error()
  -- If we already have a floating window open, don't create another one
  if floating_win_visible then
    return
  end
  -- Get diagnostics under cursor
  local line = api.nvim_win_get_cursor(0)[1] - 1
  local ts_diagnostics = {}

  for _, diagnostic in ipairs(vim.diagnostic.get(0, { lnum = line })) do
    if diagnostic.source == "tsserver" then
      table.insert(ts_diagnostics, diagnostic)
    end
  end

  if #ts_diagnostics == 0 then
    vim.notify("No TypeScript errors under cursor", vim.log.levels.INFO)
    return
  end

  -- Format the first diagnostic (or we could show all)
  local formatted = format_error(ts_diagnostics[1])
  if not formatted then
    vim.notify("Could not format TypeScript error", vim.log.levels.ERROR)
    return
  end

  -- Create a scratch buffer for markdown
  local floating_buf = api.nvim_create_buf(false, true)
  -- api.nvim_buf_set_option(buf, "filetype", "markdown")
  api.nvim_set_option_value("filetype", "markdown", { buf = floating_buf })

  -- Add content to buffer
  api.nvim_buf_set_lines(floating_buf, 0, -1, false, vim.split(formatted, "\n"))

  -- Calculate window size
  local lines = vim.split(formatted, "\n")
  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, #line)
  end

  width = math.min(width, M.config.float_opts.max_width)
  local height = math.min(#lines, M.config.float_opts.max_height)

  -- Configure floating window
  local opts = {
    relative = "cursor",
    width = width,
    height = height,
    row = 1,
    col = 0,
    style = "minimal",
    border = M.config.float_opts.border,
  }

  -- Open floating window
  local main_buf = api.nvim_get_current_buf()
  local win = api.nvim_open_win(floating_buf, false, opts)
  floating_win_visible = true

  -- Close window when cursor moves
  local group = api.nvim_create_augroup("PrettyTsErrorsClose", { clear = false })
  for _, buf in ipairs({ floating_buf, main_buf }) do
    api.nvim_create_autocmd({ "CursorMoved", "BufEnter", "InsertEnter" }, {
      buffer = buf,
      group = group,
      callback = function()
        local current_buf = api.nvim_get_current_buf()

        if buf == floating_buf and current_buf == floating_buf then
          return
        end

        if api.nvim_win_is_valid(win) then
          api.nvim_win_close(win, true)
          floating_win_visible = false
          api.nvim_del_augroup_by_id(group)
        end
      end,
    })
  end
end

-- Function to open a full buffer with all TS errors
function M.open_all_errors()
  -- Get all diagnostics in the current buffer
  local all_diagnostics = vim.diagnostic.get(0)
  local ts_diagnostics = {}

  for _, diagnostic in ipairs(all_diagnostics) do
    if diagnostic.source == "tsserver" then
      table.insert(ts_diagnostics, diagnostic)
    end
  end

  if #ts_diagnostics == 0 then
    vim.notify("No TypeScript errors in this file", vim.log.levels.INFO)
    return
  end

  -- Create a new buffer
  local buf = api.nvim_create_buf(true, true)
  api.nvim_buf_set_option(buf, "filetype", "markdown")

  -- Format and collect all errors
  local contents = { "# TypeScript Errors\n" }

  for i, diagnostic in ipairs(ts_diagnostics) do
    local formatted = format_error(diagnostic)
    if formatted then
      local location = string.format("## Error %d (Line %d, Col %d)\n\n", i, diagnostic.lnum + 1, diagnostic.col + 1)
      table.insert(contents, location)
      for _, line in ipairs(vim.split(formatted, "\n")) do
        table.insert(contents, line)
      end
      table.insert(contents, "\n---\n")
    end
  end

  -- Set the buffer content
  api.nvim_buf_set_lines(buf, 0, -1, false, contents)

  -- Open the buffer in a new window
  api.nvim_command("vsplit")
  local win = api.nvim_get_current_win()
  api.nvim_win_set_buf(win, buf)

  -- Set buffer name
  api.nvim_buf_set_name(buf, "TypeScript-Errors")

  -- Make it read-only
  api.nvim_buf_set_option(buf, "modifiable", false)

  -- Add key mappings for the buffer
  api.nvim_buf_set_keymap(buf, "n", "q", ":bdelete<CR>", { noremap = true, silent = true })

  return buf
end

function M.enable_auto_open()
  local group = api.nvim_create_augroup("PrettyTsErrorsAuto", { clear = true })
  api.nvim_create_autocmd("CursorHold", {
    pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
    group = group,
    callback = function()
      local line = api.nvim_win_get_cursor(0)[1] - 1
      local has_ts_error = false

      for _, diagnostic in ipairs(vim.diagnostic.get(0, { lnum = line })) do
        if diagnostic.source == "tsserver" then
          has_ts_error = true
          break
        end
      end

      if has_ts_error then
        M.show_formatted_error()
      end
    end,
  })
end

function M.toggle_auto_open()
  -- Toggle the auto_open setting
  M.config.auto_open = not M.config.auto_open

  -- Clear existing autocommand group if it exists
  api.nvim_create_augroup("PrettyTsErrorsAuto", { clear = true })

  -- If auto_open is now enabled, recreate the autocommands
  if M.config.auto_open then
    M.enable_auto_open()
    vim.notify("TypeScript error auto-display on hover: Enabled", vim.log.levels.INFO)
  else
    vim.notify("TypeScript error auto-display on hover: Disabled", vim.log.levels.INFO)
  end
end

-- Setup function to initialize the plugin
function M.setup(opts)
  -- Merge user options with defaults
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  -- Create commands
  api.nvim_create_user_command("PrettyTsError", function()
    M.show_formatted_error()
  end, {})

  api.nvim_create_user_command("PrettyTsErrors", function()
    M.open_all_errors()
  end, {})

  -- Add the toggle command
  api.nvim_create_user_command("PrettyTsToggleAuto", function()
    M.toggle_auto_open()
  end, {})

  -- Autocommands for auto-showing errors on hover (if enabled)
  if M.config.auto_open then
    M.enable_auto_open()
  end
end

return M
