io.stdout:setvbuf('no')

function love.conf(t)
  t.window.width = 800  
  t.window.height = 600
  t.console = false
  t.title = "Find the treasure!"
end
