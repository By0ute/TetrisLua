-------------------------------------
-------------------------------------
-- LOAD = INIT
-------------------------------------
-------------------------------------
function love.load()
-- Interface
  window = {x = 20, y = 20}
  love.window.setMode(360, 400, {resizable=false})
  
-- music
  sounds = {music = love.audio.newSource("tetris.mp3"),
            menu = love.audio.newSource("menu.mp3", "static"),
            game_over = love.audio.newSource("gameover.mp3", "static"),
            move = love.audio.newSource("move.mp3", "static"),
            bottom = love.audio.newSource("bottom.mp3", "static"),
            rotate = love.audio.newSource("rotate.mp3", "static"),
            line = love.audio.newSource("line.mp3", "static")}
  sounds.music:setVolume(0.7)
  sounds.music:play()
  
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
  
  resetGame()
end

function resetGame()
  shape = {pts = {}, nb = 0, rot_state = 0, next_nb = 0}
  score = {current = 0, last = 0}
  game = {over = false, on = false, pause = false, timer = 0}
  menu = {start = {true, 0, 0.5}}
  
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
  game.timer = game.timer + dt
  
  if sounds.music:isStopped() then
    sounds.music:play()
  end
  
  if ((game.on == true) and (game.pause == false)) then    

    if game.timer >= 1 then
      if next(shape.pts) ~= nil then
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
      game.timer = 0
    end
    
  elseif (game.on == false) then
    if (menu.start[2] < 0) then
      menu.start[1] = false
      menu.start[2] = 0
    elseif (menu.start[2] > menu.start[3]) then
      menu.start[1] = true
      menu.start[2] = menu.start[3]
    elseif (menu.start[1] == true) then
      menu.start[2] = menu.start[2] - dt
    elseif (menu.start[1] == false) then
      menu.start[2] = menu.start[2] + dt
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
  
  -- controls
  printControls()
  
  -- squares
  printGrid()
  
  -- grid
  printLines()
  
  -- score
  printScore()
  
  -- next shape
  printNextShape()
  
  -- new game if game off
  if (game.on == false) then
    printNewGame()
    
    if (menu.start[1] == true) then
      printPressStart()
    end
  end
  
  if game.over then
    printGameOver()
  end
  
  if game.pause then
    printPause()
  end
end

-------------------------------------
-------------------------------------
-- KEYPRESSED = ARROWS CONTROLS
-------------------------------------
-------------------------------------
function love.keypressed(key)
  if (game.on == false) and (key == " ") then
    sounds.menu:play()
    game.on = true
    game.over = false
    newShape(false)
  elseif (key == "p") or (key == "P") then
    sounds.menu:play()
    game.pause = not game.pause
  elseif (key == "q") or (key == "Q") then
    love.event.quit()
  elseif (game.pause == false) and (next(shape.pts) ~= nil) then
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
    end
  end
end

