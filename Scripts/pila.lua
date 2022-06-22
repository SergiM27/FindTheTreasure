local Actor = Actor or require'Scripts/actor'
local Vector = Vector or require'Scripts/vector'

local Pila = Actor:extend()


function Pila:new(x,y)
	Pila.super.new(self, 'Textures/pila.png', x, y, 0,0,0,Layers.Pila)
	self.position = self.position - Vector.new(10,10)
end


function Pila:update(dt)
	
end

function Pila:draw()
	Pila.super.draw(self)
end
return Pila