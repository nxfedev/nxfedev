local cfg = {}

cfg.Buttons = {
    ["Ban"] = {function(self)
    local reason = nil
    local hours = nil
    AddTextEntry('FMMC_MPM_NC', "Enter Reason for Ban Player")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        if result then 
            reason = result
        end
    end
    AddTextEntry('FMMC_MPM_NC', "Enter Hours for Ban (-1 is perm ban)")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        if result then 
            hours = tonumber(result)
        end
    end
    TriggerServerEvent('vRPAdmin:Ban', self, hours, reason)
    end, "player.ban"},
    ["Kick"] = {function(self)
    AddTextEntry('FMMC_MPM_NC', "Enter Reason to Kick Player")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        if result then 
            result = result
            TriggerServerEvent('vRPAdmin:Kick', self, result, false)
        end
    end
    end, "player.kick"},
    ["No Warning Kick"] = {function(self)
        AddTextEntry('FMMC_MPM_NC', "Enter Reason to Kick Player")
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            if result then 
                result = result
                TriggerServerEvent('vRPAdmin:Kick', self, result, true)
            end
        end
    end, "player.kick"},
    ["Revive"] = {function(self)
        TriggerServerEvent('vRPAdmin:Revive', self)
    end, "player.revive"},
    ["Slap"] = {function(self)
        TriggerServerEvent('vRPAdmin:SlapPlayer', self)
    end, "player.slap"},
    ["Spectate"] = {function(self)
        TriggerServerEvent('vRPAdmin:SpectatePlr', self)
    end, "player.spectate"},
    
    ["Add Car"] = {function(self)
        AddTextEntry('FMMC_MPM_NC', "Enter the car spawncode")
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            if result then 
                TriggerServerEvent('vRPAdmin:AddCar', self, result)
            end
        end
    end, "player.addcar"},
    ["TP To Player"] = {function(self)
        TriggerServerEvent('vRPAdmin:TPTo', self)
    end, "player.tpto"},
    ["Teleport player to Admin Island"] = {function(self)
        TriggerServerEvent('vRPAdmin:AdminTP', self)
    end, "player.tpto"},
    ["Bring Player"] = {function(self)
        TriggerServerEvent('vRPAdmin:Bring', self)
    end, "player.tpbring"},
    ["Add Group"] = {function(self)
        AddTextEntry('FMMC_MPM_NC', "Enter the group name")
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            if result then 
                TriggerServerEvent('vRPAdmin:AddGroup', self, result)
            end
        end
    end, "player.addGroups"},
    ["Warn Player"] = {function(self)
        userWarningMessage = getWarningUserMsg()
        if userWarningMessage then
            TriggerServerEvent("vrp:warnPlayer",self,userWarningMessage)
        else
            tvRP.notify('Please enter a warning message!')
        end
    end, "player.kick"},
    
    ["Show Warnings"] = {function(self)
    ExecuteCommand("showwarnings "..tostring(self))
    end, "player.kick"},
}

--vRP:RemoveWarning
cfg.MiscButtons = {
    ["Entity Cleanup"] = {function(self)
        TriggerServerEvent('vRPAdmin:PropCleanup')
    end, "player.propcleanup", "Gets rid of those pesky modders ramps! (Onesync)"},

    ["Remove Warning"] = {function(self)
        AddTextEntry('FMMC_MPM_NC', "Enter the WarningID")
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            if result then 
                TriggerServerEvent('vRP:RemoveWarning', result)
            end
        end
    end, "admin.removewarning", "Removes a warning"},

    ["Entity Cleanup Gun"] = {function(self)
        TriggerServerEvent('vRPAdmin:EntityCleanupGun')
    end, "player.propcleanup", "Makes your current Gun a Cleanup Gun! Deletes anything you aim at"},

    ["Deattach Entity Cleanup"] = {function(self)
        TriggerServerEvent('vRPAdmin:DeAttachEntity')
    end, "player.propcleanup", "Gets rid of those pesky attached hamburgers! (Onesync)"},

    ["Vehicle Cleanup"] = {function(self)
        TriggerServerEvent('vRPAdmin:VehCleanup')
    end, "player.vehcleanup", "Gets rid of those vehicles! (Onesync)"},

    ["Ped Cleanup"] = {function(self)
        TriggerServerEvent('vRPAdmin:PedCleanup')
    end, "player.pedcleanup", "Gets rid of those peds! (Onesync)"},

    ["All Cleanup"] = {function(self)
        TriggerServerEvent('vRPAdmin:CleanAll')
    end, "player.cleanallcleanup", "When your server is so fucked you need to cleanup everything. (Onesync)"},
    ["TP to Waypoint"] = {function(self)
        TriggerEvent("TpToWaypoint")
    end, "player.tptowaypoint", "Teleports you to a waypoint"},

    ["Noclip"] = {function(self)
        tvRP.toggleNoclip({})
    end, "player.noclip", "Teleports you to a waypoint"},
}
return cfg
