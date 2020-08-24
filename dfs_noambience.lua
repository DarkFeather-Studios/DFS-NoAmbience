

local PlayersNearby = 1
local VehiclesInWorld
local AllPlayersInWorld

RegisterNetEvent("dfsna:GetSync")
AddEventHandler("dfsna:GetSync", function (GameTimeH, GameTimeM, GameTimeS, WeatherType)
    NetworkOverrideClockTime(GameTimeH, GameTimeM, GameTimeS)
    SetOverrideWeather(WeatherType)
end)

local function DisableHeadshots()
    SetPedSuffersCriticalHits(PlayerPedId(), false)
end

local function SetStunGunTime()
    SetPedMinGroundTimeForStungun(PlayerPedId(), 6000)
end

local function DisableAmbientOfficers()
    SetCreateRandomCops(0)
end

local function DisableHealthRecharge()
    SetPlayerHealthRechargeLimit(PlayerId(), 0)
end

local function EnableAmbientTrains()
    SwitchTrainTrack(0, true)   
    SwitchTrainTrack(3, true)   

    SetRandomTrains(1)
end

local function StartWeatherSync()
    ClearOverrideWeather()
    ClearWeatherTypePersist()

    TriggerServerEvent("dfsna:RequestSync")
end

local function StopPistolWhip()
    if IsPedArmed(PlayerPedId(), 6) then
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
    end
end

local function SetPopulationDensity(PlayersNearby)
    SetParkedVehicleDensityMultiplierThisFrame(1.0)
    SetRandomVehicleDensityMultiplierThisFrame(Config.dfs_noambience.PopulationMultiplierBase / (PlayersNearby+1))
    SetVehicleDensityMultiplierThisFrame(Config.dfs_noambience.PopulationMultiplierBase / (PlayersNearby+1))
    SetPedDensityMultiplierThisFrame(1.0)
    SetScenarioPedDensityMultiplierThisFrame(1.0, 1.0)
end

local function MPStoMPH(mps)
    return mps*2.23693629
end

local ThisFrame
local LastFrame
local damageBase
local armorDamage
local healthDamage
local currentArmor --TODO: Add screem fade, blur, screeching on impact
local currentVehicle
local lostSpeed
local function DealCarWreckDamage(amount, speedLost, WasNetworked)
    --if exports.disc_hud:IsSeatbeltOn() then
    --    amount = amount * 0.75
    --end
    if speedLost then
        currentArmor = exports.dfs_stats:GetStat("Armor")
        armorDamage = currentArmor >= amount * 0.34 and amount * 0.34 or currentArmor
        healthDamage = -math.random(math.floor((amount - armorDamage) / 2), math.ceil((amount - armorDamage) * 2))
        armorDamage = -math.random(math.floor(armorDamage), math.ceil(armorDamage*2))
        --print("COST "..healthDamage.."HP; "..armorDamage.." Armor" .. (WasNetworked and " FROM NETWORK " or ""))

        exports.dfs_stats:ModStat("Health", healthDamage) --In a 100mph crash, this can be 67-200 after armor is taken into account
        exports.dfs_stats:ModStat("Armor", armorDamage) --In a 100mph crash, this can be 33-66 from full armor
    else
        currentArmor = exports.dfs_stats:GetStat("Armor")
        armorDamage = currentArmor >= amount * 0.34 and amount * 0.34 or currentArmor
        healthDamage = -math.random(math.floor((amount - armorDamage) / 2), math.ceil((amount - armorDamage) * 2))
        armorDamage = -math.random(math.floor(armorDamage), math.ceil(armorDamage*2))
        --print("COST "..healthDamage.."HP; "..armorDamage.." Armor".. (WasNetworked and " FROM NETWORK " or ""))

        exports.dfs_stats:ModStat("Health", healthDamage)
        exports.dfs_stats:ModStat("Armor", armorDamage)
    end
end

