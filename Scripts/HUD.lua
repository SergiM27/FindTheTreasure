local Object = Object or require "Scripts/object"
local Grid = Grid or require 'Scripts/grid'

local Player = Player or require 'Scripts/player'

local HUD = Object:extend()

local bateryTime=1
function HUD:new(battery,x,y,level)
  self.battery = battery or 0
  self.x = x or 700
  self.y = y or 500
  self.level=level or 1
  self.layer=Layers.Hud
  self.gameOver = false
  self.win = false
  batteryS = love.audio.newSource("Battery.wav","static")
  treasure = love.audio.newSource("ChangeLevel.wav","static")
end



function HUD:update(dt)
  bateryTime=bateryTime-dt
  if(bateryTime<=0)then 
  self.battery=self.battery-1
  bateryTime=1
end
end


function HUD:draw()
 if(self.battery<=0) then
    self.gameOver = true
    actorList = {}
    table.insert(actorList, self)
  end

  if self.gameOver then 
     love.graphics.print(tostring("Game Over"),300,250)
  elseif self.win and self.gameOver==false then 
     self.win = true
     actorList = {}
     table.insert(actorList, self)
     love.graphics.print(tostring("Congratulations! You Win!"),145,250)
  elseif self.win==false and self.gameOver==false then
  love.graphics.print(tostring("Nivel ".. self.level),self.x,self.y)
  love.graphics.print(tostring("Bateria: " ..self.battery),self.x*5,self.y)
end
end
function HUD:recharge()
    batteryS:setVolume(0.8)
    batteryS:play()
    self.battery= self.battery + 10
    bateryTime=1

  end

  function HUD:ChangeLevel()
    actorList = {}
    table.insert(actorList, self)
    self.level = self.level + 1
    if self.level < 4 then
      if(self.battery < 10) then
        self.battery = 10
      elseif(self.battery > 30) then
        self.battery = 30
      end
      
      treasure:setVolume(0.8)
      treasure:play()
      grid = Grid(800, 600, 40, 30, 0,0, self.level)
      table.insert(actorList, grid)
      player = Player(30,30)
      goal = Actor('Textures/goal.png', 770,570,0,0,0, Layers.Pila)
      
    else
      self.win = true
    end
    
  end

return HUD