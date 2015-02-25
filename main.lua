-------------------------------------
-------------------------------------
-- LOAD = INIT
-------------------------------------
-------------------------------------
function love.load()
-- make the game working
  game_on = false
  
-- Random seed
  math.randomseed(os.time())
  
-- Colors
  Colors =
  {
    {0,200,200,255}, -- I
    {255,128,0,255}, -- L
    {0,0,255,255}, -- RL
    {255,255,0,255}, -- O
    {255,0,0,255}, -- Z
    {0,255,0,255}, -- S
    {255,0,127,255}, -- T
    {255,255,255,255} -- tiny
  }
  
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
  
-- ROTATIONS
  Rotations = 
  {
    {
      {{2,-2}, {1,-1}, {0,0}, {-1,1}},
      {{-2,2}, {-1,1}, {0,0}, {1,-1}},
      {{1,1}, {0,0}, {-1,-1}, {-2,-2}},
      {{-1,-1}, {0,0}, {1,1}, {2,2}}
    }, -- I
    {
      {{1,1}, {0,0}, {-1,-1}, {-2,0}},
      {{1,-1}, {0,0}, {-1,1}, {0,2}},
      {{-1,-1}, {0,0}, {1,1}, {2,0}},
      {{-1,1}, {0,0}, {1,-1}, {0,-2}}
    }, -- L
    {
      {{2,0}, {1,-1}, {0,0}, {-1,1}},
      {{0,2}, {1,1}, {0,0}, {-1,-1}},
      {{-2,0}, {-1,1}, {0,0}, {1,-1}},
      {{0,-2}, {-1,-1}, {0,0}, {1,1}}
    }, -- RL
    {
      {{0,0}, {0,0}, {0,0}, {0,0}},
      {{0,0}, {0,0}, {0,0}, {0,0}},
      {{0,0}, {0,0}, {0,0}, {0,0}},
      {{0,0}, {0,0}, {0,0}, {0,0}}
    }, -- O
    {
      {{1,1}, {0,0}, {-1,1}, {-2,0}},
      {{1,-1}, {0,0}, {1,1}, {0,2}},
      {{0,2}, {1,1}, {0,0}, {1,-1}},
      {{-2,0}, {-1,1}, {0,0}, {1,1}}
    }, -- S
    {
      {{2,0}, {1,1}, {0,0}, {-1,1}},
      {{-1,1}, {0,0}, {1,1}, {2,0}},
      {{0,2}, {-1,1}, {0,0}, {-1,-1}},
      {{-1,-1}, {0,0}, {-1,1}, {0,2}}
    }, -- Z
    {
      {{1,-1}, {1,1}, {0,0}, {-1,1}},
      {{1,1}, {-1,1}, {0,0}, {-1,-1}},
      {{-1,1}, {-1,-1}, {0,0}, {1,-1}},
      {{-1,-1}, {1,-1}, {0,0}, {1,1}}
    }, -- T
    {
      {{0,0}},
      {{0,0}},
      {{0,0}},
      {{0,0}}
    } -- tiny
  }
  
