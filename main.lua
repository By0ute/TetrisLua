-------------------------------------
-------------------------------------
-- LOAD = INIT
-------------------------------------
-------------------------------------
function love.load()
--  squares = {}
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
  
  window = {}
  window.x = 20
  window.y = 20
  
  newSquare()
  
  love.window.setMode(440, 600, {resizable=true, vsync=false, minwidth=280, minheight=440})
end

-------------------------------------
-------------------------------------
-- UPDATE = WORK AT EACH TIME
-------------------------------------
-------------------------------------
function love.update(dt)  
  timer = timer + dt
  
  if (madeALine()) then
    updateGrid()
  end
  
  if current.y == 18 then
    newSquare()
  end
  
  if timer >= 1 then
    if next(current) ~= nil then
      print("c.x", current.x, "c.y", current.y)
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
--      (map[current.y + y][current.x + x] == 1)
    elseif  ((current.y + y) > #map) or
            ((current.y + y) <= 0) or
            ((current.x + x) > #map[#map]) or
            ((current.x + x) <= 0) then
      return false
    end
    return true
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
  
  print("w", w, "h", h, "mx", mx, "my", my)
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
      if map[h][w] == 1 then
        love.graphics.rectangle("fill", (w - 1) * window.x, (h - 1) * window.y, window.x, window.y)
      end
    end
  end
end

-------------------------------------
-------------------------------------
-- newSquare = CREATES A NEW SQUARE ON TOP OF THE GRID
-------------------------------------
-------------------------------------
function newSquare()
  current.x = 5
  current.y = 1
  map[current.y][current.x] = 1
end

-------------------------------------
-------------------------------------
-- updateMapDown = MOVES THE CURRENT SQUARE DOWN
-------------------------------------
-------------------------------------
function updateMapDown()
  if (map[current.y + 1][current.x] == 1) then
    newSquare()
  else
    map[current.y][current.x] = 0
    current.y = current.y + 1
    map[current.y][current.x] = 1
  end
end

-------------------------------------
-------------------------------------
-- updateMapLeft = MOVES THE CURRENT SQUARE LEFT
-------------------------------------
-------------------------------------
function updateMapLeft()
  if (map[current.y][current.x - 1] == 0) then
    map[current.y][current.x] = 0
    current.x = current.x - 1
    map[current.y][current.x] = 1
  end
end


-------------------------------------
-------------------------------------
-- updateMapRight = MOVES THE CURRENT SQUARE RIGHT
-------------------------------------
-------------------------------------
function updateMapRight()
  if (map[current.y][current.x + 1] == 0) then
    map[current.y][current.x] = 0
    current.x = current.x + 1
    map[current.y][current.x] = 1
  end
end


-------------------------------------
-------------------------------------
-- updateMapBottom = MOVES THE CURRENT SQUARE BOTTOM
-------------------------------------
-------------------------------------
function updateMapBottom()
  if (map[#map][current.x] == 1) then
    local y = findTopOfCol(current.x)
    map[current.y][current.x] = 0
    current.y = y
    map[current.y][current.x] = 1
  else
    map[current.y][current.x] = 0
    current.y = #map
    map[current.y][current.x] = 1
  end
end

-------------------------------------
-------------------------------------
-- findTopOfCol = STACKS SQUARE ON TOP OF OTHERS IF SO
-------------------------------------
-------------------------------------
function findTopOfCol(x)
  local i
  for i=#map,1,-1 do
    if map[i][x] == 0 then
      return i
    end
  end
  return 1
end

-------------------------------------
-------------------------------------
-- madeALine = IF A LINE IS COMPLETE RETURNS YES
-------------------------------------
-------------------------------------
function madeALine()
  local i
  for i=1,#map,1 do
    if map[#map][i] == 0 then
      return false
    end
  end
  return true
end

-------------------------------------
-------------------------------------
-- updateGrid = IF A LINE IS MADE, ERASES IT AND STACKS EVERYTHING ONE LEVEL DOWN & MAKES A NEW SQUARE
-------------------------------------
-------------------------------------
function updateGrid()
  local h, w
    
  for w=1,#map[#map],1 do
    map[#map][w] = 0
  end
  
  local point
  
  for h=#map-1,1,-1 do
    for w=#map[h],1,-1 do
      if (map[h][w] == 1) then
        map[h][w] = 0
        map[h+1][w] = 1
      end
    end
  end
  
  newSquare()
end