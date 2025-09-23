--- @param node TSNode
local toggle_function = function(node)
  local helpers = require("ts-node-action.helpers")
  local node_type = node:type()

  if node_type == "function_declaration" then
    -- Example: function a() { return "a"; }
    local s = helpers.destructure_node(node)
    local name = s.name or ""
    local params = s.parameters or "()"
    local body = vim.deepcopy(s.body or {})
    -- handle opening brace
    if #body > 0 then
      local first = vim.trim(body[1])
      if first == "{" then
        table.remove(body, 1)
      elseif first:sub(1, 1) == "{" then
        body[1] = vim.trim(first:sub(2)) -- remove only the leading {
      end
    end
    -- create new text
    local new_text = {
      "const " .. name .. " = " .. params .. " => {",
    }
    for _, line in ipairs(body) do
      table.insert(new_text, line)
    end
    return new_text, { format = true, cursor = {} }
  end

  if node_type == "lexical_declaration" then
    local variable_declarator = node:child(1)

    if variable_declarator and variable_declarator:type() ~= "variable_declaration" then
      local name_node = variable_declarator:field("name")[1]
      local value_node = variable_declarator:field("value")[1]

      if name_node and value_node and name_node:type() == "identifier" and value_node:type() == "arrow_function" then
        local name = helpers.destructure_node(variable_declarator).name
        local s_value = helpers.destructure_node(value_node)
        local params = s_value.parameters or "()"
        local param = s_value.parameter
        if param then
          params = "(" .. param .. ")"
        end

        -- normalize body into a table of lines
        local body = s_value.body
        if type(body) == "string" then
          body = { body }
        elseif type(body) ~= "table" then
          body = {}
        else
          body = vim.deepcopy(body)
        end

        local had_braces = false
        -- remove opening brace if present
        if #body > 0 then
          local first = vim.trim(body[1])
          if first == "{" then
            table.remove(body, 1)
            had_braces = true
          elseif first:sub(1, 1) == "{" then
            body[1] = vim.trim(first:sub(2))
            had_braces = true
          end
        end

        -- remove closing brace if present
        if #body > 0 then
          local last = vim.trim(body[#body])
          if last == "}" then
            table.remove(body, #body)
            had_braces = true
          elseif last:sub(-1) == "}" then
            body[#body] = vim.trim(last:sub(1, #last - 1))
            had_braces = true
          end
        end

        -- if there were no braces, wrap with return
        if not had_braces and #body == 1 then
          body[1] = "return " .. vim.trim(body[1])
        end

        -- construct function
        local new_text = { "function " .. name .. params .. " {" }
        for _, line in ipairs(body) do
          table.insert(new_text, line)
        end
        table.insert(new_text, "}")
        return new_text, { format = true, cursor = {} }
      end
    end
  end
end

return {
  "ckolkey/ts-node-action",
  enabled = true,
  config = function()
    require("ts-node-action").setup({
      javascript = {
        ["function_declaration"] = toggle_function,
        ["lexical_declaration"] = toggle_function,
      },
      typescript = {
        ["function_declaration"] = toggle_function,
        ["lexical_declaration"] = toggle_function,
      },
      jsx = {
        ["function_declaration"] = toggle_function,
        ["lexical_declaration"] = toggle_function,
      },
      tsx = {
        ["function_declaration"] = toggle_function,
        ["lexical_declaration"] = toggle_function,
      },
    })
  end,
  keys = {
    {
      "<leader>tk",
      function()
        require("ts-node-action").node_action()
      end,
      desc = "Trigger TS Node Action",
    },
  },
}
