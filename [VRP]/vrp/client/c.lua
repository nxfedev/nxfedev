cfg.commands = {
    ["/pos"] = {
        
      action = function(p,color,msg) 
        local user_id = vRP.getUserId({p})
        if vRP.hasPermission({user_id,"admin.cmd_pos"}) then
          CMDclient.getPlayerPosH(p,{},function(x,y,z,h)
            file = io.open("cmdPos.txt", "a")
            if file then
              file:write(GetPlayerName(p).." at ".."{" .. x .. "," .. y .. "," .. z .. "," .. h .. "} wrote: "..(msg or "").."\n")
            end
            file:close()
            TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "Location sent to file!")
          end)
        else
          TriggerClientEvent('chatMessage', p, "SYSTEM", {255, 0, 0}, "You don't have permission to execute this command!")
        end
      end