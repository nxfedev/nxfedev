local plrsInServer = {}
local SelectedPerm = nil;
local SelectedGroup = nil;
local Buttons = {}
local MiscBtn = {}
local Groups = {}
local cfg = module('cfg/admin_menu')
RMenu.Add('vRPAdmin', 'main', RageUI.CreateMenu("", "Admin Menu ",1250,100))
RMenu.Add('vRPAdmin', 'players',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))
RMenu.Add('vRPAdmin', 'player_selected',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "players")))
RMenu.Add('vRPAdmin', 'groups',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "player_selected")))
RMenu.Add('vRPAdmin', 'groups_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "groups")))
RMenu.Add('vRPAdmin', 'misc',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))
RMenu.Add('vRPAdmin', 'staffopts', RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))
RMenu.Add('vRPAdmin', 'tpopts', RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))
RMenu.Add('vRPAdmin', 'EntitysDeleted',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
                RageUI.Button("Players", "", {}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "players"))
                RageUI.Button("Misc Options", "", {}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "misc"))
                RageUI.Button("Staff Options", "", {}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "staffopts"))

        end)
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'misc')) then 
        RMenu:Get('vRPAdmin', 'misc'):SetTitle('') 
        RMenu:Get('vRPAdmin', 'misc'):SetSubtitle("Misc Options")
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            
            for i,v in pairs(MiscBtn) do 
                RageUI.Button(i, v, {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        cfg.MiscButtons[i][1]()
                    end
                end)
            end
            RageUI.Button("Spawn Bike", "", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    SpawnVehicle('bmx')
                end
            end, RMenu:Get('vRPAdmin', 'misc'))
        end)
    end




    if RageUI.Visible(RMenu:Get('vRPAdmin', 'staffopts')) then 
        RMenu:Get('vRPAdmin', 'staffopts'):SetTitle('') 
        RMenu:Get('vRPAdmin', 'staffopts'):SetSubtitle("Staff Options")
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Button("Staff On", "", {}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "staffopts"))

        end)
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'players')) then
        RMenu:Get('vRPAdmin', 'players'):SetSubtitle("Online Players")
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for i,v in pairs(plrsInServer) do 
                RageUI.Button(v[2], "Perm ID: " .. i .. ' / Temp ID: ' .. v[1], {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        SelectedPerm = i
                        RMenu:Get('vRPAdmin', 'player_selected'):SetSubtitle("~r~Options for TempID: " .. v[1] .. ' | Name: ' .. v[2])
                    end
                end, RMenu:Get("vRPAdmin", "player_selected"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'player_selected')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for i,v in pairs(Buttons) do 
                RageUI.Button(i, "", {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        cfg.Buttons[i][1](SelectedPerm)
                    end
                end)
            end
            RageUI.Button('Players Groups', "", {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent('vRPAdmin:Groups', SelectedPerm)
                    RMenu:Get('vRPAdmin', 'groups'):SetSubtitle("~r~Groups for PermID: " .. SelectedPerm)
                end
            end, RMenu:Get("vRPAdmin", "groups"))
        end) 
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'groups')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for i,v in pairs(Groups) do 
                RageUI.Button(i, "", {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        SelectedGroup = i;
                    end
                end, RMenu:Get("vRPAdmin", "groups_manage"))
            end
        end) 
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'groups_manage')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Button('Remove Group', "", {}, true, function(Hovered, Active, Selected) 
                if Selected then
                    TriggerServerEvent('vRPAdmin:RemoveGroup', SelectedPerm, SelectedGroup)
                end
            end)
        end) 
    end

end)


RegisterCommand('openadminmenu', function()
    TriggerServerEvent('vRPAdmin:ReturnPlayers')
end, false)


RegisterKeyMapping('openadminmenu', 'Opens admin menu', 'keyboard', 'F2')



RegisterNetEvent('vRPAdmin:RecievePlayers')
AddEventHandler('vRPAdmin:RecievePlayers', function(table, perms, misc)
    plrsInServer = table
    Buttons = perms
    MiscBtn = misc
    RageUI.Visible(RMenu:Get('vRPAdmin', 'main'), not RageUI.Visible(RMenu:Get('vRPAdmin', 'main')))
end)

RegisterNetEvent('vRPAdmin:ReturnGroups')
AddEventHandler('vRPAdmin:ReturnGroups', function(groups)
    Groups = groups
end)


local Spectating = false;
local LastCoords = nil;
RegisterNetEvent('vRPAdmin:Spectate')
AddEventHandler('vRPAdmin:Spectate', function(plr,tpcoords)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
    if not Spectating then
        LastCoords = GetEntityCoords(playerPed) 
        if tpcoords then 
            SetEntityCoords(playerPed, tpcoords - 10.0)
        end
        Wait(300)
        targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
        if targetPed == playerPed then tvRP.notify('I mean you cannot spectate yourself...') return end
		NetworkSetInSpectatorMode(true, targetPed)
        SetEntityCollision(playerPed, false, false)
        SetEntityVisible(playerPed, false, 0)
		SetEveryoneIgnorePlayer(playerPed, true)	
		SetEntityInvincible(playerPed, true) 
        Spectating = true
        tvRP.notify('~r~Spectating Player.')
    else 
        NetworkSetInSpectatorMode(false, targetPed)
        SetEntityVisible(playerPed, true, 0)
		SetEveryoneIgnorePlayer(playerPed, false)
		SetEntityInvincible(playerPed, false)
		SetEntityCollision(playerPed, true, true)
        Spectating = false;
        SetEntityCoords(playerPed, LastCoords)
        tvRP.notify('Stopped Spectating Player.')
    end 
end)