local function GeforceDamage()
    currentVehicle = GetVehiclePedIsUsing(PlayerPedId())
    ThisFrame = MPStoMPH(GetEntitySpeed(PlayerPedId()))
    LastFrame = LastFrame or ThisFrame

    if LastFrame < ThisFrame - 20 then --Cause damage on sudden stop
        damageBase = ThisFrame - LastFrame
        lostSpeed = true
        --print("LastFrame; " .. tostring(LastFrame) .. "MPH -> ThisFrame; " .. tostring(ThisFrame) .. "MPH Losing "..LastFrame-ThisFrame.."MPH")
    elseif LastFrame - 20 > ThisFrame then --Cause damage on sudden lurch
        damageBase = LastFrame - ThisFrame - 15
        lostSpeed = false
        --print("LastFrame; " .. tostring(LastFrame) .. "MPH -> ThisFrame; " .. tostring(ThisFrame) .. "MPH Adding "..ThisFrame-LastFrame.."MPH")
    else
        LastFrame = ThisFrame 
        return
    end

    if not IsPedInAnyPlane(PlayerPedId()) and not IsPedInAnyHeli(PlayerPedId()) then
        if IsPedInAnyVehicle(PlayerPedId())  then --If you are in a car
            if GetPedInVehicleSeat(currentVehicle, -1) == PlayerPedId() then --If you are the driver
                DealCarWreckDamage(damageBase, lostSpeed) --Git rekt
                for i=0,GetVehicleModelNumberOfSeats(GetEntityModel(currentVehicle)),1 do --For each person in the car
                    if DoesEntityExist(GetPedInVehicleSeat(currentVehicle, i)) then --If there is an actual ped in the car's <i> seat
                        --print("Sent "..damageBase.."DMG to player "..GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(currentVehicle, i)))) --DEBUG
                        -- \/\/ Send network damage
                        TriggerServerEvent("dfs_noambience:DealCarwreckDamage", GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(currentVehicle, i))), damageBase, lostSpeed)
                    end
                end
            end
        else --If you are not in a car
            DealCarWreckDamage(damageBase, lostSpeed) --git rekt
        end
    end
    LastFrame = ThisFrame
end

RegisterNetEvent("dfs_noambience:DealtCarWreckDamage")
AddEventHandler("dfs_noambience:DealtCarWreckDamage", function(baseDamage, LostSpeed)
    DealCarWreckDamage(baseDamage, LostSpeed, true)
end)






