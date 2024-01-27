---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

local function generate_maze(height, width)
  math.randomseed(os.time())
  -- Initialize grid
  local grid = {}
  for y = 1, height do
    grid[y] = {}
    for x = 1, width do
      grid[y][x] = "█"
    end
  end

  -- DFS to generate maze
  local dx = { 0, 1, 0, -1 }
  local dy = { -1, 0, 1, 0 }

  local function dfs(x, y)
    local directions = { 0, 1, 2, 3 }

    -- Shuffle directions
    for i = #directions, 2, -1 do
      local j = math.random(i)
      directions[i], directions[j] = directions[j], directions[i]
    end

    for _, dir in ipairs(directions) do
      local nx, ny = x + dx[dir + 1] * 2, y + dy[dir + 1] * 2

      if nx > 0 and nx <= width and ny > 0 and ny <= height and grid[ny][nx] == "█" then
        grid[y + dy[dir + 1]][x + dx[dir + 1]] = " "
        grid[ny][nx] = " "
        dfs(nx, ny)
      end
    end
  end

  -- Ensure that all border cells are walls
  for x = 1, width do
    grid[1][x] = "█"
    grid[height][x] = "█"
  end
  for y = 1, height do
    grid[y][1] = "█"
    grid[y][width] = "█"
  end

  -- Start DFS
  grid[2][2] = "S" -- Starting point
  grid[height - 1][width - 1] = "E" -- Ending point
  dfs(2, 2)

  grid[2][2] = " "
  grid[height - 1][width - 1] = " "

  -- Convert grid to array of strings
  local maze_str_arr = {}
  for y = 1, height do
    maze_str_arr[y] = table.concat(grid[y], "")
  end

  return maze_str_arr
end

M.ui = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = {
    load_on_startup = true,
    header = generate_maze(9, 31),
  },

  statusline = {
    overriden_modules = function(modules)
      table.insert(
        modules,
        11,
        (function()
          local battery_status = require('battery').get_status_line()
          return "▏" .. battery_status .. " "
        end)()
      )
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
