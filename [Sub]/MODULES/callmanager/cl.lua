vRP = Proxy.getInterface("vRP")



--ikklk
admin_tickets = {}






-- MENU STARTS HERE
RMenu.Add('callmanager', 'main', RageUI.CreateMenu("", '~b~Rogue Roleplay Call Manager', 1300, 0))
-- sub menus
RMenu.Add("callmanager", "admin", RageUI.CreateSubMenu(RMenu:Get("callmanager", "main",  1300, 0)))
RMenu.Add("callmanager", "police", RageUI.CreateSubMenu(RMenu:Get("callmanager", "main",  1300, 0)))
RMenu.Add("callmanager", "ems", RageUI.CreateSubMenu(RMenu:Get("callmanager", "main",  1300, 0)))



RegisterNetEvent("callmanger:recive_tickets_table")
AddEventHandler("callmanger:recive_tickets_table", function(ticket_table)
   admin_tickets = ticket_table
end)