Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

MySQL = module("vrp_mysql", "MySQL")



--- Ticket types 1 = admin, 2 = nhs, 3= pd

_G.Online_users = {}
server_tickets = {}
admin_coords = {}


-- server_tickets[caller_permid] = {Coords = {1,1,1}, Reason = 'whatever', }
--- vRP.hasPermission({user_id, admin.tickets})





RegisterNetEvent('callmanager:create_ticket')
AddEventHandler('callmanager:create_ticket',function(reason, call_type)
    local source = source
    local caller_ped = GetPlayerPed(source)
    local caller_coords = GetEntityCoords(caller_ped)
    local caller_name = GetPlayerName(source)
    local caller_id = vRP.getUserId({source})
    table.insert(server_tickets,{ticket_type = call_type ,ticket_reason = reason,player_name = caller_name,caller_perm = caller_id,caller_temp = source, coords = caller_coords})
    --- Call ur function here
    for k,v in ipairs(_G.Online_users) do
        if vRP.hasPermission({_G.Online_users[v], admin.tickets}) or vRP.hasPermission({_G.Online_users[v], police.drag}) or vRP.hasPermission({_G.Online_users[v], emscheck.revive}) then
            TriggerClientEvent('callmanger:recive_tickets_table', k, server_tickets)
        end
    end
end)


RegisterNetEvent('callmanager:take_ticket')
AddEventHandler('callmanager:take_ticket',function(ticket)
    local source = source
    if server_tickets[ticket] ~= source then
        TriggerEvent(discordwebhook_taketicket)
        --ExecuteCommand(staffon)
    else
        vRP.notify("You cannot take your own ticket")
    end
end)




RegisterNetEvent('callmanager:return_admin')
AddEventHandler('callmanager:return_admin',function(ticket)
    local source = source

end)





AddEventHandler('playerConnecting', function()
    local source = source
    local source_user_id = vRP.getUserId({source})
    _G.Online_users[source] = source_user_id
end)

AddEventHandler('playerDropped', function ()
   local source = source
   for k, v in pairs(server_tickets) do
      if server_tickets[k] == source then
        server_tickets[k] = nil
      end
   end
   _G.Online_users[source] = nil
end)


