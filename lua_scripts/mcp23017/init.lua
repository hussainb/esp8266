-- make ist fast :)
--uart.setup(0,115200,8,0,1,1,PERMANENT)

mcp = require("mcp23017")
mcp.init(3,4)
-- set pin to input
mcp.setUpPin(9,1,1)

start = -1

function showButtons()
  local state = mcp.getPin(9)

  if(state == 0)then
    local now =  tmr.now()
    local diff = tmr.now() - start
    if(start < 0 or diff > 1000000) then
      print(wifi.STATION)
      local ledState = mcp.getPin(1)
      if(ledState == 0) then
        mcp.setPin(1,1)
      else
      mcp.setPin(1,0)
      end
      start = now
    end  
  else  
    start = -1
    
  end  
end
tmr.alarm(0,50,1,showButtons) -- run showButtons() every 2 seconds
