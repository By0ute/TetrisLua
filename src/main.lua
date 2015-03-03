-- **********************************
-- **********************************
-- ********** INIT GAME *************
-- **********************************
-- **********************************

-------------------------------------
-- LOAD = INIT
-------------------------------------
function love.load()
-- Interface
  window = {x = 20, y = 20}
  love.window.setMode(360, 400, {resizable=false})
  
-- music
  sounds = {music = love.audio.newSource("musics/tetris.mp3"),
            menu = love.audio.newSource("musics/menu.mp3", "static"),
            game_over = love.audio.newSource("musics/gameover.mp3", "static"),
            move = love.audio.newSource("musics/move.mp3", "static"),
            bottom = love.audio.newSource("musics/bottom.mp3", "static"),
            rotate = love.audio.newSource("musics/rotate.mp3", "static"),
            line = love.audio.newSource("musics/line.mp3", "static"),
            play_music = false,
            play_sounds = false,}
  sounds.music:setVolume(0.7)
--  sounds.music:play()
  
-- Random seed
  math.randomseed(os.time())
  
-- Colors
  Colors =
  {
    {255,51,51,255}, -- I
    {255,51,255,255}, -- L
    {153,153,0,255}, -- RL
    {255,153,51,255}, -- O
    {255,51,153,255}, -- Z
    {153,76,0,255}, -- S
    {255,255,51,255}, -- T
    {153,0,76,255}, -- tiny
    {255, 255, 255, 255}, -- +
    {153, 0, 0, 255}, -- U
    {51, 255, 51, 255}, -- |_
    {153, 0, 153, 255}, -- f
    {51, 255, 153, 255}, -- <
    {76, 0, 153, 255}, -- I.
    {51, 255, 255, 255}, -- BT
    {0, 153, 153, 255}, -- S'
    {51, 51, 255, 255}, -- BZ
    {0, 153, 76, 255}, -- |
    {153, 51, 255, 255}, -- 6 
    {0, 153, 0, 255}, -- W 
    {0, 0, 0, 255}, -- I' 
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
    {
      {5, 1},
      {4, 2},
      {5, 2},
      {6, 2},
      {5, 3}
    }, -- +    
    {
      {4, 1},
      {4, 2},
      {5, 2},
      {6, 2},
      {6, 1}
    }, -- U
    {
      {4, 1},
      {4, 2},
      {4, 3},
      {5, 3},
      {6, 3}
    }, -- |_    
    {
      {6, 1},
      {5, 1},
      {5, 2},
      {5, 3},
      {4, 2}
    }, -- f
    {
      {5, 1},
      {5, 2},
      {4, 2},
    }, -- <
    {
      {5, 1},
      {5, 2},
      {5, 3},
      {5, 4},
      {6, 4}
    }, -- I.
    {
      {5, 1},
      {5, 2},
      {4, 3},
      {5, 3},
      {6, 3}
    }, -- BT
    {
      {4, 2},
      {5, 2},
      {5, 1},
      {6, 1},
      {7, 1}
    }, -- S'
    {
      {4, 3},
      {4, 2},
      {5, 2},
      {6, 2},
      {6, 1}
    }, -- BZ
    {
      {3, 1},
      {4, 1},
      {5, 1},
      {6, 1},
      {7, 1}
    }, -- |
    {
      {5, 1},
      {5, 2},
      {5, 3},
      {6, 3},
      {6, 2}
    }, -- 6 
    {
      {4, 3},
      {4, 2},
      {5, 2},
      {5, 1},
      {6, 1}
    }, -- W 
    {
      {5, 1},
      {5, 2},
      {5, 3},
      {5, 4},
      {6, 2}
    }, -- I'
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
    }, -- tiny
    {
      {{0,0}, {0,0}, {0,0}, {0,0}, {0,0}},
      {{0,0}, {0,0}, {0,0}, {0,0}, {0,0}},
      {{0,0}, {0,0}, {0,0}, {0,0}, {0,0}},
      {{0,0}, {0,0}, {0,0}, {0,0}, {0,0}},
    }, -- +
    {
      {{2,0}, {1,-1}, {0,0}, {-1,1}, {0,2}},
      {{0,2}, {1,1}, {0,0}, {-1,-1}, {-2,0}},
      {{-2,0}, {-1,1}, {0,0}, {1,-1}, {0,-2}},
      {{0,-2}, {-1,-1}, {0,0}, {1,1}, {2,0}},
    }, -- U    
    {
      {{2,0}, {1,-1}, {0,-2}, {-1,-1}, {-2,0}},
      {{0,2}, {1,1}, {2,0}, {1,-1}, {0,-2}},
      {{-2,0}, {-1,1}, {0,2}, {1,1}, {2,0}},
      {{0,-2}, {-1,-1}, {-2,0}, {-1,1}, {0,2}},
    }, -- |_    
    {
      {{0,2}, {1,1}, {0,0}, {-1,-1}, {1,-1}},
      {{-2,0}, {-1,1}, {0,0}, {1,-1}, {1,1}},
      {{0,-2}, {-1,-1}, {0,0}, {1,1}, {-1,1}},
      {{2,0}, {1,-1}, {0,0}, {-1,1}, {-1,-1}},
    }, -- f  
    {
      {{1,1}, {0,0}, {1,-1}},
      {{-1,1}, {0,0}, {1,1}},
      {{-1,-1}, {0,0}, {-1,1}},
      {{1,-1}, {0,0}, {-1,-1}},
    }, -- <    
    {
      {{2,1}, {1,0}, {0,-1}, {-1,-2}, {-2,-1}},
      {{-1,2}, {0,1}, {1,0}, {2,-1}, {1,-2}},
      {{-2,-1}, {-1,0}, {0,1}, {1,2}, {2,1}},
      {{1,-2}, {0,-1}, {-1,0}, {-2,1}, {-1,2}},
    }, -- I.
    {
      {{1,1}, {0,0}, {0,-2}, {-1,-1}, {-2,0}},
      {{-1,1}, {0,0}, {2,0}, {1,-1}, {0,-2}},
      {{-1,-1}, {0,0}, {0,2}, {1,1}, {2,0}},
      {{1,-1}, {0,0}, {-2,0}, {-1,1}, {0,2}},
    }, -- BT
    {
      {{1,-2}, {0,-1}, {1,0}, {0,1}, {-1,2}},
      {{2,1}, {1,0}, {0,1}, {-1,0}, {-2,-1}},
      {{-1,2}, {0,1}, {-1,0}, {0,-1}, {1,-2}},
      {{-2,-1}, {-1,0}, {0,-1}, {1,0}, {2,1}},
    }, -- S'
    {
      {{0,-2}, {1,-1}, {0,0}, {-1,1}, {0,2}},
      {{0,2}, {-1,1}, {0,0}, {1,-1}, {0,-2}},
      {{0,-2}, {1,-1}, {0,0}, {-1,1}, {0,2}},
      {{0,2}, {-1,1}, {0,0}, {1,-1}, {0,-2}},
    }, -- BZ
    {
      {{2,-2}, {1,-1}, {0,0}, {-1,1}, {-2,2}},
      {{-2,2}, {-1,1}, {0,0}, {1,-1}, {2,-2}},
      {{2,-2}, {1,-1}, {0,0}, {-1,1}, {-2,2}},
      {{-2,2}, {-1,1}, {0,0}, {1,-1}, {2,-2}},
    }, -- |
    {
      {{1,1}, {0,0}, {-1,-1}, {-2,0}, {-1,1}},
      {{-1,1}, {0,0}, {1,-1}, {0,-2}, {-1,-1}},
      {{-1,-1}, {0,0}, {1,1}, {2,0}, {1,-1}},
      {{1,-1}, {0,0}, {-1,1}, {0,2}, {1,1}},
    }, -- 6 
    {
      {{0,-2}, {1,-1}, {0,0}, {1,1}, {0,2}},
      {{2,0}, {1,1}, {0,0}, {-1,1}, {-2,0}},
      {{0,2}, {-1,1}, {0,0}, {-1,-1}, {0,-2}},
      {{-2,0}, {-1,-1}, {0,0}, {1,-1}, {2,0}},
    }, -- W 
    {
      {{2,1}, {1,0}, {0,-1}, {-1,-2}, {0,1}},
      {{-1,2}, {0,1}, {1,0}, {2,-1}, {-1,0}},
      {{-2,-1}, {-1,0}, {0,1}, {1,2}, {0,-1}},
      {{1,-2}, {0,-1}, {-1,0}, {-2,1}, {1,0}},
    }, -- I' 
  }

  -- pre set of data
  game = {over = false}
  score = {last = 0}
  shape = {max_random = #Shapes}
  
  -- new game
  resetGame()
end

-------------------------------------
-- resetGame = reset all data and grids
-------------------------------------
function resetGame()
  -- main data
  shape = {pts = {}, nb = 0, rot_state = 0, next_nb = 0, max_random = shape.max_random}
  score = {current = 0, last = score.last}
  game = {over = game.over, on = false, pause = false, timer = 0}
  menu = {start = {true, 0, 0.5}, controls = {false, false}}
  
  -- Tetris grid 18*10
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
  
  -- Colors grid 18*10
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
-- newShape = make a new Tetris shape randomly chosen
-- param reset : if there was a previous shape that needs to be locked in the grid
-------------------------------------
function newShape(reset)
  local i
  
  -- if previous shape, becomes old and locked in the grid
  if (reset) then
    for i = 1, #shape.pts do
      local x = shape.pts[i][1]
      local y = shape.pts[i][2]
      map[y][x] = 1
    end
  end

  -- max : level of Tetris (super/regular)
  local max = shape.max_random
  -- next shape chosen by random
  local shape_number = math.random(1,max)
  
  -- new chosen from next_nb
  if (shape.next_nb ~= 0) then
    local new_nb = shape.next_nb
    shape = {pts = deepCopy(Shapes[new_nb]),
            nb = new_nb,
            rot_state = 0,
            next_nb = shape_number,
            max_random = max}
  -- otherwise first shape
  else  
    shape = {pts = deepCopy(Shapes[shape_number]),
            nb = shape_number,
            rot_state = 0,
            next_nb = math.random(1,max),
            max_random = max}
  end
  
  -- update grids with new shape
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    
    -- if first line in the grid stuck : GAME OVER
    if map[y][x] == 1 then
      return gameOver()
    else
      map[y][x] = 2
      colors_map[y][x] = Colors[shape.nb]
    end
  end
end






-- **********************************
-- **********************************
-- ******** LOVE FUNCTIONS **********
-- **********************************
-- **********************************

-------------------------------------
-- update = automatically update with time dt
-------------------------------------
function love.update(dt)
  -- add time to the timer
  game.timer = game.timer + dt
  
  -- loop the music
  if (sounds.play_music == true) and (sounds.music:isStopped()) then
    sounds.music:play()
  end
  
  -- if game is on and no pause : update grids
  if ((game.on == true) and (game.pause == false)) then    

    -- every second update the grid down
    if game.timer >= 1 then
      if next(shape.pts) ~= nil then
        -- if shape can go down
        if testMap(0, 1) then
          updateMapDown()
        -- otherwise reach bottom : check if lines are made
        -- and make a new shape
        else
          local res_lines = checkForLine()

          if next(res_lines) ~= nil then
            updateGrid(res_lines)
            -- newShape has FALSE because previous shape was already updated in the grid with the lines update
            newShape(false)
          else
            -- newShape has TRUE to update the shape that just hit the bottom before make a new one
            newShape(true)
          end
        end
      end
      
      -- reset timer
      game.timer = 0
    end
  
  -- if the game is off : print Game Over
  elseif (game.on == false) then
    -- menu.start is blinking : [1] show/not show the text, [2] timer for blinking, [3] time step of blinking
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
-- keypressed = ARROWS CONTROLS
-------------------------------------
function love.keypressed(key)
  -- shows control keys of the game (stay pressed)
  if (key == "c") or (key == "C") then
    menu.controls[1] = true
    menu.controls[2] = game.pause
    if sounds.play_sounds == true then
      sounds.menu:play()
    end
    game.pause = true
  -- others keys
  -- if not showing control keys
  elseif (menu.controls[1] == false) then
    -- if game over and " " press : new game
    if (game.on == false) and (key == " ") then
      if sounds.play_sounds == true then
        sounds.menu:play()
      end
      game.on = true
      game.over = false
      newShape(false)
    -- if "p" : pause/not pause game
    elseif (key == "p") or (key == "P") then
      if sounds.play_sounds == true then
        sounds.menu:play()
      end
      game.pause = not game.pause
    -- "m" : on/off music
    elseif (key == "m") or (key == 'M') then
      sounds.play_music = not sounds.play_music
      if sounds.play_music == true then
        sounds.music:play()
      elseif sounds.play_music == false then
        sounds.music:stop()
      end
    -- "s" : on/off sounds
    elseif (key == "s") or (key == 'S') then
      sounds.play_sounds = not sounds.play_sounds
    -- "l" : super/regular Tetriss
    elseif (key == "l") or (key == 'L') then
      if shape.max_random == #Shapes then
        shape.max_random = 7
      else
        shape.max_random = #Shapes
      end
      shape.next_nb = math.random(0,shape.max_random)
    -- if game is not paused and there is a current shape
    -- movement keys
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
end

-------------------------------------
-- keyreleased = Quit and Controls
-------------------------------------
function love.keyreleased(key)
  -- if not showing controls and quitting game key : quit
   if (menu.controls[1] == false) and (key == "escape" or key == "q" or key == "Q") then
      love.event.quit()
  -- if "c" released, stop showing control keys and back to the game
  elseif (key == "c") or (key == "C") then
    menu.controls[1] = false    
    game.pause = menu.controls[2]
   end
end







-- **********************************
-- **********************************
-- ******** PRINT FUNCTIONS *********
-- **********************************
-- **********************************

-------------------------------------
-- draw = UI
-------------------------------------
function love.draw()
  love.graphics.setBackgroundColor(100,100,100,255)
  
  -- grid
  printLines()
  
  -- score
  printScore()
  
  -- next shape
  printNextShape()
  
  -- controls indication
  printControlsIndication()
  
  if (menu.controls[1] == true) then
    -- controls
    printControls()
  else    
    -- squares
    printGrid()
    
    -- new game if game off
    if (game.on == false) then
      printNewGame()
      
      -- blinking
      if (menu.start[1] == true) then
        printPressStart()
      end
    end
    
    -- game over with last score
    if game.over then
      printGameOver()
    end
    
    -- pause time
    if game.pause then
      printPause()
    end
  end
end




-------------------------------------
-- printLines = PRINT THE FRAME OF THE GRID
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
-- printGrid = PRINT THE MATRIX-GRID (SQUARES OR EMPTY)
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

-------------------------------------
-- printScore = PRINT THE CURRENT SCORE
-------------------------------------
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
  
  love.graphics.setNewFont("fonts/VCR_OSD_MONO.ttf", 30)  
  love.graphics.setColor(255, 255, 0, 255)
  love.graphics.printf(tostring(score.current), x, my/2, window.x * w/2, 'center')
end

-------------------------------------
-- printNextShape = SHOW THE NEXT SHAPE INCOMING
-------------------------------------
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

-------------------------------------
-- printControlsIndication = PRINT THE INDICATIONS TO SHOW CONTROL KEYS
-------------------------------------
function printControlsIndication()
  love.graphics.setColor(255,0,0,255)
  local h = #map
  local w = #map[#map]
  local x = window.x * (w + 2)
  local y = window.y * (h/2 + 5.5)
  local yy = window.y * (h/2 + 6.5)
  
  love.graphics.setNewFont("fonts/Roboto-Condensed.ttf", 20)  
  love.graphics.setColor(0, 0, 255, 255)
  love.graphics.printf("Press C", x, y, ((w*window.x) / 2), "center")
  love.graphics.setNewFont("fonts/Roboto-Condensed.ttf", 15)  
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf("to show Controls", x, yy, ((w*window.x) / 2), "center")
end

-------------------------------------
-- printControls = PRINT CONTROL KEYS
-------------------------------------
function printControls()
  local h = #map
  local w = #map[#map]
  local x = window.x * 2.1
  local y = window.y * 2
  local x_middle_left = (window.x * (w/2 - 2.5))
  local x_middle_right = x + (window.x * (w/2 - 2))
  local half_x = (window.x * (w/2))
  
  --
  -- KEYS
  --
  -- <-
  love.graphics.setNewFont("fonts/Arrows.ttf", 30)  
  love.graphics.setColor(0, 0, 255, 255)
  love.graphics.printf("B", x, y, x_middle_left, "right")
  -- ->
  love.graphics.printf("A", x, y + window.x*1.5, x_middle_left, "right")
  -- ^
  love.graphics.printf("C", x, y + window.x*3, x_middle_left, "right")
  -- v
  love.graphics.printf("D", x, y + window.x*4.5, x_middle_left, "right")
  -- SPACE
  love.graphics.setNewFont("fonts/Roboto-Condensed.ttf", 25)
  love.graphics.printf("SPACE", x, y + window.x*6, x_middle_left, "right")
  -- P
  love.graphics.printf("P", x, y + window.x*7.5, x_middle_left, "right")
  -- M
  love.graphics.printf("M", x, y + window.x*9, x_middle_left, "right")
  -- S
  love.graphics.printf("S", x, y + window.x*10.5, x_middle_left, "right")
  -- L
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.printf("L", x, y + window.x*12.5, x_middle_left, "right")
  -- Q
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.printf("Q", x, y + window.x*14.5, x_middle_left, "right")
  
  
  --
  -- ACTIONS
  --
  -- LEFT
  love.graphics.setNewFont("fonts/Roboto-Condensed.ttf", 25)  
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.printf("Go Left", x_middle_right, y, half_x, "left")
  -- RIGHT
  love.graphics.printf("Go Right", x_middle_right, y + window.x*1.5, half_x, "left")
  -- UP
  love.graphics.printf("Go Up", x_middle_right, y + window.x*3, half_x, "left")
  -- DOWN
  love.graphics.printf("Go Down", x_middle_right, y + window.x*4.5, half_x, "left")
  -- BOTTOM
  love.graphics.setNewFont("fonts/Roboto-Condensed.ttf", 24)  
  love.graphics.printf("Go Bottom", x_middle_right, y + window.x*6, half_x, "left")
  -- PAUSE
  love.graphics.setNewFont("fonts/Roboto-Condensed.ttf", 25)  
  love.graphics.printf("Pause", x_middle_right, y + window.x*7.5, half_x, "left")
  -- MUSIC
  love.graphics.setNewFont("fonts/Roboto-Condensed.ttf", 19)  
  love.graphics.printf("On/Off Music", x_middle_right, y + window.x*9.1, half_x, "left")
  -- SOUNDS
  love.graphics.setNewFont("fonts/Roboto-Condensed.ttf", 17)  
  love.graphics.printf("On/Off Sounds", x_middle_right, y + window.x*10.7, half_x, "left")
  -- TETRIS MODE
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf("Super/Regular Tetris", x_middle_right, y + window.x*12.3, half_x, "left")
  -- QUIT
  love.graphics.setNewFont("fonts/Roboto-Condensed.ttf", 25)
  love.graphics.setColor(255, 255, 0, 255)
  love.graphics.printf("Quit!", x_middle_right, y + window.x*14.5, half_x, "left")
end

-------------------------------------
-- printNewGame = PRINT NEW GAME 
-------------------------------------
function printNewGame()
  local h = #map
  local w = #map[#map]
  local x = window.x * 2
  local y = window.y * (h - 4)
  
  love.graphics.setNewFont("fonts/Mario-Kart-DS.ttf", 30)  
  love.graphics.setColor(255, 128, 0, 255)
  love.graphics.printf("NEW GAME", x, y, (window.x * (w-2)), 'center')
end

-------------------------------------
-- printPressStart = BLINKING PRESS START FOR A NEW GAME 
-------------------------------------
function printPressStart()
  local h = #map
  local w = #map[#map]
  local x = window.x * 2
  local y = window.y * (h - 2.5)
  
  love.graphics.setNewFont("fonts/Mario-Kart-DS.ttf", 20)  
  love.graphics.setColor(128, 0, 255, 255)
  love.graphics.printf("press", x, y, (window.x * (w-2)), 'center')
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf("SPACE", x, y + window.y, (window.x * (w-2)), 'center')
  love.graphics.setColor(128, 0, 255, 255)
  love.graphics.printf("to start", x, y + window.y*2, (window.x * (w-2)), 'center')
end

-------------------------------------
-- printPause = PRINT PAUSE
-------------------------------------
function printPause()
  local h = #map
  local w = #map[#map]
  local x = window.x * 2
  local y = window.y * (h/2)
  
  love.graphics.setNewFont("fonts/Roboto-Condensed.ttf", 40)  
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf("PAUSE", x, y, (window.x * (w-2)), 'center')
end

-------------------------------------
-- printGameOver = PRINT GAME OVER
-------------------------------------
function printGameOver()
  local h = #map
  local w = #map[#map]
  local x = window.x * 2
  local y = window.y * (h - 7)
  
  love.graphics.setNewFont("fonts/DoubleFeature20.ttf", 40)  
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.print("GAME OVER", x, y, -45)
  
  love.graphics.setNewFont("fonts/VCR_OSD_MONO.ttf", 40)  
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf(tostring(score.last), x + window.x * 2, y - window.y, (window.x * (w-2)), 'center')
end







-- **********************************
-- **********************************
-- ******** GRIDS UPDATES ***********
-- **********************************
-- **********************************

-------------------------------------
-- testMap = test if given pts of the current shape with the movement (x,y) it will fit in the grid without collision
-------------------------------------
function testMap(x, y)
  -- if no current shape : false
  if next(shape.pts) == nil then
    return false
  else
    local i
    local nb_pieces = 0
    
    -- for each point of the shape, apply (x,y) and check if the grid is free at this spot
    for i = 1, #shape.pts do
      local px = shape.pts[i][1]
      local py = shape.pts[i][2]
      
      if ((py + y) <= #map) and ((py + y) > 0) and
        ((px + x) <= #map[#map]) and ((px + x) > 0) then
          -- if free spot : +1 point correct
          if (map[py+y][px+x] ~= 1) then
            nb_pieces = nb_pieces + 1
          end
      end
    end
    
    -- if nb of free spots == nb of points : move correct
    return (nb_pieces == #shape.pts)
  end
end

-------------------------------------
-- updateMapDown = MOVES THE CURRENT SHAPE DOWN
-------------------------------------
function updateMapDown()
  if sounds.play_sounds == true then
    sounds.move:play()
  end
  
  local i 
  
  -- update position grid and color grid
  -- last position set to free
  for i = 1, #shape.pts  do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 0
    colors_map[y][x] = {0,0,0,0}
    shape.pts[i][2] = y + 1
  end
  
  -- new position set to busy
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 2 
    colors_map[y][x] = Colors[shape.nb] 
  end
end

-------------------------------------
-- updateMapLeft = MOVES THE CURRENT SHAPE LEFT
-------------------------------------
function updateMapLeft()
  if sounds.play_sounds == true then
    sounds.move:play()
  end
  
  local i

  -- update position grid and color grid
  -- last position set to free
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 0
    colors_map[y][x] = {0,0,0,0}
    shape.pts[i][1] = x - 1
  end
  
  -- new position set to busy
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 2 
    colors_map[y][x] = Colors[shape.nb] 
  end
end

-------------------------------------
-- updateMapRight = MOVES THE CURRENT SHAPE RIGHT
-------------------------------------
function updateMapRight()
  if sounds.play_sounds == true then
    sounds.move:play()
  end
  
  local i
  
  -- update position grid and color grid
  -- last position set to free
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 0
    colors_map[y][x] = {0,0,0,0}
    shape.pts[i][1] = x + 1
  end
  
  -- new position set to busy
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 2 
    colors_map[y][x] = Colors[shape.nb] 
  end
end

-------------------------------------
-- updateMapBottom = MOVES THE CURRENT SHAPE STRAIGHT TO THE BOTTOM OF THE GRID
-------------------------------------
function updateMapBottom()
  while testMap(0, 1) do
    updateMapDown()
  end
  
  if sounds.play_sounds == true then
    sounds.bottom:play()
  end
end

-------------------------------------
-- updateRotatedGrid = rotate current shape
-------------------------------------
function updateRotatedGrid(rotated_shape)
  if sounds.play_sounds == true then
    sounds.rotate:play()
  end
  
  -- last position set to free
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 0
    colors_map[y][x] = {0,0,0,0}
  end
  
  -- new position set to busy
  for i = 1, #rotated_shape do
    local x = rotated_shape[i][1]
    local y = rotated_shape[i][2]
    map[y][x] = 2
    colors_map[y][x] = Colors[shape.nb]
  end
  
  -- update rotate state and shape
  shape.pts = rotated_shape
  shape.rot_state = (shape.rot_state + 1) % 4
end

-------------------------------------
-- updateGrid = IF A LINE IS MADE, ERASES IT AND STACKS EVERYTHING ONE LEVEL DOWN & MAKES A NEW SQUARE
-------------------------------------
function updateGrid(res_lines)
  local i, k, v
 
 -- current shape stacked in the grid
  for i = 1, #shape.pts do
    local x = shape.pts[i][1]
    local y = shape.pts[i][2]
    map[y][x] = 1
  end
  
  -- for each line made
  for k, v in pairs(res_lines) do
    local line = v
    local h, w
    
    -- erase line made
    for w=1,#map[#map] do
      map[line][w] = 0
      colors_map[line][w] = {0,0,0,0}
    end
    
    -- drop everything else one step down
    for h=line,2,-1 do
      for w=1,#map[#map] do
        map[h][w] = map[h-1][w]
        colors_map[h][w] = colors_map[h-1][w]
      end
    end
    
    -- erase 1st line
    for w=1,#map[#map] do
      map[1][w] = 0
      colors_map[1][w] = {0,0,0,0}
    end
    
    if sounds.play_sounds == true then
      sounds.line:play()
    end
    
    -- update score
    score.current = score.current + factorial(#res_lines)
  end
end







-- **********************************
-- **********************************
-- ****** GAMEPLAY FUNCTIONS ********
-- **********************************
-- **********************************

-------------------------------------
-- gameOver = game is off. reset score and game
-------------------------------------
function gameOver()
  if sounds.play_sounds == true then
    sounds.game_over:play()
  end
  game.on = false
  game.over = true
  score.last = score.current
  resetGame()
end

-------------------------------------
-- rotateShape = if a rotation of the current shape is requested
------------------------------------- 
function rotateShape()
  -- to test if the rotation is valid, we use a temp shape
  -- deepCopy otherwise it will use the & of the shape if the struct Shapes
  local rotated_shape = deepCopy(shape.pts)
  
  -- which rotation to do
  local rotation = Rotations[shape.nb][shape.rot_state+1]
  local i
  
  -- make the rotation on the temp shape
  for i=1,#rotated_shape do
    rotated_shape[i][1] = rotated_shape[i][1] + rotation[i][1]
    rotated_shape[i][2] = rotated_shape[i][2] + rotation[i][2]
  end
  
  -- if the temp shape rotated fits the grid : temp -> current
  if gridOccupied(rotated_shape) == false then
    updateRotatedGrid(rotated_shape)
  end  
end

-------------------------------------
-- gridOccupied = if a rotation of the current shape is requested
------------------------------------- 
function gridOccupied(shape) 
  -- for each point of the temp shape
  for k, v in pairs(shape) do
    -- y
    local h = v[2]
    -- x
    local w = v[1]
    
    -- if (h,w) are out of boundaries of the grid or the spot is busy : rotation invalid
    if (h < 1) or (w < 1) or (h > #map) or (w > #map[#map]) or map[h][w] == 1 then
      return true
    end
  end
  
  -- otherwise rotation valid
  return false
end

-------------------------------------
-- checkForLine = IF A LINE IS COMPLETE RETURNS YES
-------------------------------------
function checkForLine()
  local h, w
  local nb_pixels = 0
  local res_lines = {}
  
  -- for each row
  for h=1,#map do
    nb_pixels = 0
    
    -- for each column of the current row
    for w=1,#map[#map] do
      -- if the spot is busy : +1
      if map[h][w] ~= 0 then
        nb_pixels = nb_pixels + 1
      end
    end
    
    -- if the nb of busy spots for the current row is nb of cells in the row : line made
    -- add nb of row for future update
    if nb_pixels == #map[#map] then
      table.insert(res_lines, h)
    end
  end
 
  return res_lines
end







-- **********************************
-- **********************************
-- ******** USEFUL FUNCTIONS ********
-- **********************************
-- **********************************

-------------------------------------
-- factorial = Recursive facto for a better score if several lines made at once
-------------------------------------
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
-- debugPrintMatrix = PRINTS THE MATRIX - POSITION GRID - FOR DEBUG
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

-------------------------------------
-- deepCopy = MAKES A DEEP COPY OF THE ORIGINAL TO CREATE A NEW OBJECT WITH A NEW ADDRESS
-------------------------------------
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
