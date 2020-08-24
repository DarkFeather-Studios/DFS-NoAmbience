local GameH = 23 --1hr is 120s, 1d is 2880s/48m
local GameM = 30 --1m is 2s
local GameS = 0 --1s is 1/30s
local GameW = "CLEARING"
local Cycles = 1
local HasResetShit = false
local LastSetTime = 0
local Manual = 0

--INSERT INTO metrics_weather (`weather_type`) VALUES ('SUNNY')

AddEventHandler("onServerResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DatabaseUpdateAutomate()
    end
end)


RegisterNetEvent("dfsna:RequestSync")
AddEventHandler("dfsna:RequestSync", function ()
    while LastSetTime < 2000 do Wait(0) end
    TriggerClientEvent("dfsna:GetSync", -1, GameH, GameM, GameS, GameW)
end)

function GetNewWeatherType()
    -- CHANCES: Per day: Thunder; 1/80 3c, rain; 3/80 1c, smog 2/80 3c, rest sunny, using 6/80
    local Randint = math.random(240) --1million

    Manual = 0
    if Randint == 240 then 
        GameW = "THUNDER"
        Cycles = 2
    elseif Randint > 237 then
        GameW = "SMOG"
        Cycles = 1
    elseif Randint > 234 then GameW = "RAIN"
    elseif Randint > 156 then GameW = "CLOUDS"
    elseif Randint > 78 then GameW = "OVERCAST"
    else GameW = "EXTRASUNNY"
    end
    MySQL.Async.execute("INSERT INTO metrics_weather (`weather_type`) VALUES (@Gamew)", {Gamew = GameW} )
end

Citizen.CreateThread(function ()

    while true do
        local _GT = GetGameTimer()
        if LastSetTime + 2000 < _GT then
            LastSetTime = ((_GT) - (_GT % 2000))
            GameM = GameM + 1
            if GameM == 60 then
                GameM = 0
                GameH = GameH + 1
                if GameH == 24 then GameH = 0 end
            end
        end

        if GameH % 3 == 0 and not HasResetShit then 
            if Cycles == 0 then
                GetNewWeatherType()
                TriggerClientEvent("dfsna:GetSync", -1, GameH, GameM, GameS, GameW) --failed sometimes, arg 1 was null
            else 
                Cycles = Cycles - 1
                MySQL.Async.execute("INSERT INTO metrics_weather (`weather_type`, `manual`) VALUES (@Gamew, @Man)", {Gamew = GameW, Man = Manual} )
            end
            HasResetShit = true
        elseif GameH % 3 ~= 0 then HasResetShit = false
        end

        Wait(60)
    end
    
end)

RegisterCommand("setweather", function (source, args, raw)
    if not exports.db_perms:HasPermission_sv(source, "setweather", 998) then 
        return 
    end
    if #args ~= 1 then 
        TriggerClientEventEvent("alerts:add", source, {255, 255, 255}, {255, 74, 0}, "setweather", "Usage: /setweather <WEATHER_TYPE (string)>")
        return
    end
    GameW = args[1]
    TriggerClientEvent("dfsna:GetSync", -1, GameH, GameM, GameS, GameW)
    Cycles = 1
    Manual = 1
    MySQL.Async.execute("INSERT INTO metrics_weather (`weather_type`, `manual`) VALUES (@Gamew, @Man)", {Gamew = GameW, Man = Manual} )
end)

RegisterCommand("settime", function (source, args, raw)
    if not exports.db_perms:HasPermission_sv(source, "settime", 998) then 
        return 
    end
    if #args == 0 then 
        TriggerClientEventEvent("alerts:add", source, {255, 255, 255}, {255, 74, 0}, "settime", "Usage: /settime <hour (int)> <minute (int)>")
        return
    end
    GameH = tonumber(args[1]) % 24
    if args[2] ~= nil then GameM = tonumber(args[2]) % 60 end
    TriggerClientEvent("dfsna:GetSync", -1, GameH, GameM, GameS, GameW)
end)

RegisterCommand("clearday", function (source, args, raw)
    ExecuteCommand("setweather clear")
    ExecuteCommand("settime 8")
end)


RegisterNetEvent("dfs_noambience:DealCarwreckDamage")
AddEventHandler("dfs_noambience:DealCarwreckDamage", function(targetPlayer, damage, lostSpeed)
    --print("Sending "..damage.." CarWreckDamage to "..targetPlayer)
    TriggerClientEvent("dfs_noambience:DealtCarWreckDamage", targetPlayer, damage, lostSpeed)
end)

function DatabaseUpdateAutomate()
end

--[[
RegisterNetEvent("entityCreated")
RegisterNetEvent("entityCreating")
RegisterNetEvent("entityRemoved")

local vehiclesInWorld = {}
AddEventHandler("entityCreated", function(...)
    print("entityCreated Data: "..json.encode(...) .. " NetID: "..NetworkGetNetworkIdFromEntity(...) .. " entityModel: "..GetEntityModel(...).. " vehiclesInWorld: "..GetVehiclesInWorld()) --Is `...` an entity number or a networkID?
    vehiclesInWorld[NetworkGetNetworkIdFromEntity(...)] = ...
end)


AddEventHandler("entityCreating", function(...)
    print("entityCreating Data: "..json.encode(...) .. " NetID: "..NetworkGetNetworkIdFromEntity(...) .. " entityModel: "..GetEntityModel(...)) --Is `...` an entity number or a networkID?

end)


AddEventHandler("entityRemoved", function(...)
    print("entityRemoved Data: "..json.encode(...) .. " NetID: "..NetworkGetNetworkIdFromEntity(...) .. " entityModel: "..GetEntityModel(...).. " vehiclesInWorld: "..GetVehiclesInWorld()) --Is `...` an entity number or a networkID?
    vehiclesInWorld[NetworkGetNetworkIdFromEntity(...)] = nil
end)

function GetVehiclesInWorld()
    local ind = 0
    for k, v in pairs(vehiclesInWorld) do
        if v then
            ind = ind + 1
        end
    end
    return ind
end]]