-------------------------------------
-------------------------------------
-- LOAD = INIT
-------------------------------------
-------------------------------------
function love.load()
-- Random seed
  math.randomseed(os.time())
  
-- Shapes
  Shapes = 
  {
    {
      {4, 1},
      {5, 1},
      {6, 1},
      {7, 1}
    }, -- I (line)
    {
      {4, 2},
      {5, 2},
      {6, 2},
      {6, 1}
    }, -- L
    {
      {4, 1},
      {4, 2},
      {5, 2},
      {6, 2}
    }, -- RL
    {
      {5, 1},
      {5, 2},
      {6, 1},
      {6, 2}
    }, -- O (square)
    {
      {4, 2},
      {5, 2},
      {5, 1},
      {6, 1}
    }, -- S
    {
      {4, 1},
      {5, 1},
      {5, 2},
      {6, 2}
    }, -- Z
    {
      {4, 2},
      {5, 1},
      {5, 2},
      {6, 2}
    }, -- T
    {
      {5, 1}
    }, -- tiny (1 pixel)
  }
  
-- THE current Shape
  current = {}
  timer = 0
  
  -- 10*18
  map = {
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
  }
  
  print("#map", #map, "#map[#map]", #map[#map])
  
  window = {}
  window.x = 20
  window.y = 20
  
  newShape()
  
  love.window.setMode(440, 600, {resizable=true, vsync=false, minwidth=280, minheight=440})
end

-------------------------------------
-------------------------------------
-- UPDATE = WORK AT EACH TIME
-------------------------------------
-------------------------------------
function love.update(dt)
  timer = timer + dt
  
--  if (madeALine()) then
--    updateGrid()
--  end

  local res_lines = checkForLine()
  
  if next(res_lines) ~= nil then
    updateGrid(res_lines)
  end
  
  if not testMap(0,1) then
    newShape()
  end
  
  if timer >= 1 then
--    debugPrintMatrix()
    if next(current) ~= nil then
      if testMap(0, 1) then
        updateMapDown()
      end
    end
    timer = 0
  end  
end

-------------------------------------
-------------------------------------
-- DRAW = UI
-------------------------------------
-------------------------------------
function love.draw()
  love.graphics.setBackgroundColor(100,100,100,255)
  
  -- squares
  printGrid()
  
  -- grid
  printLines()
end

-------------------------------------
-------------------------------------
-- KEYPRESSED = ARROWS CONTROLS
-------------------------------------
-------------------------------------
function love.keypressed(key)
  if next(current) ~= nil then
    if key == "down" then
      if testMap(0, 1) then
        updateMapDown()
      end
    elseif key == "left" then
      if testMap(-1, 0) then
        updateMapLeft()
      end
    elseif key == "right" then
      if testMap(1, 0) then
        updateMapRight()
      end
    elseif key == " " then
      updateMapBottom()
    end
  end
end

-------------------------------------
-------------------------------------
-- testMap = BOUNDARIES OF THE GRID
-------------------------------------
-------------------------------------
function testMap(x, y)
  if next(current) == nil then
    return false
  else
    local i
    local nb_pieces = 0
    
    for i = 1, #current do
      local px = current[i][1]
      local py = current[i][2]
      
      if ((py + y) <= #map) and ((py + y) > 0) and
        ((px + x) <= #map[#map]) and ((px + x) > 0) then
          if (map[py+y][px+x] ~= 1) then
            nb_pieces = nb_pieces + 1
          end
      end
    end
    
    return (nb_pieces == #current)
  end
end

-------------------------------------
-------------------------------------
-- printLines = PRINT THE FRAME OF THE GRID
-------------------------------------
-------------------------------------
function printLines()
  love.graphics.setColor(0,0,0,255)
  local h = #map
  local w = #map[#map]
  local mx = window.x*w
  local my = window.y*h
  
  love.graphics.line(0, 0, 0, my)
  love.graphics.line(0, 0, mx, 0)
  love.graphics.line(0, my, mx, my)
  love.graphics.line(mx, 0, mx, my)
end

-------------------------------------
-------------------------------------
-- printGrid = PRINT THE MATRIX-GRID (SQUARES OR EMPTY)
-------------------------------------
-------------------------------------
function printGrid()
  love.graphics.setColor(255,0,127,255)
  local w, h
  
  for h=1,#map,1 do
    for w=1,#map[h] do
      if (map[h][w] ~= 0) then
        love.graphics.rectangle("fill", (w - 1) * window.x, (h - 1) * window.y, window.x, window.y)
      end
    end
  end
end


function newShape()
  local i
  
  for i = 1, #current do
    local x = current[i][1]
    local y = current[i][2]
    map[y][x] = 1
  end

  current = deepCopy(Shapes[math.random(1,8)])
  
  for i = 1, #current do
    local x = current[i][1]
    local y = current[i][2]
    map[y][x] = 2
  end
  
--  debugPrintMatrix()
end


-------------------------------------
-------------------------------------
-- updateMapDown = MOVES THE CURRENT SHAPE DOWN
-------------------------------------
-------------------------------------
function updateMapDown()
  local i 
  
  for i = 1, #current  do
    local x = current[i][1]
    local y = current[i][2]
    map[y][x] = 0
    current[i][2] = y + 1
  end
  
  for i = 1, #current do
    map[current[i][2]][current[i][1]] = 2 
  end
end

-------------------------------------
-------------------------------------
-- updateMapLeft = MOVES THE CURRENT SHAPE LEFT
-------------------------------------
-------------------------------------
function updateMapLeft()
  local i
  
  for i = 1, #current do
    local x = current[i][1]
    local y = current[i][2]
    map[y][x] = 0
--    map[y][x-1] = 2
    current[i][1] = x - 1
  end
  
  for i = 1, #current do
    map[current[i][2]][current[i][1]] = 2 
  end
end


-------------------------------------
-------------------------------------
-- updateMapRight = MOVES THE CURRENT SHAPE RIGHT
-------------------------------------
-------------------------------------
function updateMapRight()
  local i
  
  for i = 1, #current do
    local x = current[i][1]
    local y = current[i][2]
    map[y][x] = 0
--    map[y][x+1] = 2
    current[i][1] = x + 1
  end
  
  for i = 1, #current do
    map[current[i][2]][current[i][1]] = 2 
  end
end


-------------------------------------
-------------------------------------
-- updateMapBottom = MOVES THE CURRENT SHAPE STRAIGHT TO THE BOTTOM OF THE GRID
-------------------------------------
-------------------------------------
function updateMapBottom()
  while testMap(0, 1) do
    updateMapDown()
  end
end

---------------------------------------
---------------------------------------
---- findTopOfCol = STACKS SQUARE ON TOP OF OTHERS IF SO
---------------------------------------
---------------------------------------
--function findTopOfCol(x)
--  local i
--  for i=#map,1,-1 do
--    if map[i][x] == 0 then
--      return i
--    end
--  end
--  return 1
--end

-------------------------------------
-------------------------------------
-- checkForLine = IF A LINE IS COMPLETE RETURNS YES
-------------------------------------
-------------------------------------
function checkForLine()
  local h, w
  local nb_pixels = 0
  local res_lines = {}
  
  for h=1,#map do
    nb_pixels = 0
    
    for w=1,#map[#map] do
      if map[h][w] == 1 then
        nb_pixels = nb_pixels + 1
      end
    end
    
    if nb_pixels == #map[#map] then
      table.insert(res_lines, h)
    end
  end
 
  return res_lines
end

-------------------------------------
-------------------------------------
-- updateGrid = IF A LINE IS MADE, ERASES IT AND STACKS EVERYTHING ONE LEVEL DOWN & MAKES A NEW SQUARE
-------------------------------------
-------------------------------------
function updateGrid(res_lines)
  for k, v in pairs(res_lines) do
    local line = v
    local h, w
    
    for w=1,#map[#map] do
      map[line][w] = 0
    end
    
    for h=line,1,-1 do
      for w=1,#map[#map] do
        map[h][w] = map[h-1][w]
      end
    end    
  end
  
--  local h, w
    
--  for w=1,#map[#map],1 do
--    map[#map][w] = 0
--  end
  
--  local point
  
--  for h=#map-1,1,-1 do
--    for w=#map[h],1,-1 do
--      if (map[h][w] == 1) then
--        map[h][w] = 0
--        map[h+1][w] = 1
--      end
--    end
--  end

  newShape()
end

-------------------------------------
-------------------------------------
-- debugPrintMatrix = PRINTS THE MATRIX FOR DEBUG
-------------------------------------
-------------------------------------
function debugPrintMatrix()
  local w, h
  local string = "("
  
  for h=1,#map do
    for w=1,#map[h] do
      string = string .. tostring(map[h][w]) .. ", "
    end
    print(string .. ")")
    string = "("
  end
  print("\n\n")
end


function deepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        -- as before, but if we find a table, make sure we copy that too
        if type(v) == 'table' then
            v = deepCopy(v)
        end
        copy[k] = v
    end
    return copy
end