RegisterNetEvent('vRPAdmin:TPTo')
AddEventHandler('vRPAdmin:TPTo', function(coords, plr)
    if coords then 
        SetEntityCoords(PlayerPedId(), coords)
    else 
        local targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
        local plrcoords = GetEntityCoords(targetPed)
        SetEntityCoords(PlayerPedId(), plrcoords)
    end
end)





function GetPlayers()
    local players = {}
    for _, i in ipairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end







RegisterNetEvent('vRPAdmin:Bring')
AddEventHandler('vRPAdmin:Bring', function(coords, plr)
    if coords then 
        SetEntityCoords(PlayerPedId(), coords)
    else 
        local targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
        local plrcoords = GetEntityCoords(targetPed)
        SetEntityCoords(PlayerPedId(), plrcoords)
    end
end)

function NetworkDelete(entity)
    Citizen.CreateThread(function()
        if DoesEntityExist(entity) and not (IsEntityAPed(entity) and IsPedAPlayer(entity)) then
            NetworkRequestControlOfEntity(entity)
            local timeout = 5
            while timeout > 0 and not NetworkHasControlOfEntity(entity) do
                Citizen.Wait(1)
                timeout = timeout - 1
            end
            DetachEntity(entity, 0, false)
            SetEntityCollision(entity, false, false)
            SetEntityAlpha(entity, 0.0, true)
            SetEntityAsMissionEntity(entity, true, true)
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
        end
    end)
end

RegisterNetEvent("vRPAdmin:EntityWipe")
AddEventHandler("vRPAdmin:EntityWipe", function(id)
    Citizen.CreateThread(function() 
        for k,v in pairs(GetAllEnumerators()) do 
            local enum = v
            for entity in enum() do 
                local owner = NetworkGetEntityOwner(entity)
                local playerID = GetPlayerServerId(owner)
                NetworkDelete(entity)
            end
        end
    end)
end)

local EntityCleanupGun = false;
RegisterNetEvent("vRPAdmin:EntityCleanupGun")
AddEventHandler("vRPAdmin:EntityCleanupGun", function()
    EntityCleanupGun = not EntityCleanupGun
    if EntityCleanupGun then 
        GiveWeaponToPed(PlayerPedId(), GetHashKey('WEAPON_PISTOL'), 250, false, true)
        tvRP.notify("~r~Entity cleanup gun enabled.")
    else 
        tvRP.notify("Entity cleanup gun disabled.")
        RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_PISTOL'))
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if EntityCleanupGun then 
            local plr = PlayerId()
            if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_PISTOL') then
                if IsPlayerFreeAiming(plr) then 
                    local yes, entity = GetEntityPlayerIsFreeAimingAt(plr)
                    if yes then 
                        EntitysDeleted[GetEntityModel(entity)] = true;
                        tvRP.notify('~r~Deleted Entity: ' .. GetEntityModel(entity))
                        NetworkDelete(entity)
                    end
                end 
            else 
                RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_PISTOL'))
                EntityCleanupGun = false;
                tvRP.notify("Entity cleanup gun disabled.")
            end 
        end
    end
end)


local KickActive = false;
local currenttime = 300; 

RegisterNetEvent('VRPAdmin:ActivateShutdown')
AddEventHandler('VRPAdmin:ActivateShutdown', function()
    KickActive = true;
end)

Citizen.CreateThread(function()
    while true do 
        Wait(1000)
        if KickActive then
            currenttime = currenttime - 1 
        end
    end
end)
function SpawnVehicle(VehicleName)
	local hash = GetHashKey(VehicleName)
	RequestModel(hash)
	local i = 0
	while not HasModelLoaded(hash) and i < 50 do
		Citizen.Wait(10)
		i = i + 1
	end
    if i >= 50 then
        return
	end
	local Ped = PlayerPedId()
	local Vehicle = CreateVehicle(hash, GetEntityCoords(Ped), GetEntityHeading(Ped), true, 0)
    i = 0
	while not DoesEntityExist(Vehicle) and i < 50 do
		Citizen.Wait(10)
		i = i + 1
	end
	if i >= 50 then
		return
	end
    SetPedIntoVehicle(Ped, Vehicle, -1)
    SetModelAsNoLongerNeeded(hash)
end
local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if KickActive then
            if HasScaleformMovieLoaded(scaleform) then
                PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                BeginTextComponent("STRING")
                AddTextComponentString("THIS SERVER IS SHUTTING DOWN IN: " .. currenttime .. " Seconds")
                EndTextComponent()
                PopScaleformMovieFunctionVoid()
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            end
        else 
            currenttime = 300
        end
    end
end)

