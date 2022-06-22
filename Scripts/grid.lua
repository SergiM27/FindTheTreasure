local Object = Object or require 'Scripts/object'
local Vector = Vector or require 'Scripts/vector'
local Maps = Maps or require 'Scripts/maps'
local Pila = Pila or require'Scripts/pila'
local Grid = Object:extend()

function Grid:new(sx, sy, tx, ty, x, y, map)

	
	self.tiles = Vector.new(tx, ty)
  self.Size = Vector.new(sx,sy)
	self.pos = Vector.new(x,y)
  self.tileSize = Vector.new(math.floor(self.Size.x / self.tiles.x), math.floor(self.Size.y / self.tiles.y))
	
  self.map = map
    self.grid = Grid:CreateGrid(self.tiles, map)
	
  	self.layer = Layers.Background

  	
end

function Grid:update(dt)
  
end

function Grid:draw()

  love.graphics.draw(love.graphics.newImage('Textures/background.png'), 0, 0, 0, 1, 1, 0, 0, 0, 0)


  for i = 1, self.tiles.x do
    for j = 1, self.tiles.y do
    	if self.grid.complete == true then
        
        if self.grid[j][i] == 2 then
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.rectangle('fill', (i - 1) * self.tileSize.x, (j - 1) * self.tileSize.y, self.tileSize.x, self.tileSize.y)
            love.graphics.setColor(1, 1, 1, 1)
        		
     		end
      end
    end
  end
end

function Grid:PosarBateries(graella)
  batPlaced = 0
  while batPlaced < 10 do
    local pos = Vector.new(math.random(1, 40), math.random(1, 30))
    
    if graella[pos.y][pos.x] == 1 then 
      local b = Pila(pos.x * 20, pos.y * 20)
      batPlaced = batPlaced +1
    end
  end
end




function Grid:CreateGrid(tiles, map)
  timer = os.time()
  start = os.time()
	local grid = {}
	if map == 1 then
  grid = Maps:map1()
   Grid:PosarBateries(Maps.map1())


  end
  if map == 2 then
  grid = Maps:map2()
  Grid:PosarBateries(Maps.map2())
  
  end
  if map == 3 then
  grid = Maps:map3()
  Grid:PosarBateries(Maps.map3())
  
  
  end
  if timer > start - 1 then
    grid.complete = true
   
    return grid
  end
	
end




function Grid:position(posCC)
  posCC = posCC - self.pos
  posGrid = Vector.new(math.floor(posCC.x / self.tileSize.x) + 1, math.floor(posCC.y / self.tileSize.y) +1)
  return posGrid
end

return Grid