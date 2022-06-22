Actor = Actor or require 'Scripts/actor'
Vector = Vector or require 'Scripts/vector'
local Pila = Pila or require 'Scripts/pila'

local Player = Actor:extend()

function Player:new(x,y)
  Player.super.new(self,nil, x, y, 170, 0.2, 0.2,Layers.Player)
  self.dir = "down"
end

function Player:update(dt, grid)
  
  self:move(dt, grid)
  self:checkCollisions()
  if grid:position(self.position) == Vector.new(39, 29) then 
    Hud:ChangeLevel() 
  end
end


function Player:draw()
  if(self.dir == "up") then
    love.graphics.draw(love.graphics.newImage('Textures/minerou.png'), self.position.x-10, self.position.y-10)
  elseif(self.dir == "down") then
    love.graphics.draw(love.graphics.newImage('Textures/minerod.png'), self.position.x-10, self.position.y-10)
  elseif(self.dir == "left") then
    love.graphics.draw(love.graphics.newImage('Textures/minerol.png'), self.position.x-10, self.position.y-10)
  elseif(self.dir == "right") then
    love.graphics.draw(love.graphics.newImage('Textures/mineror.png'), self.position.x-10, self.position.y-10)
  end

  love.graphics.draw(love.graphics.newImage('Textures/darkness.png'), self.position.x, self.position.y, 0, 2, 2, 400,300)
  
end

function Player:checkCollisions()

  for _, v in pairs(actorList) do
    
    if v:is(Pila) then
      local distance = v.position - self.position

      distance = distance:lenSq()
      
      if distance < 300 then 
        Hud:recharge()
        v:Destroy()
      end
      
    end
    
  end
  
end

function Player:move(dt, grid)
  if love.keyboard.isDown('up') then
    self.forward = Vector.new(0,-1)
    self.dir = "up"

  end
  if love.keyboard.isDown('down') then
    self.forward = Vector.new(0,1)
    self.dir = "down"

 end
  
  

  if love.keyboard.isDown('left') then
    self.forward = Vector.new(-1,0)
    self.dir = "left"
 end
  if love.keyboard.isDown('right') then
    self.forward = Vector.new(1,0)
    self.dir = "right"

  end
  if love.keyboard.isDown('up') or love.keyboard.isDown('down') or love.keyboard.isDown('left') or love.keyboard.isDown('right') then
  else
    self.forward = Vector.new(0,0)
 
  end

  local gridpos = grid:position(self.position + self.forward * self.speed * dt)
  
    if grid.grid[gridpos.y][gridpos.x] == 1 then
      self.position = self.position + self.forward * self.speed * dt
    end

 
end

return Player