local function RemoveGhostBannedCars()
    VehiclesInWorld = exports.dfs:GetAllVehicles()
    for k, Vehicle in pairs(VehiclesInWorld) do
        for k, BannedCar in pairs(Config.dfs_noambience.BannedCarModels) do
            if GetEntityModel(Vehicle) == GetHashKey(BannedCar.modelname) then --If car is banned
                if BannedCar.BannedFromSpawning then
                    --Citizen.Trace("Removed car banned from spawning "..BannedCar.modelname.."\n")
                    exports.dfs:DeleteVehicleAsync(Vehicle)
                    break
                elseif BannedCar.RemoveUntouched then
                    if  GetLastPedInVehicleSeat(Vehicle, -1) == 0 and
                        GetLastPedInVehicleSeat(Vehicle, 0) == 0 and
                        GetPedInVehicleSeat(Vehicle, -1) == 0 and
                        GetPedInVehicleSeat(Vehicle, 0) == 0
                        
                        then
                            --Citizen.Trace("Removed vehicle banned from spawning parked "..GetHashKey(Vehicle).."\n")
                            exports.dfs:DeleteVehicleAsync(Vehicle)
                            break
                    end
                end
            --[[else --Flag types: WasNetworked, WasDriven 
                if GetEntitySpeed(Vehicle) == 0 and not NetworkGetEntityIsNetworked(Vehicle) then
                    NetworkRegisterEntityAsNetworked(Vehicle)
                    --Citizen.Trace()
                    if not DoesEntityExist(GetLastPedInVehicleSeat(Vehicle, -1)) and GetVehicleNumberOfPassengers(Vehicle) == 0 then
                        NetworkRegisterEntityAsNetworked(CreateRandomPedAsDriver(Vehicle, true)
                        --Citizen.Trace("Excersized ghost car "..GetVehicleNumberPlateText(Vehicle).." ln:78\n")
                    end
                end

                --[[
                if GetLastPedInVehicleSeat(Vehicle, -1) ~= 0 then --There was a ped previously driving
                    if not IsPedAPlayer(GetLastPedInVehicleSeat(Vehicle, -1)) then --The last ped driving was NOT a player

                    end
                else --There was NOT a ped previously driving

                end
                
                not IsPedAPlayer(GetLastPedInVehicleSeat(Vehicle, -1)) and --The last ped driving was not a player
                DoesEntityExist(GetLastPedInVehicleSeat(Vehicle, -1)) and --The last ped in the car exists
                GetPedInVehicleSeat(Vehicle, -1) == 0 and   --There is not driver
                GetIsVehicleEngineRunning(Vehicle) and --Engine is on
                GetEntitySpeed(Vehicle) < 1 --Vehicle speed is less than 1
                then
                    NetworkRegisterEntityAsNetworked(Vehicle)
                    NetworkRegisterEntityAsNetworked(CreateRandomPedAsDriver(Vehicle, true)
                end]]
            end
        end
    end
end

local function AdjustPopulationMultiplier()
    AllPlayersInWorld = exports.dfs:GetAllPlayers()
    PlayersNearby = 0
    for k, PlayerNetworkIndex in pairs(AllPlayersInWorld) do
        if PlayerNetworkIndex and PlayerNetworkIndex ~= PlayerId() and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(PlayerNetworkIndex)), GetEntityCoords(PlayerPedId()), false) < 300 then
            PlayersNearby = PlayersNearby + 1
        end
    end
end

local function DisableAmbientPoliceEffects()
    CancelCurrentPoliceReport()
    DistantCopCarSirens(false)
end

local function DisablePowerfulHud()
        --https://runtime.fivem.net/doc/natives/?_0x6806C51AD12B83B8
        --HideAreaAndVehicleNameThisFrame()
        --HideHudComponentThisFrame(8)
        --HideHudComponentThisFrame(9)
        if not IsAimCamActive() or not IsFirstPersonAimCamActive() then --Reticle
            HideHudComponentThisFrame(14)
        end

        if IsHudComponentActive(6) then --Car name
            HideHudComponentThisFrame(6)
        end

        if IsHudComponentActive(7) then --location
            HideHudComponentThisFrame(7)
        end

        if IsHudComponentActive(9) then --Streetname
            HideHudComponentThisFrame(9)
        end

        if IsHudComponentActive(0) and not IsPedInAnyVehicle(GetPlayerPed( -1 ), true) then 
            HideHudComponentThisFrame(0) --"HUD"?
        end
        --[[Q for...HUD?
        if IsControlPressed(0,44) then
            DisplayHud(1)
        else
            DisplayHud(0)
        end]]

        --HideHudComponentThisFrame(20)
    
        DisplayAmmoThisFrame(false)
end

function onStartup()
    --SetRadarZoom(200)
    DisableAmbientOfficers()
    DisableHealthRecharge()
    EnableAmbientTrains()
    DisableHeadshots()
    SetStunGunTime()
    --SetAllVehicleGeneratorsActive()
end

function onFrame()
    SetPedConfigFlag(PlayerPedId(), 35, false) --To prevent auto-motorcycle helmet

    SetPopulationDensity(PlayersNearby)
    DisableAmbientPoliceEffects()
    DisablePowerfulHud()
    StopPistolWhip()
    N_0x9e4cfff989258472() --Disbales vehicle idle camera
    InvalidateIdleCam()
    DisablePlayerVehicleRewards(PlayerId())
    GeforceDamage()
end

local Success = false
local CurrentVehicle
local CurrentVehicleClassID
local DefaultBoostData
local CarDefaults = {}
local ModelName
function onSecond()
    CurrentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if DoesEntityExist(CurrentVehicle) then
        ModelName = GetDisplayNameFromVehicleModel(GetEntityModel(CurrentVehicle))
        CurrentVehicleClassID = GetVehicleClass(CurrentVehicle)
        DefaultBoostData = Config.dfs_noambience.DefaultClassBoosts[CurrentVehicleClassID]
        CurrentModelBoostData = Config.dfs_noambience.DefaultModelBoosts[ModelName] or Config.dfs_noambience.DefaultModelBoosts["NIL"]
        if CarDefaults[ModelName] == nil then
            CarDefaults[ModelName] = {} 
        end

        ----Citizen.Trace("Vehicle: ^5" .. CurrentModel .. "^7 Class: ^4" .. DefaultBoostData.className .. "^7 Torque: ^3" .. torqueBoost .. "^7 initialForce: ^2" .. iDFBoost .. "^7\n")

        -- Will set these values based on class in the config.

        for k, v in pairs(DefaultBoostData) do
            if type(v) == "number" and k ~= "torque" and k ~= "initialDriveForce" then
                if not CarDefaults[ModelName][k] then
                    --print("Adding new default entry for the "..ModelName.."'s "..k.."...")
                    CarDefaults[ModelName][k] = GetVehicleHandlingFloat(CurrentVehicle, "CHandlingData", k)
                end
                --                      The vehicle you ar driving  STay this        Handling Field Name ("torque") META File                        Class                  This Car's Model
                SetVehicleHandlingFloat(CurrentVehicle,             "CHandlingData", k,                             CarDefaults[ModelName][k] + DefaultBoostData[k] + CurrentModelBoostData[k])
            end
        end

        SetVehicleCheatPowerIncrease(CurrentVehicle, DefaultBoostData.torque + CurrentModelBoostData.torque) --second is torque. 1.0 is default.  but range is between 0.2 and 1.8 according to docs
        ModifyVehicleTopSpeed(CurrentVehicle, DefaultBoostData.initialDriveForce + CurrentModelBoostData.initialDriveForce)
    end

    ResetPlayerStamina(PlayerId())
    RemoveGhostBannedCars()
    AdjustPopulationMultiplier()
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
    SetGarbageTrucks(true)
end

AddEventHandler("onClientResourceStart", function (resourcename) --WORK ON THIS BEFORE PUSH
    if resourcename == GetCurrentResourceName() then
        StartWeatherSync()
                
        Wait(100)

        local LastDidSecondTick = 0
        local LastTick2 = 0
        while true do
            if LastDidSecondTick + 996 < GetGameTimer() then
                onSecond()
                LastDidSecondTick = GetGameTimer()
            end

            if LastTick2 + 19996 < GetGameTimer() then
                StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
                LastTick2 = GetGameTimer()
            end
            
            onFrame()
            Wait(0)
        end
    end
end)

AddEventHandler("playerSpawned", function()
    Wait(2500)
    onStartup()
end)

TriggerEvent('chat:addSuggestion', '/settime', 'ADMIN: Sets daytime, map-wide', {
    { name="Hour <int>", help="Hour of the day, 0-23" },
    { name="Minute <int>", help="Minute of the day 0-59" }
})

TriggerEvent('chat:addSuggestion', '/setweather', 'ADMIN: Sets map-wide weather conditions', {
    { name="WeatherType <string>", help="Weather to the map set to" }
})
--[[
RegisterNetEvent("entityCreated")
RegisterNetEvent("entityCreating")
RegisterNetEvent("entityRemoved")

AddEventHandler("entityCreated", function(...)
    print("entityCreated Data: "..json.encode(...))
end)


AddEventHandler("entityCreating", function(...)
    print("entityCreating Data: "..json.encode(...))
end)


AddEventHandler("entityRemoved", function(...)
    print("entityRemoved Data: "..json.encode(...))
end)]]