-------------------------------------
-------------------------------------
-- testMap = BOUNDARIES OF THE GRID
-------------------------------------
-------------------------------------
function testMap(x, y)
  if next(shape.pts) == nil then
    return false
  else
    local i
    local nb_pieces = 0
    
    for i = 1, #shape.pts do
      local px = shape.pts[i][1]
      local py = shape.pts[i][2]
      
      if ((py + y) <= #map) and ((py + y) > 0) and
        ((px + x) <= #map[#map]) and ((px + x) > 0) then
          if (map[py+y][px+x] ~= 1) then
            nb_pieces = nb_pieces + 1
          end
      end
    end
    
    return (nb_pieces == #shape.pts)
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
  
  love.graphics.setNewFont("VCR_OSD_MONO.ttf", 30)  
  love.graphics.setColor(255, 255, 0, 255)
  love.graphics.printf(tostring(score.current), x, my/2, window.x * w/2, 'center')
end

function printNextShape()
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
  
  if (shape.next_nb ~= 0) then
    local next_shape = deepCopy(Shapes[shape.next_nb])
    local col = Colors[shape.next_nb]
    love.graphics.setColor(col)
    local i
    for i=1,#next_shape do
      local xx = next_shape[i][1] - 3
      local yy = next_shape[i][2]    
      love.graphics.rectangle("fill", x + xx * window.x, y + yy * window.y, window.x, window.y)
    end
  end
end

function printControls()
  local h = #map
  local w = #map[#map]
  local x = window.x * (w + 2)
  local y = window.x * (w + 4) / 2
  local mx = x + ((w*window.x) / 2)
  local my = y + ((w*window.x) / 2)
  
  love.graphics.setNewFont("Arrows.ttf", 25)
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.print("B", x, my + window.x)
  love.graphics.print("A", x, my + window.x*2)
  love.graphics.print("C", x, my + window.x*3)
  love.graphics.print("D", x, my + window.x*4)
  love.graphics.setNewFont("Roboto-Condensed.ttf", 15)
  love.graphics.print("SPACE", x, my + window.x*5)
  love.graphics.print("P", x, my + window.x*6)
  love.graphics.print("Q", x, my + window.x*7)
  
  local xx = x + window.x * 2.5
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.print("Go left", xx, my + window.x)
  love.graphics.print("Go Right", xx, my + window.x*2)
  love.graphics.print("Go Up", xx, my + window.x*3)
  love.graphics.print("Go Down", xx, my + window.x*4)
  love.graphics.print("Go Bottom", xx, my + window.x*5)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("Pause", xx, my + window.x*6)
  love.graphics.print("Quit!", xx, my + window.x*7)
end

function printNewGame()
  local h = #map
  local w = #map[#map]
  local x = window.x * 2
  local y = window.y * (h - 4)
  
  love.graphics.setNewFont("Mario-Kart-DS.ttf", 30)  
  love.graphics.setColor(255, 128, 0, 255)
  love.graphics.printf("NEW GAME", x, y, (window.x * (w-2)), 'center')
end

function printPressStart()
  local h = #map
  local w = #map[#map]
  local x = window.x * 2
  local y = window.y * (h - 2.5)
  
  love.graphics.setNewFont("Mario-Kart-DS.ttf", 20)  
  love.graphics.setColor(128, 0, 255, 255)
  love.graphics.printf("press", x, y, (window.x * (w-2)), 'center')
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf("SPACE", x, y + window.y, (window.x * (w-2)), 'center')
  love.graphics.setColor(128, 0, 255, 255)
  love.graphics.printf("to start", x, y + window.y*2, (window.x * (w-2)), 'center')
end

function printPause()
  local h = #map
  local w = #map[#map]
  local x = window.x * 2
  local y = window.y * (h/2)
  
  love.graphics.setNewFont("Roboto-Condensed.ttf", 40)  
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf("PAUSE", x, y, (window.x * (w-2)), 'center')
end

function gameOver()
  sounds.game_over:play()
  game.on = false
  game.over = true
  score.last = score.current
  resetGame()
end

function printGameOver()
  local h = #map
  local w = #map[#map]
  local x = window.x * 2
  local y = window.y * (h - 7)
  
  love.graphics.setNewFont("DoubleFeature20.ttf", 40)  
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.print("GAME OVER", x, y, -45)
  
  love.graphics.setNewFont("VCR_OSD_MONO.ttf", 40)  
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf(tostring(score.last), x + window.x * 2, y - window.y, (window.x * (w-2)), 'center')
end


function newShape(reset)
  local i
  
  if (reset) then
    for i = 1, #shape.pts do
      local x = shape.pts[i][1]
      local y = shape.pts[i][2]
      map[y][x] = 1
    end
  end

  local shape_number = math.random(1,8)
  
  if (shape.next_nb ~= 0) then
    local new_nb = shape.next_nb
    shape = {pts = deepCopy(Shapes[new_nb]), nb = new_nb, rot_state = 0, next_nb = shape_number}
  else  
    shape = {pts = deepCopy(Shapes[shape_number]), nb = shape_number, rot_state = 0, next_nb = math.random(1,8)}
  end
  
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    
    if map[y][x] == 1 then
      return gameOver()
    else
      map[y][x] = 2
      colors_map[y][x] = Colors[shape.nb]
    end
  end
end


-------------------------------------
-------------------------------------
-- updateMapDown = MOVES THE CURRENT SHAPE DOWN
-------------------------------------
-------------------------------------
function updateMapDown()
  sounds.move:play()
  
  local i 
  
  for i = 1, #shape.pts  do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 0
    colors_map[y][x] = {0,0,0,0}
    shape.pts[i][2] = y + 1
  end
  
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 2 
    colors_map[y][x] = Colors[shape.nb] 
  end
end

-------------------------------------
-------------------------------------
-- updateMapLeft = MOVES THE CURRENT SHAPE LEFT
-------------------------------------
-------------------------------------
function updateMapLeft()
  sounds.move:play()
  
  local i
  
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 0
    colors_map[y][x] = {0,0,0,0}
    shape.pts[i][1] = x - 1
  end
  
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 2 
    colors_map[y][x] = Colors[shape.nb] 
  end
end


-------------------------------------
-------------------------------------
-- updateMapRight = MOVES THE CURRENT SHAPE RIGHT
-------------------------------------
-------------------------------------
function updateMapRight()
  sounds.move:play()
  
  local i
  
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 0
    colors_map[y][x] = {0,0,0,0}
    shape.pts[i][1] = x + 1
  end
  
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 2 
    colors_map[y][x] = Colors[shape.nb] 
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
  
  sounds.bottom:play()
end


function rotateShape()
  local rotated_shape = deepCopy(shape.pts)
  
--  local rotation = Rotations[shape_number][rotation_state+1]
  local rotation = Rotations[shape.nb][shape.rot_state+1]
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
  sounds.rotate:play()
  
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 0
    colors_map[y][x] = {0,0,0,0}
  end
  
  for i = 1, #rotated_shape do
    local x = rotated_shape[i][1]
    local y = rotated_shape[i][2]
    map[y][x] = 2
    colors_map[y][x] = Colors[shape.nb]
  end
  
  shape.pts = rotated_shape
  shape.rot_state = (shape.rot_state + 1) % 4
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
 
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
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
    
    sounds.line:play()
    
    score.current = score.current + factorial(#res_lines)
  end
end

function factorial(nb)
  if nb < 0 then
    return 0
  end
    
  if (nb == 0) then
    return 1
  else
    return nb * factorial(nb-1)
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