-- THE current Shape
  current = {}
  shape_number = 0
  timer = 0
  score = 0
  rotation_state = 0
  color = {0,0,0,0}
  
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
  
  -- 10*18
  colors_map = {
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
  
  
  window = {x = 20, y = 20}
    
  love.window.setMode(440, 600, {resizable=true, vsync=false, minwidth=280, minheight=440})
end

function resetGame()
  current = {}
  shape_number = 0
  timer = 0
  score = 0
  rotation_state = 0
  color = {0,0,0,0}
  
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
  
  -- 10*18
  colors_map = {
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
  
end


-------------------------------------
-------------------------------------
-- UPDATE = WORK AT EACH TIME
-------------------------------------
-------------------------------------
function love.update(dt)
  if (game_on == true) then
    timer = timer + dt
    
    if timer >= 1 then
      if next(current) ~= nil then
        if testMap(0, 1) then
          updateMapDown()
        else
          local res_lines = checkForLine()
    
          if next(res_lines) ~= nil then
            updateGrid(res_lines)
            newShape(false)
          else
            newShape(true)
          end
        end
      end
      timer = 0
    end
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
  
  -- score
  printScore()
  
  -- print next piece
  printNextPiece()
end

-------------------------------------
-------------------------------------
-- KEYPRESSED = ARROWS CONTROLS
-------------------------------------
-------------------------------------
function love.keypressed(key)
  if (game_on == false) and (key == " ") then
    game_on = true
    newShape(false)
  elseif (game_on == false) and (key == 'p') then
    game_on = true
  elseif next(current) ~= nil then
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
    elseif key == "up" then
      rotateShape()
    elseif key == "p" then
      game_on = false
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
  local x = window.x
  local y = window.y
  local mx = x*(w+1)
  local my = y*(h+1)

  
  love.graphics.line(x, y, x, my)
  love.graphics.line(x, y, mx, y)
  love.graphics.line(x, my, mx, my)
  love.graphics.line(mx, y, mx, my)
end

-------------------------------------
-------------------------------------
-- printGrid = PRINT THE MATRIX-GRID (SQUARES OR EMPTY)
-------------------------------------
-------------------------------------
function printGrid()
  local w, h
  
  for h=1,#map,1 do
    for w=1,#map[h] do
      if (map[h][w] ~= 0) then
        love.graphics.setColor(colors_map[h][w])
        love.graphics.rectangle("fill", w * window.x, h * window.y, window.x, window.y)
      end
    end
  end
end

function printScore()
  love.graphics.setColor(0,0,0,255)
  local h = #map
  local w = #map[#map]
  local x = window.x * (w + 2)
  local y = window.x
  local mx = x + ((w*window.x) / 2)
  local my = y + ((w*window.x) / 2)

  
  love.graphics.line(x, y, x, my)
  love.graphics.line(x, y, mx, y)
  love.graphics.line(x, my, mx, my)
  love.graphics.line(mx, y, mx, my)
  
  local offset = calculateOffset(score)
  love.graphics.setColor(255, 255, 0, 255)
  love.graphics.print(tostring(score), (x+mx-window.x)/2, (my)/2, 0, 2, 2, offset, 0)
end

function printNextPiece()
  love.graphics.setColor(0,0,0,255)
  local h = #map
  local w = #map[#map]
  local x = window.x * (w + 2)
  local y = window.x * (w + 4) / 2
  local mx = x + ((w*window.x) / 2)
  local my = y + ((w*window.x) / 2)
  
  love.graphics.line(x, y, x, my)
  love.graphics.line(x, y, mx, y)
  love.graphics.line(x, my, mx, my)
  love.graphics.line(mx, y, mx, my)
  
  local piece = deepCopy(Shapes[3])
  local col = Colors[3]
  love.graphics.setColor(col)
  local i
  for i=1,#piece do
    local xx = piece[i][1] - 3
    local yy = piece[i][2]    
    love.graphics.rectangle("fill", x + xx * window.x, y + yy * window.y, window.x, window.y)
  end
end

function calculateOffset(score)
  if (score < 10) then
    return 0
  else
    local result = 2
    local s = score / 10
    while s >= 10 do
      result = result + 2
      s = s / 10
    end
  end
end

function gameOver()
end


function newShape(reset)
  local i
  
  if (reset) then
    for i = 1, #current do
      local x = current[i][1]
      local y = current[i][2]
      map[y][x] = 1
    end
  end

  rotation_state = 0
  shape_number = math.random(1,8)
  current = deepCopy(Shapes[shape_number])
  color = Colors[shape_number]
  
  for i = 1, #current do
    local x = current[i][1]
    local y = current[i][2]
    
    if map[y][x] == 1 then
      print("SCORE : ", score)
      game_on = false
      resetGame()
      return
    else
      map[y][x] = 2
      colors_map[y][x] = color
    end
  end
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
    colors_map[y][x] = {0,0,0,0}
    current[i][2] = y + 1
  end
  
  for i = 1, #current do
    local x = current[i][1]
    local y = current[i][2]
    map[y][x] = 2 
    colors_map[y][x] = color 
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
    colors_map[y][x] = {0,0,0,0}
    current[i][1] = x - 1
  end
  
  for i = 1, #current do
    local x = current[i][1]
    local y = current[i][2]
    map[y][x] = 2 
    colors_map[y][x] = color 
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
    colors_map[y][x] = {0,0,0,0}
    current[i][1] = x + 1
  end
  
  for i = 1, #current do
    local x = current[i][1]
    local y = current[i][2]
    map[y][x] = 2 
    colors_map[y][x] = color 
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


function rotateShape()
  local rotated_shape = deepCopy(current)
  
  local rotation = Rotations[shape_number][rotation_state+1]
  local i
  
  for i=1,#rotated_shape do
    rotated_shape[i][1] = rotated_shape[i][1] + rotation[i][1]
    rotated_shape[i][2] = rotated_shape[i][2] + rotation[i][2]
  end
  
  if gridOccupied(rotated_shape) == false then
    updateRotatedGrid(rotated_shape)
  end  
end

function gridOccupied(shape) 
  for k, v in pairs(shape) do
    local h = v[2]
    local w = v[1]
    
    if (h < 1) or (w < 1) or (h > #map) or (w > #map[#map]) or map[h][w] == 1 then
      return true
    end
  end
  
  return false
end

function updateRotatedGrid(rotated_shape)
  for i = 1, #current do
    local x = current[i][1]
    local y = current[i][2]
    map[y][x] = 0
    colors_map[y][x] = {0,0,0,0}
  end
  
  for i = 1, #rotated_shape do
    local x = rotated_shape[i][1]
    local y = rotated_shape[i][2]
    map[y][x] = 2
    colors_map[y][x] = color
  end
  
  current = rotated_shape
  rotation_state = (rotation_state + 1) % 4
end




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
      if map[h][w] ~= 0 then
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
  local i, k, v
 
  for i = 1, #current do
    local x = current[i][1]
    local y = current[i][2]
    map[y][x] = 1
  end
  
  for k, v in pairs(res_lines) do
    local line = v
    local h, w
    
    for w=1,#map[#map] do
      map[line][w] = 0
      colors_map[line][w] = {0,0,0,0}
    end
    
    for h=line,2,-1 do
      for w=1,#map[#map] do
        map[h][w] = map[h-1][w]
        colors_map[h][w] = colors_map[h-1][w]
      end
    end
    
    for w=1,#map[#map] do
      map[1][w] = 0
      colors_map[1][w] = {0,0,0,0}
    end
    
    score = score + 1
  end
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
        if type(v) == 'table' then
            v = deepCopy(v)
        end
        copy[k] = v
    end
    return copy
end
