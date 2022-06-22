
if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio

actorList = {}  --Lista de elementos de juego
local Vector = Vector or require "Scripts/vector"
local Actor = Actor or require 'Scripts/actor'
local Grid = Grid or require 'Scripts/Grid'
local Player = Player or require 'Scripts/player'
local Pila = Pila or require'Scripts/pila'

local HUD = HUD or require 'Scripts/HUD'

Layers = {Background = 0, Pila = 1 ,Player = 2, Hud = 3}

Hud=HUD(15,100,550,1)
function love.load()

      math.randomseed(os.time())
      font = love.graphics.newFont("font.ttf",60)
      love.graphics.setFont(font)
      song = love.audio.newSource("Song.wav","stream")
      song:setVolume(0.7)
      song:setLooping(true)
      song:play()
      grid = Grid(800, 600, 40, 30, 0,0, 1)
      table.insert(actorList, grid)
      player = Player(30,30)
      table.insert(actorList,Hud)
      goal = Actor('Textures/goal.png', 770,570,0,0,0, Layers.Pila)
end

function love.update(dt)
      for _,v in ipairs(actorList) do
        v:update(dt, grid)
        end

end

function love.draw()
  for i = 0, 4 do
    for _,v in ipairs(actorList) do
      if v.layer == i then 
        v:draw()
      end
    end
  end
end